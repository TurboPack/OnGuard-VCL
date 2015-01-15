//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExDtp21U.h"
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
void __fastcall TForm1::OgDateCode1GetKey(TObject *Sender, TKey &Key)
{
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgDateCode1GetCode(TObject *Sender, TCode &Code)
{
  String S;
	TDateTime SD;
  TDateTime ED;

  // force the INI file to be in the same directory as the application}
  TheDir = ExtractFilePath(ParamStr(0));
  int L = TheDir.Length();
  if (L > 3 && TheDir[L] != '\\')
    TheDir = TheDir + '\\';

  // open Ini File}
  TIniFile* IniFile = new TIniFile(TheDir + "Datep21.INI");
  try {
    // try to read release code}
    S = IniFile->ReadString("Codes", "DateCode", "");

    // If default string returned, create code on the fly}
    if (S == "") {
      SD = TDateTime::CurrentDate();
			ED = TDateTime::CurrentDate();
      ED += 21;
      InitDateCode(CKey, SD, ED, Code);

      // save string representation of release code to Ini File}
      S = BufferToHex(&Code, sizeof(Code));
      IniFile->WriteString("Codes", "DateCode", S);
    }
    else
      // convert retrieved string to a code}
      HexToBuffer(S, &Code, sizeof(Code));
  }
  catch (...) {
  	delete IniFile;
  }
  delete IniFile;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgDateCode1Checked(TObject *Sender, TCodeStatus Status)
{
	String S;
  switch (Status) {
    case ogValidCode : {
      Label1->Caption = "Expires: "
        + OgDateCode1->GetValue().DateString();
			return;
    }

    case ogPastEndDate : {
    	S = "Past 21 days - please register";
      break;
    }

    case ogInvalidCode : {
    	S = "Invalid Code";
      break;
    }
  }
  ShowMessage(S);
  Application->Terminate();
}
//---------------------------------------------------------------------------