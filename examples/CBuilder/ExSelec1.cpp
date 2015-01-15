//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ExSelec1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "OnGuard"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

bool __fastcall TForm1::FileGetCode(int Index, TCode &Code)
{
  String Dir, Path;
  int FileHandle;

  Dir = ExtractFilePath(ParamStr(0));
  Path = Dir + "\\" + CodeFile;
  memset(&Code, 0, sizeof(Code));
  if (FileExists(Path)) {
    FileHandle = FileOpen(Path, fmOpenRead);
    FileSeek(FileHandle, (int) (Index * sizeof(Code)), 0);
    FileRead(FileHandle, &Code, sizeof(Code));
    FileClose(FileHandle);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FilePutCode(int Index, TCode Code)
{
  String Dir, Path;
  int FileHandle;

  Dir = ExtractFilePath(ParamStr(0));
  Path = Dir + "\\" + CodeFile;
  if (!FileExists(Path))
    FileHandle = FileCreate(Path);
  else
    FileHandle = FileOpen(Path, fmOpenWrite);
  FileSeek(FileHandle, (int) (Index * sizeof(Code)), 0);
  FileWrite(FileHandle, &Code, sizeof(Code));
  FileClose(FileHandle);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  memset(&SpecialCode, 0, sizeof(SpecialCode));
  if (!FileGetCode(0, UsageCode))
    HexToBuffer(InitCode, &UsageCode, sizeof(UsageCode));
  OgUsageCode1->CheckCode(True);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgUsageCode1GetKey(TObject *Sender, TKey &Key)
{
  memcpy(Key, TheKey, sizeof(Key));
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgUsageCode1GetCode(TObject *Sender, TCode &Code)
{
  Code = UsageCode;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgUsageCode1Checked(TObject *Sender,
      TCodeStatus Status)
{
  // If app is still in demo period, enable only default features
  if (Status == ogValidCode) {
    OgUsageCode1->Decrease();
    EnableFeatures(RequiredMask);
  }
  else { // Usage count has expired, go on to special code stuff
    FileGetCode(1, SpecialCode);
    ModifyBtn->Enabled = true;
    OgSpecialCode1->CheckCode(true);
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgUsageCode1ChangeCode(TObject *Sender,
      TCode &Code)
{
  int FreebiesLeft;

  FreebiesLeft = OgUsageCode1->GetValue() - 1;
  UsageCode = Code;
  FilePutCode(0, UsageCode);
  Caption = DemoCaption + IntToStr(FreebiesLeft);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::OgSpecialCode1GetKey(TObject *Sender, TKey &Key)
{
  memcpy(Key, TheKey, sizeof(Key));
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgSpecialCode1GetCode(TObject *Sender, TCode &Code)
{
  Code = SpecialCode;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgSpecialCode1GetModifier(TObject *Sender,
      int &Value)
{
  Value = GenerateMachineModifierPrim();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OgSpecialCode1Checked(TObject *Sender,
      TCodeStatus Status)
{
  int Features;

  // If special code is valid, then app is registered so enable features
  if (Status == ogValidCode) {
    FilePutCode(1, SpecialCode);
    Features = OgSpecialCode1->GetValue();
    EnableFeatures(Features);
    Caption = RegisteredCap;
    return;
  }
  // Otherwise prompt for release code
  Features = DecodeSpecialCode();
  if (Features != 0) {
    FilePutCode(1, SpecialCode);
    EnableFeatures(Features);
    Caption = RegisteredCap;
  }
  else {
    EnableFeatures(0);
    Caption = NotRegisteredCap;
  }
}
//---------------------------------------------------------------------------

int __fastcall TForm1::DecodeSpecialCode()
{
  String CodeStr, MachineID;
  TKey ModKey;
  int Modifier;

  MachineID = "";
  Modifier = GenerateMachineModifierPrim();
  MachineID = BufferToHex(&Modifier, sizeof(Modifier));
  memcpy(ModKey, TheKey, sizeof(ModKey));
  ApplyModifierToKeyPrim(Modifier, ModKey, sizeof(ModKey));
  CodeStr = "";
  if (InputQuery("Machine ID: "+ MachineID ,
       "Run EXSLCODE To Obtain Release Code", CodeStr)) {
    HexToBuffer(CodeStr, &SpecialCode, sizeof(SpecialCode));
    if (OgSpecialCode1->IsCodeValid())
      return OgSpecialCode1->GetValue();
  }
  return 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EnableFeatures(int Features)
{
  FeaturesRequired->Enabled = false;
  FeaturesRequired->Checked = false;
  FeaturesHelp->Enabled = false;
  FeaturesHelp->Checked = false;
  FeaturesExamples->Enabled = false;
  FeaturesExamples->Checked = false;
  FeaturesDatabase->Enabled = false;
  FeaturesDatabase->Checked = false;
  FeaturesFax->Enabled = false;
  FeaturesFax->Checked = false;
  FeaturesGoodies->Enabled = false;
  FeaturesGoodies->Checked = false;
  if ((Features & RequiredMask) != 0) {
    FeaturesRequired->Enabled = true;
    FeaturesRequired->Checked = true;
  }
  if ((Features & HelpMask) != 0) {
    FeaturesHelp->Enabled = true;
    FeaturesHelp->Checked = true;
  }
  if ((Features & ExamplesMask) != 0) {
    FeaturesExamples->Enabled = true;
    FeaturesExamples->Checked = true;
  }
  if ((Features & DBMask) != 0) {
    FeaturesDatabase->Enabled = true;
    FeaturesDatabase->Checked = true;
  }
  if ((Features & FaxMask) != 0) {
    FeaturesFax->Enabled = true;
    FeaturesFax->Checked = true;
  }
  if ((Features & GoodiesMask) != 0) {
    FeaturesGoodies->Enabled = true;
    FeaturesGoodies->Checked = true;
  }
  if (Features == 0)
    FeaturesMenu->Caption = "No Features Enabled";
  else
    FeaturesMenu->Caption = "&Features";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ModifyBtnClick(TObject *Sender)
{
  int Features;

  memset(&SpecialCode, 0, sizeof(SpecialCode));
  Features = DecodeSpecialCode();
  if (Features != 0) {
    FilePutCode(1, SpecialCode);
    EnableFeatures(Features);
    Caption = RegisteredCap;
  }
}
//---------------------------------------------------------------------------
