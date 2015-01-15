//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ExReg1.h"
#include "OnGuard.hpp"
#include "OgUtil.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmExReg *frmExReg;

const TKey EncryptionKey = {0xE5, 0x8F, 0x84, 0xD6, 0x92, 0xC9, 0xA4, 0xD8,
                            0x1A, 0xFA, 0x6F, 0x8D, 0xAB, 0xFC, 0xDF, 0xB4};

//---------------------------------------------------------------------------
__fastcall TfrmExReg::TfrmExReg(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmExReg::btnGenerateClick(TObject *Sender)
{
  TKey Key;
  TCode Code;
  memcpy(Key, EncryptionKey, sizeof(EncryptionKey));
  long Modifier = StringHashElf(edtUserName1->Text);
  ApplyModifierToKeyPrim(Modifier, Key, sizeof(Key));
  InitRegCode(Key, "", pickExpirationDate->Date, Code);
  edtRegCode1->Text = BufferToHex(&Code, sizeof(Code));
}
//---------------------------------------------------------------------------
void __fastcall TfrmExReg::btnVerifyClick(TObject *Sender)
{
  TKey Key;
  TCode Code;
  memcpy(Key, EncryptionKey, sizeof(EncryptionKey));
  long Modifier = StringHashElf(edtUserName1->Text);
  ApplyModifierToKeyPrim(Modifier, Key, sizeof(Key));
  HexToBuffer(edtRegCode2->Text, &Code, sizeof(Code));
  if (IsRegCodeValid(Key, Code))
  {
    if (IsRegCodeExpired(Key, Code))
      edtStatus->Text = "Expired";
    else
      edtStatus->Text = "Valid";
  }
  else
    edtStatus->Text = "Not Valid";
}
//---------------------------------------------------------------------------
