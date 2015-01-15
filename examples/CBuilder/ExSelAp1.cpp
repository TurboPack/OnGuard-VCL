//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ExSelAp1.h"
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

bool __fastcall TForm1::FileGetCode(int Index, TCode &Code)
{
  String Dir, Path;
  int FileHandle;

  Dir = ExtractFilePath(ParamStr(0));
  Path = Dir + "\\" + CodeFile;
  memset(&Code, 0, sizeof(Code));
  if (FileExists(Path)) {
    FileHandle = FileOpen(Path, fmOpenRead);
    FileSeek(FileHandle, Index * sizeof(Code), 0);
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
  FileSeek(FileHandle, Index * sizeof(Code), 0);
  FileWrite(FileHandle, &Code, sizeof(Code));
  FileClose(FileHandle);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  int FreebiesLeft, Features;

  memset(&SpecialCode, 0, sizeof(SpecialCode));
  if (!FileGetCode(0, UsageCode))
    HexToBuffer(InitCode, &UsageCode, sizeof(UsageCode));
  FreebiesLeft = GetUsageCodeValue(TheKey, UsageCode);
  if (FreebiesLeft > 0) {             // Still in demo phase
    DecUsageCode(TheKey, UsageCode);
    FilePutCode(0, UsageCode);
    EnableFeatures(RequiredMask);
    Caption = DemoCaption + IntToStr(FreebiesLeft - 1);
  }
  else {                              // Registration phase
    FileGetCode(1, SpecialCode);
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
    ModifyBtn->Enabled = true;
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
  // First see if existing Special code is valid
  if (IsSpecialCodeValid(ModKey, SpecialCode))
    return GetSpecialCodeValue(ModKey, SpecialCode);
  // Otherwise prompt user for Special code
  CodeStr = "";
  if (InputQuery("Machine ID: "+ MachineID ,
       "Run ExSLCODE To Obtain Release Code", CodeStr)) {
    HexToBuffer(CodeStr, &SpecialCode, sizeof(SpecialCode));
    if (IsSpecialCodeValid(ModKey, SpecialCode))
      return GetSpecialCodeValue(ModKey, SpecialCode);
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

