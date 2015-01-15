/*
  This program uses the TOgDaysCode component. The first time the
  program is run, the necessary information is created and stored
  in an INI file. In addition, the program is given a "drop dead"
  date, i.e., regardless of how many days the program has been used,
  it cannont be used after that date (1999 December 31).
*/
//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExDys30U.h"
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
void __fastcall TForm1::OgDaysCode1GetKey(TObject *Sender, TKey &Key)
{
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgDaysCode1GetCode(TObject *Sender, TCode &Code)
{
  String S;
  TDateTime Expires;
  // force the INI file to be in the same directory as the application
  String TheDir = ExtractFilePath(ParamStr(0));
  int L = TheDir.Length();
  if (L > 3 && TheDir[L] != '\\')
    TheDir = TheDir + '\\';

  // open Ini File
  TIniFile* IniFile = new TIniFile(TheDir + "Days30.INI");
  try {
    // try to read release code
    S = IniFile->ReadString("Codes", "DaysCode", "NoCode");

    // If default string returned, create code on the fly
    if (S == "NoCode")  {
      // force absolute ("drop dead") expiration date of 1999 Dec. 31
      Expires = EncodeDate(1999, 12, 31);
      InitDaysCode(CKey, 30, Expires, Code);

      // save string representation of release code to Ini File
      S = BufferToHex(&Code, sizeof(Code));
      IniFile->WriteString("Codes", "DaysCode", S);
    }
    else
      // convert retrieved string to a code
      HexToBuffer(S, &Code, sizeof(Code));
  }
  catch (...) {
    delete IniFile;
    IniFile = 0;
  }
  delete IniFile;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgDaysCode1ChangeCode(TObject *Sender, TCode &Code)
{
  String S;
  TIniFile* IniFile = new TIniFile(TheDir + "Days30.INI");
  try {
    // convert Code to string for writing to INI file
    S = BufferToHex(&Code, sizeof(Code));
    IniFile->WriteString("Codes", "DaysCode", S);
  }
  catch (...) {
  	delete IniFile;
    IniFile = 0;
  }
  delete IniFile;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgDaysCode1Checked(TObject *Sender, TCodeStatus Status)
{
  String S;
  switch (Status) {
    case ogValidCode : {
    	Label1->Caption = "Days Remaining: " + String((int)OgDaysCode1->GetValue());
      return;
    }
    case ogInvalidCode  : S = "Invalid Code"; break;
    case ogDayCountUsed : S = "Program used more than 30 days.\r\n"
                              "Please register NOW"; break;
    case ogCodeExpired  : S = "Evaluation period expired\r\n"
                              "Please register NOW";
  }
  ShowMessage(S);
  Application->Terminate();
}
//---------------------------------------------------------------------------