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

unit onguard6;
  {-Code generation dialog}

interface

uses
  {$IFDEF Win16} WinTypes, WinProcs, {$ENDIF}
  {$IFDEF Win32} Windows, ComCtrls, {$ENDIF}
  {$IFDEF MSWINDOWS}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Mask,
  ExtCtrls, Tabnotbk, StdCtrls, Buttons, Messages,
  {$ENDIF}
  {$IFDEF UseOgFMX}
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.ExtCtrls,
  FMX.Layouts, FMX.Edit, FMX.Platform, Fmx.StdCtrls, FMX.Header, FMX.Graphics,
  FMX.DateTimeCtrls,
  {$ENDIF}
  OgConst, OgUtil, OnGuard,
{$IFDEF DELPHI6UP}                                                      {!!.13}
  DesignIntf,
  DesignEditors;
{$ELSE}
  dsgnintf;
{$ENDIF}


type
  TModifierFrm = class(TForm)
    {$IFDEF MSWINDOWS}
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    {$ENDIF}
    {$IFDEF UseOgFMX}
    OKBtn: TButton;
    CancelBtn: TButton;
    {$ENDIF}
    GroupBox1: TGroupBox;
    UniqueModifierCb: TCheckBox;
    MachineModifierCb: TCheckBox;
    DateModifierCb: TCheckBox;
    NoModifierCb: TCheckBox;
    ModifierEd: TEdit;
    {$IFDEF MSWINDOWS}
    ModDateEd: TEdit;
    {$ENDIF}
    {$IFDEF UseOgFMX}
    ModDateCalendarEdit: TCalendarEdit;
    {$ENDIF}
    procedure FormCreate(Sender: TObject);
    procedure ModifierClick(Sender: TObject);
    {$IFDEF MSWINDOWS}
    procedure ModifierEdKeyPress(Sender: TObject; var Key: Char);
    procedure DateEdKeyPress(Sender: TObject; var Key: Char);
    {$ENDIF}
    procedure InfoChanged(Sender: TObject);
  private
  public
    Modifier : LongInt;
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

{$IFDEF MSWINDOWS}{$R *.DFM}{$ENDIF}
{$IFDEF UseOgFMX}{$R *.FMX}{$ENDIF}

procedure TModifierFrm.FormCreate(Sender: TObject);
begin
  NoModifierCb.Checked := True;
  {$IFDEF MSWINDOWS}
  ModDateEd.Text := OgFormatDate(Date);                              {!!.09}
  {$ENDIF}
  {$IFDEF UseOgFMX}
  ModDateCalendarEdit.Date := Date();
  {$ENDIF}
  InfoChanged(nil);
end;

procedure TModifierFrm.ModifierClick(Sender: TObject);
const
  Busy : Boolean = False;
var
  L : LongInt;
  D : TDateTime;
begin
  if Busy then
    Exit;

  {set busy flag so that setting "Checked" won't recurse}
  Busy := True;
  try
    L := 0;

    if (Sender = NoModifierCb) and NoModifierCb.Checked then begin
      UniqueModifierCb.Checked := False;
      MachineModifierCb.Checked := False;
      DateModifierCb.Checked := False;
    end else
      NoModifierCb.Checked := False;

    if not UniqueModifierCb.Checked and
       not MachineModifierCb.Checked and
       not DateModifierCb.Checked then
      NoModifierCb.Checked := True;

    if MachineModifierCb.Checked then begin
      if L = 0 then
        L := GenerateMachineModifierPrim
      else
        L := L xor GenerateMachineModifierPrim;
    end;

    {set status of date field}
    ModDateEd.Enabled := DateModifierCb.Checked;
    {$IFDEF MSWINDOWS}
    if ModDateEd.Enabled then
      ModDateEd.Color := clWindow
    else
      ModDateEd.Color := clBtnFace;
    {$ENDIF}

    if DateModifierCb.Checked then begin
      try
        {$IFDEF MSWINDOWS}
        D := StrToDate(ModDateEd.Text);
        {$ENDIF}
        {$IFDEF UseOgFMX}
        D := ModDateCalendarEdit.Date;
        {$ENDIF}
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

    if UniqueModifierCb.Checked then begin
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
    Busy := False;
  end;
end;

{$IFDEF MSWINDOWS}
procedure TModifierFrm.DateEdKeyPress(Sender: TObject; var Key: Char);
const
  CIntChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '/'];
begin
  if (not (Key in CIntChars)) and (not (Key < #32)) then begin
    MessageBeep(0);
    Key := #0;
  end;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TModifierFrm.ModifierEdKeyPress(Sender: TObject; var Key: Char);
const
  CHexChars = ['$', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not (Key in CHexChars)) and (not (Key < #32)) then begin
    MessageBeep(0);
    Key := #0;
  end;
end;
{$ENDIF}

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
