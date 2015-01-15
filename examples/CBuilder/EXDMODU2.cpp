//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExDModU2.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TSNEntryDlg *SNEntryDlg;
//---------------------------------------------------------------------------
__fastcall TSNEntryDlg::TSNEntryDlg(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TSNEntryDlg::CancelBtnClick(TObject *Sender)
{
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TSNEntryDlg::FormCreate(TObject *Sender)
{
  int LI = GenerateMachineModifierPrim();
  ModString->Text = BufferToHex(&LI, sizeof(int));
}
//---------------------------------------------------------------------------