//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "StampEx1.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmStamp *frmStamp;
//---------------------------------------------------------------------------
__fastcall TfrmStamp::TfrmStamp(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmStamp::BrowseBtnClick(TObject *Sender)
{
  OpenDialog1->FileName = FileEd->Text;
  if (OpenDialog1->Execute())
    FileEd->Text = OpenDialog1->FileName;
}
//---------------------------------------------------------------------------
void __fastcall TfrmStamp::StampBtnClick(TObject *Sender)
{
  if (FileEd->Text != "")
    if (ProtectExe(FileEd->Text, EraseMarkerCb->Checked))
      StatusLbl->Caption = "File marked";
    else
      StatusLbl->Caption = "Error while attemping to mark file";
}
//---------------------------------------------------------------------------
void __fastcall TfrmStamp::ClearBtnClick(TObject *Sender)
{
  if (FileEd->Text != "")
    if (UnprotectExe(FileEd->Text))
      StatusLbl->Caption = "EXE file signature record reset";
    else
      StatusLbl->Caption = "Error while attemping to reset signature record";
}
//---------------------------------------------------------------------------
void __fastcall TfrmStamp::FormCreate(TObject *Sender)
{
  StatusLbl->Caption = "";
  FileEdChange(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfrmStamp::FileEdChange(TObject *Sender)
{
  StampBtn->Enabled = FileExists(FileEd->Text);
  ClearBtn->Enabled = FileExists(FileEd->Text);
  if (FileExists(FileEd->Text))
    StatusLbl->Caption = "Valid filename";
  else
    StatusLbl->Caption = "Invalid filename";
}
//---------------------------------------------------------------------------