//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ExSelCod1.h"
//---------------------------------------------------------------------------
#pragma link "OnGuard"
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::GenBtnClick(TObject *Sender)
{
  TKey Key;
  int Modifier;
  int Value;
  TCode Code;
  TDateTime Expires;

  memcpy(Key, TheKey, sizeof(Key));
  HexToBuffer(MachineID->Text, &Modifier, sizeof(Modifier));
  ApplyModifierToKeyPrim(Modifier, Key, sizeof(Key));
  Expires = Date() + 5;
  Value = RequiredMask;
  if (HelpFeat->Checked)
    Value = Value + HelpMask;
  if (ExamplesFeat->Checked)
    Value = Value + ExamplesMask;
  if (DBFeat->Checked)
    Value = Value + DBMask;
  if (FaxFeat->Checked)
    Value = Value + FaxMask;
  if (GoodiesFeat->Checked)
    Value = Value + GoodiesMask;
  InitSpecialCode(Key, Value, Expires, Code);
  CodeDisplay->Text = BufferToHex(&Code, sizeof(Code));
}
//---------------------------------------------------------------------------
