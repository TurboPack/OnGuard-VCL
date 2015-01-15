//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExProtU.h"
//---------------------------------------------------------------------------
#pragma link "OgProExe"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgProtectExe1Checked(TObject *Sender, TExeStatus Status)
{
	String S;
  switch (Status) {
    case exeSuccess         : S = "EXE file is OK"; break;
    case exeSizeError       : S = "EXE file size has changed"; break;
    case exeIntegrityError  : S = "EXE Integrity Error"; break;
    case exeNotStamped      : S = "EXE file is not stamped"; break;
  	default : S = "Unknown error";
  }
  StatusLbl->Caption = S;
}
//---------------------------------------------------------------------------