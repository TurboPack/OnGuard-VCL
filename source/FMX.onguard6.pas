(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is TurboPower OnGuard
 *
 * The Initial Developer of the Original Code is
 * TurboPower Software
 *
 * Portions created by the Initial Developer are Copyright (C) 1996-2002
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)
{*********************************************************}
{*                  ONGUARD6.PAS 1.15                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit FMX.onguard6;
  {-Code generation dialog}

interface

uses
  FMX.OgUtil, FMX.OnGuard, DesignIntf, DesignEditors, FMX.ComboEdit, FMX.Edit, FMX.Types,
  FMX.Controls.Presentation, FMX.Forms, FMX.StdCtrls, System.Classes, FMX.Controls,
  FMX.DateTimeCtrls;


type
  TModifierFrm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    GroupBox1: TGroupBox;
    UniqueModifierCb: TCheckBox;
    MachineModifierCb: TCheckBox;
    DateModifierCb: TCheckBox;
    NoModifierCb: TCheckBox;
    ModifierEd: TEdit;
    ModDateEdit: TDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure ModifierClick(Sender: TObject);
    procedure ModifierEdKeyPress(Sender: TObject; var Key: Char);
    procedure DateEdKeyPress(Sender: TObject; var Key: Char);
    procedure InfoChanged(Sender: TObject);
  private
    FBusy: Boolean;
  public
    Modifier : Integer;
  end;


type
  {property editor for ranges}
  TOgModifierProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    function GetValue : string;
      override;
    procedure Edit;
      override;
  end;


implementation

{$R *.fmx}

uses
  System.UITypes, System.SysUtils, Winapi.Windows;

procedure TModifierFrm.FormCreate(Sender: TObject);
begin
  InfoChanged(nil);
end;

procedure TModifierFrm.ModifierClick(Sender: TObject);
var
  L : Integer;
  D : TDateTime;
begin
  if FBusy then
    Exit;

  {set busy flag so that setting "Checked" won't recurse}
  FBusy := True;
  try
    L := 0;

    if (Sender = NoModifierCb) and NoModifierCb.IsChecked then begin
      UniqueModifierCb.IsChecked := False;
      MachineModifierCb.IsChecked := False;
      DateModifierCb.IsChecked := False;
    end else
      NoModifierCb.IsChecked := False;

    if not UniqueModifierCb.IsChecked and
       not MachineModifierCb.IsChecked and
       not DateModifierCb.IsChecked then
      NoModifierCb.IsChecked := True;

    if MachineModifierCb.IsChecked then begin
      if L = 0 then
        L := GenerateMachineModifierPrim
      else
        L := L xor GenerateMachineModifierPrim;
    end;

    {set status of date field}
    ModDateEdit.Enabled := DateModifierCb.IsChecked;
    if DateModifierCb.IsChecked then begin
      try
        D := StrToDate(ModDateEdit.Text);
      except
        {ignore errors and don't generate modifier}
        D := 0;
      end;

      if Trunc(D) > 0 then begin
        if L = 0 then
          L := GenerateDateModifierPrim(D)
        else
          L := L xor GenerateDateModifierPrim(D);
      end;
    end;

    if UniqueModifierCb.IsChecked then begin
      if L = 0 then
        L := GenerateUniqueModifierPrim
      else
        L := L xor GenerateUniqueModifierPrim;
    end;

    if L = 0 then
      ModifierEd.Text := ''
    else
      ModifierEd.Text := '$' + BufferToHex(L, 4);

    InfoChanged(nil);
  finally
    FBusy := False;
  end;
end;

procedure TModifierFrm.DateEdKeyPress(Sender: TObject; var Key: Char);
const
  CIntChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '/'];
begin
  if (not CharInSet(Key, CIntChars)) and (not (Key < #32)) then begin
    MessageBeep(0);
    Key := #0;
  end;
end;

procedure TModifierFrm.ModifierEdKeyPress(Sender: TObject; var Key: Char);
const
  CHexChars = ['$', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not CharInSet(Key, CHexChars)) and (not (Key < #32)) then begin
    MessageBeep(0);
    Key := #0;
  end;
end;

procedure TModifierFrm.InfoChanged(Sender: TObject);
begin
  OKBtn.Enabled := (Length(ModifierEd.Text) > 0) and
    HexToBuffer(ModifierEd.Text, Modifier, SizeOf(Modifier));
end;

{*** TOgModifierProperty ***}

function TOgModifierProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TOgModifierProperty.GetValue : string;
begin
  Result := inherited GetValue;
end;

procedure TOgModifierProperty.Edit;
begin
  with TModifierFrm.Create(Application) do
    try
      if ShowModal = mrOK then
        Value := BufferToHex(Modifier, SizeOf(Modifier));
    finally
      Free;
    end;
end;

end.
