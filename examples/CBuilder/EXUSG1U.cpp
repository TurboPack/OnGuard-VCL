/*
  This example uses the TOgUsageCode component. This is the most basic
  example in that on first run, the INI file entries and component
  properties are set to allow 5 runs of the program with a "drop dead"
  date of 1999 December 31.
*/
//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExUsg1U.h"
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
void __fastcall TForm1::OgUsageCode1GetKey(TObject *Sender, TKey &Key)
{
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode1GetCode(TObject *Sender, TCode &Code)
{
	String S;
	TheDir = ExtractFilePath(ParamStr(0));
  int L = TheDir.Length();
  if (L > 3 && TheDir[L] != '\\')
    TheDir = TheDir + '\\';

  if (FileExists(TheDir + "Usage1.INI")) {
    // open Ini File
    IniFile = new TIniFile(TheDir + "Usage1.INI");
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
void __fastcall TForm1::OgUsageCode1Checked(TObject *Sender, TCodeStatus Status)
{
  String S;
  TCode Code;
  switch (Status) {
    case ogValidCode : {
    	Label1->Caption = "Available Runs: "
                       + String((int)OgUsageCode1->GetValue());
      return;
    }
    case ogRunCountUsed : S = "No more runs allowed\r\n"
                              "    Register NOW    "; break;
    case ogInvalidCode  : {
      if (!FileExists(TheDir + "Usage1.INI")) {
        IniFile = new TIniFile(TheDir + "Usage1.INI");
        try {
          // hard coded release code for 5 users
          // and drop dead date of 1999 Dec-> 31
          S = "AC5D76E4B10D642B";
          HexToBuffer(S, &Code, sizeof(Code));
          IniFile->WriteString("Codes", "Uses", S);
        }
        catch (...) {
          delete IniFile;
          IniFile = 0;
        }
        delete IniFile;
        OgUsageCode1->CheckCode(true);
        return;
      }
      else {
        S = "Invalid Code";
      	break;
      }
    }
    case ogCodeExpired  : S = "Trial Run period expired\r\n"
                              "      Register NOW      ";
  }
  ShowMessage(S);
  Application->Terminate();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode1ChangeCode(TObject *Sender, TCode &Code)
{
  String S;
  // open Ini File
  IniFile = new TIniFile(TheDir + "Usage1.INI");
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