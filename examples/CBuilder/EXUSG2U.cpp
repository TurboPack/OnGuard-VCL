/*
  This example uses the TOgUsageCode component.

  If the program is run the first time, an InputQuery dialog is
  displayed. The user would call you to register. You would give
  them a release code (using, e.g., CODEGEN) for a given number of
  uses and, if desired, "drop date" or some other modifier.
*/
//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExUsg2U.h"
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
void __fastcall TForm1::OgUsageCode2GetKey(TObject *Sender, TKey &Key)
{
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode2GetCode(TObject *Sender, TCode &Code)
{
	String S;
	TheDir = ExtractFilePath(ParamStr(0));
  int L = TheDir.Length();
  if (L > 3 && TheDir[L] != '\\')
    TheDir = TheDir + '\\';

  if (FileExists(TheDir + "Usage2.INI")) {
    // open Ini File
    IniFile = new TIniFile(TheDir + "Usage2.INI");
    try {
      // try to read release code
      S = IniFile->ReadString("Codes", "Uses", "");

      // convert retrieved string to a code
      HexToBuffer(S, &Code, sizeof(Code));
    }
    catch (...) {
      delete IniFile;
      IniFile = 0;
    }
    delete IniFile;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode2Checked(TObject *Sender, TCodeStatus Status)
{
  String S;
  TCode Code;
  switch (Status) {
    case ogValidCode : {
    	Label1->Caption = "Available Runs: "
                       + String((int)OgUsageCode2->GetValue());
      return;
    }
    case ogRunCountUsed : S = "No more runs allowed\r\n"
                              "    Register NOW    "; break;
    case ogInvalidCode  : {
      if (!FileExists(TheDir + "Usage2.INI")) {
        S = "";
        if (InputQuery("Call Vendor NOW", "Code", S)) {
          if (HexToBuffer(S, &Code, sizeof(Code))) {
            IniFile = new TIniFile(TheDir + "Usage2.ini");
            try {
              IniFile->WriteString("Codes", "Uses", S);
            }
            catch (...) {
              delete IniFile;
              IniFile = 0;
            }
            delete IniFile;
            OgUsageCode2->CheckCode(true);
            return;
          }
          else
            S = "Invalid Code entered";
        }
        else
          S = "No Code entered";
      }
      else
        S = "Invalid Code";
     	break;
    }
    case ogCodeExpired  : S = "Trial Run period expired\r\n"
                              "      Register NOW      ";
  }
  ShowMessage(S);
  Application->Terminate();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode2ChangeCode(TObject *Sender, TCode &Code)
{
  String S;
  if (!FileExists(TheDir + "Usage2.ini"))
    return;

  // open Ini File
  IniFile = new TIniFile(TheDir + "Usage2.INI");
  try {
    // convert code to string
    S = BufferToHex(&Code, sizeof(Code));
    IniFile->WriteString("Codes", "Uses", S);
  }
  catch (...) {
    delete IniFile;
    IniFile = 0;
  }
  delete IniFile;
}
//--------------------------------------------------------------------------- 