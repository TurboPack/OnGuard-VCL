{*********************************************************}
{*                 ONGUARD:  EXSLCOD1.PAS                *}
{*        Copyright (c) TurboPower Software Co 1998      *}
{*                   All rights reserved.                *}
{*********************************************************}

  { This example generates a special release code (via OnGuard API)
    to enable various features of the companion examples, EXSELECT
    and EXSELAPI.  Enter the machine identifier displayed by those
    examples and make the desired feature selection.  The generic
    key used by these examples will be modified by the value entered
    for machine identifier to create the special release code with
    a numeric value representing the features selected.}

unit Exslcod1;
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs,Buttons,
  OnGuard, OgUtil, StdCtrls,LResources{, Mask};

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    GenBtn: TButton;
    MachineID: TEdit;
    GroupBox1: TGroupBox;
    ReqFeat: TCheckBox;
    HelpFeat: TCheckBox;
    ExamplesFeat: TCheckBox;
    DBFeat: TCheckBox;
    FaxFeat: TCheckBox;
    GoodiesFeat: TCheckBox;
    CodeDisplay: TEdit;
    procedure GenBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



const
  DemoKey: TKey = ($F1,$46,$8D,$E4,
                   $70,$AE,$92,$DC,
                   $13,$1A,$03,$C4,
                   $44,$25,$72,$F5);

  RequiredMask: longint = $00000001;
  HelpMask: longint =     $00000002;
  ExamplesMask: longint = $00000004;
  DBMask: longint =       $00000008;
  FaxMask: longint =      $00000010;
  GoodiesMask: longint =  $00000020;

procedure TForm1.GenBtnClick(Sender: TObject);
var
  Key: TKey;
  Modifier: Longint;
  Code: TCode;
  Expires: TDateTime;
  Value: longint;
begin
  Key := DemoKey;
  HexToBuffer(MachineID.Text, Modifier, SizeOf(Modifier));
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  Expires := Date + 5;
  Value := RequiredMask;
  If HelpFeat.Checked then
    Value := Value + HelpMask;
  If ExamplesFeat.Checked then
    Value := Value + ExamplesMask;
  If DBFeat.Checked then
    Value := Value + DBMask;
  If FaxFeat.Checked then
    Value := Value + FaxMask;
  If GoodiesFeat.Checked then
    Value := Value + GoodiesMask;
  InitSpecialCode(Key, Value, Expires, Code);
  CodeDisplay.Text := BufferToHex(Code, SizeOf(Code));
end;

initialization
{$i exslcod1.lrs}

end.
