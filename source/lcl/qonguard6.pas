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
 * Andrew Haines         andrew@haines.name                        {AH.01}
 *                       conversion to CLX                         {AH.01}
 *                       December 30, 2003                         {AH.01}
 *
 * ***** END LICENSE BLOCK ***** *)
{*********************************************************}
{*                  ONGUARD6.PAS 1.13                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I ONGUARD.INC}


unit qonguard6;                                                     {AH.01}
  {-Code generation dialog}

interface

uses
  SysUtils, Classes,                                               {AH.01}
  Graphics, Controls, Forms, Dialogs,{ Mask,}                   {AH.01}
  ExtCtrls, StdCtrls, Buttons,                                  {AH.01}
  ogutil, onguard,                                        {AH.01}
  ComponentEditors,
  PropEdits,
  LazarusPackageIntf;



type
  TModifierFrm = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    UniqueModifierCb: TCheckBox;
    MachineModifierCb: TCheckBox;
    DateModifierCb: TCheckBox;
    NoModifierCb: TCheckBox;
    ModifierEd: TEdit;
    ModDateEd: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ModifierClick(Sender: TObject);
    procedure ModifierEdKeyPress(Sender: TObject; var Key: Char);
    procedure DateEdKeyPress(Sender: TObject; var Key: Char);
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
uses
 LResources;



procedure TModifierFrm.FormCreate(Sender: TObject);
begin
  NoModifierCb.Checked := True;
  ModDateEd.Text := OgFormatDate(Date);                              {!!.09}

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
    if ModDateEd.Enabled then
      ModDateEd.Color := clWindow
    else
      ModDateEd.Color := clBtnFace;

    if DateModifierCb.Checked then begin
      try
        D := StrToDate(ModDateEd.Text);
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

procedure TModifierFrm.DateEdKeyPress(Sender: TObject; var Key: Char);
const
  CIntChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '/'];
begin
  if (not (Key in CIntChars)) and (not (Key < #32)) then begin
    Beep;
    Key := #0;
  end;
end;

procedure TModifierFrm.ModifierEdKeyPress(Sender: TObject; var Key: Char);
const
  CHexChars = ['$', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not (Key in CHexChars)) and (not (Key < #32)) then begin
    Beep;
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
        SetValue(BufferToHex(Modifier, SizeOf(Modifier)));
    finally
      Free;
    end;
end;

initialization
{$I qonguard6.lrs}


end.
