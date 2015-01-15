//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "NafMgr1.h"
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
void __fastcall TForm1::FormCreate(TObject *Sender)
{
	memcpy(Key, CKey, sizeof(TKey));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::BrowseBtClick(TObject *Sender)
{
  if (OpenDg->Execute())
    FileNameEd->Text = OpenDg->FileName;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::AccessCodeEdChange(TObject *Sender)
{
  CreateBt->Enabled = (NumberOfSlots(AccessCodeEd->Text) != -1) &&
  	 (FileNameEd->Text != "");
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FileNameEdChange(TObject *Sender)
{
  UpdateBt->Enabled = FileExists(FileNameEd->Text);
  CreateBt->Enabled =
  	NumberOfSlots(AccessCodeEd->Text) != -1 && FileNameEd->Text != "";
  ResetBt->Enabled = FileExists(FileNameEd->Text);
  DeleteBt->Enabled = FileExists(FileNameEd->Text);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::UpdateBtClick(TObject *Sender)
{
  if(!UpdateInfoLabels(FileNameEd->Text))
    MessageDlg("Unable to read network access file.",
    	mtError, TMsgDlgButtons() << mbOK, 0);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::CreateBtClick(TObject *Sender)
{
  if (NumberOfSlots(AccessCodeEd->Text) != -1)
    if (!CreateNetAccessFile(
    	FileNameEd->Text, Key, NumberOfSlots(AccessCodeEd->Text)))
      MessageDlg("Unable to create network access file.",
      	mtError, TMsgDlgButtons() << mbOK, 0);
    else {
      if (!UpdateInfoLabels(FileNameEd->Text))
        MessageDlg("Unable to read network access file.",
          mtError,  TMsgDlgButtons() << mbOK, 0);

      UpdateBt->Enabled = FileExists(FileNameEd->Text);
      ResetBt->Enabled = FileExists(FileNameEd->Text);
      DeleteBt->Enabled = FileExists(FileNameEd->Text);
		}
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ResetBtClick(TObject *Sender)
{
  if (!ResetNetAccessFile(FileNameEd->Text, Key))
    MessageDlg("Unable to reset network access file.",
    	mtError,  TMsgDlgButtons() << mbOK, 0);
  else
    if (!UpdateInfoLabels(FileNameEd->Text))
      MessageDlg("Unable read network access file.",
      	mtError,  TMsgDlgButtons() << mbOK, 0);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::DeleteBtClick(TObject *Sender)
{
  if (MessageDlg("Are you sure you want to delete this network access file?",
         mtConfirmation,  TMsgDlgButtons() << mbYes << mbNo, 0) == mrYes) {
    DeleteFile(FileNameEd->Text.c_str());
    TotalSlotsLb->Caption = "0";
    LockedSlotsLb->Caption = "0";
    InvalidSlotsLb->Caption = "0";

    UpdateBt->Enabled = FileExists(FileNameEd->Text);
    ResetBt->Enabled = FileExists(FileNameEd->Text);
    DeleteBt->Enabled = FileExists(FileNameEd->Text);
	}
}
//---------------------------------------------------------------------------
bool TForm1::UpdateInfoLabels(const String FileName)
{
  bool Result;
  TNetAccessInfo NetAccessInfo;
  if (GetNetAccessFileInfo(FileName, Key, NetAccessInfo)) {
    TotalSlotsLb->Caption = (int)NetAccessInfo.Total;
    LockedSlotsLb->Caption = (int)NetAccessInfo.Locked;
    InvalidSlotsLb->Caption = (int)NetAccessInfo.Invalid;
    Result = true;
  }
  else
    Result = false;
  return Result;
}

int TForm1::NumberOfSlots(const String Str)
{
	TCode Code;
  int Result = -1;
  if (Str.Length() == sizeof(Code) * 2) {
    HexToBuffer(Str, &Code, sizeof(Code));
    Result = DecodeNAFCountCode(Key, Code);
  }
  return Result;
}

void __fastcall TForm1::GenerateCodeSbClick(TObject *Sender)
{
  TCode Work;
  OgMakeCodes1->SetKey(CKey);
  OgMakeCodes1->CodeType = ctNetwork;
  if (OgMakeCodes1->Execute()) {
    OgMakeCodes1->GetCode(Work);
    AccessCodeEd->Text = BufferToHex(&Work, sizeof(Work));
  }
}
//---------------------------------------------------------------------------