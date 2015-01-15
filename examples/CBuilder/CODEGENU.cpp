//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "CodeGenU.h"
//---------------------------------------------------------------------------
#pragma link "OnGuard"
#pragma resource "*.dfm"
TCodeGenFrm *CodeGenFrm;
//---------------------------------------------------------------------------
__fastcall TCodeGenFrm::TCodeGenFrm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TCodeGenFrm::CopySbClick(TObject *Sender)
{
  int OldSelStart = CodeEd->SelStart;
  CodeEd->SelStart = 0;
  CodeEd->SelLength = MaxInt;
  CodeEd->CopyToClipboard();
  CodeEd->SelStart = OldSelStart;
  CodeEd->SelLength = 0;
}
//---------------------------------------------------------------------------
void __fastcall TCodeGenFrm::GenerateBtnClick(TObject *Sender)
{
  TKey CKey = { 0xE5,0x8F,0x84,0xD6,0x92,0xC9,
  	0xA4,0xD8,0x1A,0xFA,0x6F,0x8D,0xAB,0xFC,0xDF,0xB4 };
	TCode Work;
  // set default key to use
  OgMakeCodes1->SetKey(CKey);
  if (OgMakeCodes1->Execute()) {
    // get the code
    OgMakeCodes1->GetCode(Work);
    // display the code
    CodeEd->Text = BufferToHex(&Work, sizeof(TCode));
  }
}
//---------------------------------------------------------------------------