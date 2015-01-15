{*********************************************************}
{*                 ONGUARD:  EXSELAP1.PAS                *}
{*        Copyright (c) TurboPower Software Co 1998      *}
{*                   All rights reserved.                *}
{*********************************************************}

  { This example uses the OgUsageCode and the OgSpecialCode
   (via OnGuard API functions) to implement a limited use
   "demo" application which allows only the required features.
   The program can be run 3 times and then a special code
   must be obtained to register the program and to enable
   various features.  A machine modifier is used to prevent
   the application from being copied and run on another
   machine.  To obtain the release code you need to run the
   companion example EXSLCODE.  The release codes will be stored
   in a data file called EXSELECT.DAT}

unit Exselap1;
{$H+}

interface

uses
  SysUtils, Classes,Controls, Forms, Dialogs,
  StdCtrls, Menus,Buttons,LResources,OgUtil,OnGuard;

type

  { TForm1 }

  TForm1 = class(TForm)
    ModifyBtn: TButton;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    FeaturesMenu: TMenuItem;
    FeaturesRequired: TMenuItem;
    FeaturesHelp: TMenuItem;
    FeaturesExamples: TMenuItem;
    FeaturesDatabase: TMenuItem;
    FeaturesFax: TMenuItem;
    FeaturesGoodies: TMenuItem;
    function FileGetCode(Index : Longint; var Code : TCode) : Boolean;
    procedure FilePutCode(Index : Longint; Code : TCode);
    procedure FormCreate(Sender: TObject);
    function DecodeSpecialCode : Longint;
    procedure ModifyBtnClick(Sender: TObject);
    procedure EnableFeatures(Features : Longint);
  end;

var
  Form1: TForm1;

{----------------------------------------------------------------------}

implementation



const
    { The key was created by a separate program (CODEGEN) and is generic
      the examples, EXSELECT, EXSELAPI, and EXSLCODE }
  TheKey: TKey = ($F1,$46,$8D,$E4,$70,$AE,$92,$DC,
                  $13,$1A,$03,$C4,$44,$25,$72,$F5);

    { Initial code has 3 uses embedded }
  InitCode        : string = '13B1A08BD78AFCD3';
  CodeFile         : string = 'ExSelect.Dat';
  DemoCaption      : string = 'ExSelApi: Demo runs left = ';
  RegisteredCap    : string = 'ExSelApi: Registered';
  NotRegisteredCap : string = 'ExSelApi: Not Registered';
//  ModifyStr        : string = 'Modify Registration to enable this feature';

    { Feature masks }
  RequiredMask = $00000001;
  HelpMask =     $00000002;
  ExamplesMask = $00000004;
  DBMask =       $00000008;
  FaxMask =      $00000010;
  GoodiesMask =  $00000020;

var
  UsageCode   : TCode;        {Index = 0}
  SpecialCode : TCode;        {Index = 1}


{-------------------------------------------------------}

function TForm1.FileGetCode(Index : Longint; var Code : TCode) : Boolean;
var
  Dir, Path   : string;
  FileHandle  : Integer;
begin
  Dir := '';
  GetDir(0, Dir);
  Path := Dir + DirectorySeparator + CodeFile;
  FillChar(Code, SizeOf(TCode), 0);
  if FileExists(Path) then begin
    FileHandle := FileOpen(Path, fmOpenRead);
    FileSeek(FileHandle, Index * SizeOf(Code), 0);
    FileRead(FileHandle, Code, SizeOf(Code));
    FileClose(FileHandle);
    Result := True;
  end else
    Result := False;
end;

{-------------------------------------------------------}

procedure TForm1.FilePutCode(Index : Longint; Code : TCode);
var
  Dir, Path   : string;
  FileHandle  : Integer;
begin
  Dir := '';
  GetDir(0, Dir);
  Path := Dir + DirectorySeparator + CodeFile;
  if not FileExists(Path) then
    FileHandle := FileCreate(Path)
  else
    FileHandle := FileOpen(Path, fmOpenWrite);
  FileSeek(FileHandle, Index * SizeOf(Code), 0);
  FileWrite(FileHandle, Code, SizeOf(Code));
  FileClose(FileHandle);
end;

{-------------------------------------------------------}

procedure TForm1.FormCreate(Sender: TObject);
var
  FreebiesLeft : Longint;
  Features     : Longint;
