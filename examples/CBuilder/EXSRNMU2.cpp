//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExSrnmu2.h"
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