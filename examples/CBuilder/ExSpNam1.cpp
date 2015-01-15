//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExSpNam1.h"
#include "OnGuard.hpp"
#include "OgUtil.hpp"

#pragma link "OnGuard"
#pragma link "OgUtil"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TForm1 *Form1;

TKey Key = {0xE8,0xB5,0xDF,0x7F,0xF7,0x01,0xC6,0x4A,
            0x24,0x08,0x02,0xDC,0xB0,0x78,0xCC,0x43};

//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{

}
//---------------------------------------------------------------------------
void __fastcall TForm1::btnGenCodeClick(TObject *Sender)
{
  TCode Code;
  int HashValue = StringHashElf(edtUserName1->Text);
  InitSpecialCode(Key, HashValue, Now(), Code);
  edtCode1->Text = BufferToHex(&Code, sizeof(Code));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::btnCheckCodeClick(TObject *Sender)
{
  TCode Code;
  HexToBuffer(edtCode2->Text, &Code, sizeof(Code));
  if (!IsSpecialCodeValid(Key, Code)) {
    lblCheckResult->Caption = "Code Invalid";
    return;
  }
  if (IsSpecialCodeExpired(Key, Code)) {
    lblCheckResult->Caption = "Code Expired";
    return;
  }
  if (GetSpecialCodeValue(Key, Code) != StringHashElf(edtUserName2->Text))
    lblCheckResult->Caption = "User name doesn't match";
  else
    lblCheckResult->Caption = "OK";
}
//--------------------------------------------------------------------------- 