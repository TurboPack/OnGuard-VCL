//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExUsRegU.h"
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
void __fastcall TForm1::OgUsageCode1Checked(TObject *Sender, TCodeStatus Status)
{
  String S;
  switch (Status) {
    case ogValidCode    : S = "Valid Code - Uses remaining: " + String((int)OgUsageCode1->GetValue()-1); break;
    case ogInvalidCode  : S = "Invalid release code"; break;
    case ogPastEndDate  : S = "Date has expired"; break;
    case ogDayCountUsed : S = "Zero days of use remaining"; break;
    case ogRunCountUsed : S = "Usage count has expired"; break;
    case ogNetCountUsed : S = "Net usage count exceeded"; break;
    case ogCodeExpired  : S = "Code has expired"; break;
  	default : S = "Unknown error";
  }
  StatusLbl->Caption = S;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode1GetKey(TObject *Sender, TKey &Key)
{
  // this application's key
  TKey CKey = {0xE5,0x8F,0x84,0xD6,0x92,0xC9,0xA4,0xD8,0x1A,0xFA,0x6F,0x8D,0xAB,0xFC,0xDF,0xB4};
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode1GetCode(TObject *Sender, TCode &Code)
{
  String S;
  TIniFile* Ini = new TIniFile("ONGUARD.INI");
  try {
    // get the usage code from the ini file
    S = Ini->ReadString("Codes", "UsageCode", "");
    // convert to proper form
    HexToBuffer(S, &Code, sizeof(Code));
    // set code label caption
    CodeLbl->Caption = S;
  }
  catch (...) {
  	delete Ini;
    Ini = 0;
  }
	delete Ini;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::CodeBtnClick(TObject *Sender)
{
  TCode Work;
  String S = "";
  // ask for code
  if (InputQuery("Usage Code Entry", "Enter the code", S)) {
    TIniFile* Ini = new TIniFile("ONGUARD.INI");
    try {
      // store the usage code in the ini file if it looks OK
      if (HexToBuffer(S, &Work, sizeof(Work))) {
        // save the value
        Ini->WriteString("Codes", "UsageCode", S);
        CodeLbl->Caption = S;

        // tell the code component to test the new code, reporting the results
        OgUsageCode1->CheckCode(true);
      }
    }
    catch (...) {
    	delete Ini;
      Ini = 0;
    }
		delete Ini;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::RemoveBtnClick(TObject *Sender)
{
  TIniFile* Ini = new TIniFile("ONGUARD.INI");
  try {
    Ini->DeleteKey("Codes", "UsageCode");
  }
  catch (...) {
  	delete Ini;
    Ini = 0;
  }
  delete Ini;

  // tell the code component to test the new code, reporting the results
  OgUsageCode1->CheckCode(true);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgUsageCode1ChangeCode(TObject *Sender, TCode &Code)
{
  String S;
  // open Ini File
  TIniFile* IniFile = new TIniFile("ONGUARD.INI");
  try {
    // convert code to string
    S = BufferToHex(&Code, sizeof(Code));
    IniFile->WriteString("Codes", "UsageCode", S);
    CodeLbl->Caption = S;

    // tell the code component to test the new code, reporting the results
    OgUsageCode1->CheckCode(true);
  }
  catch (...) {
    delete IniFile;
    IniFile = 0;
  }
  delete IniFile;
}
//---------------------------------------------------------------------------