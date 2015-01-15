//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExRgStrU.h"
//---------------------------------------------------------------------------
#pragma link "OnGuard"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgRegistrationCode1GetKey(TObject *Sender, TKey &Key)
{
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgRegistrationCode1GetCode(TObject *Sender, TCode &Code)
{
  TheDir = ExtractFilePath(ParamStr(0));
  int L = TheDir.Length();
  if (L > 3 && TheDir[L] != '\\')
    TheDir = TheDir + '\\';

  if (FileExists(TheDir + "RegCode.INI")) {
    IniFile = new TIniFile(TheDir + "RegCode.INI");
    try {
      CodeStr = IniFile->ReadString("Codes", "RegCode", "");
      HexToBuffer(CodeStr, &Code, sizeof(Code));

      ARegStr = IniFile->ReadString("Codes", "RegStr", "");
    }
    catch (...) {
    	delete IniFile;
      IniFile = 0;
    }
    delete IniFile;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgRegistrationCode1Checked(TObject *Sender,
	TCodeStatus Status)
{
	String S;
  String C1;
  TCode TC;
  // forced cutoff date of 1999 Dec 31
  ED = EncodeDate(1999, 12, 31);

  switch (Status) {
    case ogValidCode : {
      InitRegCode(CKey, ARegStr, ED, TC);
      C1 = BufferToHex(&TC, sizeof(TC));

      if (CompareText(C1, CodeStr) != 0) {
        ShowMessage("The Registration Name has been changed");
        Application->Terminate();
      }
      else
        Label1->Caption = "Registered to: " + ARegStr;
      break;
    }
    case ogInvalidCode : {
      if (!FileExists(TheDir + "RegCode.INI")) {
        if (InputQuery("Codes", "Reg String", ARegStr)) {
          if (ARegStr == "") {
            S = "Empty string not allowed";
            Application->Terminate();
          }
          else {
            IniFile = new TIniFile(TheDir + "RegCode.INI");
            try {
              IniFile->WriteString("Codes", "RegStr", ARegStr);
              InitRegCode(CKey, ARegStr, ED, TC);
              // save string representation of release code to Ini File
              CodeStr = BufferToHex(&TC, sizeof(TC));
              IniFile->WriteString("Codes", "RegCode", CodeStr);
            }
            catch (...) {
              delete IniFile;
              IniFile = 0;
            }
            delete IniFile;
            OgRegistrationCode1->CheckCode(true);
            return;
          }
        }
        else
          Application->Terminate();
      }
      else
        S = "Invalid Code";
      break;
    }
    case ogCodeExpired : S = "Evaluation period expired";
  }

  if (Status != ogValidCode) {
    ShowMessage(S);
    Application->Terminate();
  }
}
//---------------------------------------------------------------------------