begin
  FillChar(SpecialCode, SizeOf(SpecialCode), 0);
  if not FileGetCode(0, UsageCode) then
    HexToBuffer(InitCode, UsageCode, SizeOf(UsageCode));
  FreebiesLeft := GetUsageCodeValue(TheKey, UsageCode);
  if (FreebiesLeft > 0) then begin    {Still in demo phase}
    DecUsageCode(TheKey, UsageCode);
    FilePutCode(0, UsageCode);
    EnableFeatures(RequiredMask);
    Caption := DemoCaption + IntToStr(FreebiesLeft - 1);
  end else begin                      {Registration phase}
    FileGetCode(1, SpecialCode);
    Features := DecodeSpecialCode;
    if (Features <> 0) then begin
      FilePutCode(1, SpecialCode);
      EnableFeatures(Features);
      Caption := RegisteredCap;
    end else begin
      EnableFeatures(0);
      Caption := NotRegisteredCap;
    end;
    ModifyBtn.Enabled := True;
  end;
end;

{-------------------------------------------------------}

function TForm1.DecodeSpecialCode : Longint;
var
  CodeStr   : string;
  ModKey    : TKey;
  MachineID : string;
  Modifier  : longint;
begin
  Result := 0;
  MachineID := '';
  Modifier := GenerateMachineModifierPrim;
  MachineID := BufferToHex(Modifier, SizeOf(Modifier));
  ModKey := TheKey;
  ApplyModifierToKeyPrim(Modifier, ModKey, SizeOf(ModKey));
  {First see if existing Special code is valid}
  if IsSpecialCodeValid(ModKey, SpecialCode) then begin
    Result := GetSpecialCodeValue(ModKey, SpecialCode);
    Exit;
  end;
  {Otherwise prompt user for Special code}
  CodeStr := '';
  if InputQuery('Machine ID: '+ MachineID ,
       'Run ExSLCODE To Obtain Release Code', CodeStr) then begin
    HexToBuffer(CodeStr, SpecialCode, SizeOf(SpecialCode));
    if IsSpecialCodeValid(ModKey, SpecialCode) then
      Result := GetSpecialCodeValue(ModKey, SpecialCode);
  end;
end;

{-------------------------------------------------------}

procedure TForm1.EnableFeatures(Features : Longint);
begin
  FeaturesRequired.Enabled := False;
  FeaturesRequired.Checked := False;
  FeaturesHelp.Enabled := False;
  FeaturesHelp.Checked := False;
  FeaturesExamples.Enabled := False;
  FeaturesExamples.Checked := False;
  FeaturesDatabase.Enabled := False;
  FeaturesDatabase.Checked := False;
  FeaturesFax.Enabled := False;
  FeaturesFax.Checked := False;
  FeaturesGoodies.Enabled := False;
  FeaturesGoodies.Checked := False;
  if (Features and RequiredMask) <> 0 then begin
    FeaturesRequired.Enabled := True;
    FeaturesRequired.Checked := True;
  end;
  if (Features and HelpMask) <> 0 then begin
    FeaturesHelp.Enabled := True;
    FeaturesHelp.Checked := True;
  end;
  if (Features and ExamplesMask) <> 0 then begin
    FeaturesExamples.Enabled := True;
    FeaturesExamples.Checked := True;
  end;
  if (Features and DBMask) <> 0 then begin
    FeaturesDatabase.Enabled := True;
    FeaturesDatabase.Checked := True;
  end;
  if (Features and FaxMask) <> 0 then begin
    FeaturesFax.Enabled := True;
    FeaturesFax.Checked := True;
  end;
  if (Features and GoodiesMask) <> 0 then begin
    FeaturesGoodies.Enabled := True;
    FeaturesGoodies.Checked := True;
  end;
  if (Features = 0) then
    FeaturesMenu.Caption := 'No Features Enabled'
  else
    FeaturesMenu.Caption := '&Features';
end;

{-------------------------------------------------------}

procedure TForm1.ModifyBtnClick(Sender: TObject);
var
  Features : Longint;
begin
  FillChar(SpecialCode, SizeOf(SpecialCode), 0);
  Features := DecodeSpecialCode;
  if (Features <> 0) then begin
    FilePutCode(1, SpecialCode);
    EnableFeatures(Features);
    Caption := RegisteredCap;
  end;
end;


initialization
{$i exselap1.lrs}

end.
