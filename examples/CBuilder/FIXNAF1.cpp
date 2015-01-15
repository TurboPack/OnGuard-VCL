//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "FixNaf1.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TMainFrm *MainFrm;
//---------------------------------------------------------------------------
__fastcall TMainFrm::TMainFrm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainFrm::FormCreate(TObject *Sender)
{
  // change these lines to match your application.
  // they must be hardcoded, do not use .ini files, or
  // you"ll loose security.
  const TKey CKey = { 0xE5,0x8F,0x84,0xD6,0x92,0xC9,
  	0xA4,0xD8,0x1A,0xFA,0x6F,0x8D,0xAB,0xFC,0xDF,0xB4 };
  memcpy(Key, CKey, sizeof(TKey));

  // change the file name to match your application
  FileNamePn->Caption = "EXNET.NAF";

  UpdateBt->Enabled = FileExists(FileNamePn->Caption);
  ResetBt->Enabled = FileExists(FileNamePn->Caption);
  DeleteBt->Enabled = FileExists(FileNamePn->Caption);
}
//---------------------------------------------------------------------------
void __fastcall TMainFrm::AccessCodeEdChange(TObject *Sender)
{
  CreateBt->Enabled = (NumberOfSlots(AccessCodeEd->Text) != -1) &&
  	 (FileNamePn->Caption != "");
}
//---------------------------------------------------------------------------
void __fastcall TMainFrm::UpdateBtClick(TObject *Sender)
{
  if(!UpdateInfoLabels(FileNamePn->Caption))
    MessageDlg("Unable to read network access file.",
    	mtError, TMsgDlgButtons() << mbOK, 0);
}
//---------------------------------------------------------------------------
void __fastcall TMainFrm::CreateBtClick(TObject *Sender)
{
  if (NumberOfSlots(AccessCodeEd->Text) != -1)
    if (!CreateNetAccessFile(
    	FileNamePn->Caption, Key, NumberOfSlots(AccessCodeEd->Text)))
      MessageDlg("Unable to create network access file.",
      	mtError, TMsgDlgButtons() << mbOK, 0);
    else {
      if (!UpdateInfoLabels(FileNamePn->Caption))
        MessageDlg("Unable to read network access file.",
          mtError,  TMsgDlgButtons() << mbOK, 0);

      UpdateBt->Enabled = FileExists(FileNamePn->Caption);
      ResetBt->Enabled = FileExists(FileNamePn->Caption);
      DeleteBt->Enabled = FileExists(FileNamePn->Caption);
		}
}
//---------------------------------------------------------------------------
void __fastcall TMainFrm::ResetBtClick(TObject *Sender)
{
  if (!ResetNetAccessFile(FileNamePn->Caption, Key))
    MessageDlg("Unable to reset network access file.",
    	mtError,  TMsgDlgButtons() << mbOK, 0);
  else
    if (!UpdateInfoLabels(FileNamePn->Caption))
      MessageDlg("Unable read network access file.",
      	mtError,  TMsgDlgButtons() << mbOK, 0);
}
//---------------------------------------------------------------------------
void __fastcall TMainFrm::DeleteBtClick(TObject *Sender)
{
  if (MessageDlg("Are you sure you want to delete this network access file?",
         mtConfirmation,  TMsgDlgButtons() << mbYes << mbNo, 0) == mrYes) {
      DeleteFile(FileNamePn->Caption.c_str());
      TotalSlotsLb->Caption = "0";
      LockedSlotsLb->Caption = "0";
      InvalidSlotsLb->Caption = "0";

      UpdateBt->Enabled = FileExists(FileNamePn->Caption);
      ResetBt->Enabled = FileExists(FileNamePn->Caption);
      DeleteBt->Enabled = FileExists(FileNamePn->Caption);
	}
}
//---------------------------------------------------------------------------
bool TMainFrm::UpdateInfoLabels(const String FileName)
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

int TMainFrm::NumberOfSlots(const String Str)
{
	TCode Code;
  int Result = -1;
  if (Str.Length() == sizeof(Code) * 2) {
    HexToBuffer(Str, &Code, sizeof(Code));
    Result = DecodeNAFCountCode(Key, Code);
  }
  return Result;
}
