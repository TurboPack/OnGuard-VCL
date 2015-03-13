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
{*                  ONGUARD1.PAS 1.15                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit onguard1Fmx;
  {-Key generation dialog}

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.ExtCtrls,
  FMX.Memo, FMX.Edit, FMX.Platform, Fmx.StdCtrls, FMX.Header, FMX.Graphics,
  FMX.ListBox, FMX.Controls.Presentation, FMX.Layouts, ogutilFmx, onguardFmx,
  FMX.ScrollBox;

type
  TKeyGenerateFrm = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    CopyBlockSb: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    CopyByteKeySb: TSpeedButton;
    KeyStringMe: TMemo;
    BlockKeyEd: TEdit;
    GenerateBtn: TButton;
    KeyTypeCb: TComboBox;
    ByteKeyEd: TEdit;
    CancelBtn: TButton;
    OKBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure KeyStringMeChange(Sender: TObject);
    procedure KeyTypeCbChange(Sender: TObject);
    procedure BlockKeyEdChange(Sender: TObject);
    procedure CopyBlockSbClick(Sender: TObject);
    procedure ByteKeyEdChange(Sender: TObject);
    procedure CopyByteKeySbClick(Sender: TObject);
    procedure GenerateBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FKey     : TKey;
    FKeyType : TKeyType;

    procedure SetKeyType(Value : TKeyType);

  public
    { Public declarations }                                          
    procedure SetKey(Value : TKey);                                  {!!.08}
    procedure GetKey(var Value : TKey);                              {!!.08}

    property KeyType : TKeyType
      read FKeyType
      write SetKeyType;

  end;


implementation

{$R *.fmx}

procedure TKeyGenerateFrm.FormCreate(Sender: TObject);
begin
  KeyTypeCb.ItemIndex := Ord(FKeyType);

  {set state of memo and generate button}
  KeyStringMe.Enabled := (KeyTypeCb.ItemIndex <> 0);
  GenerateBtn.Enabled := (KeyTypeCb.ItemIndex = 0) or
    (KeyStringMe.Lines.Count > 0);
end;

procedure TKeyGenerateFrm.KeyStringMeChange(Sender: TObject);
begin
  BlockKeyEd.Text := '';
  ByteKeyEd.Text := '';

  {set state of generate button}
  GenerateBtn.Enabled := (KeyTypeCb.ItemIndex = 0) or
    (KeyStringMe.Lines.Count > 0);
end;

procedure TKeyGenerateFrm.KeyTypeCbChange(Sender: TObject);
begin
  BlockKeyEd.Text := '';
  ByteKeyEd.Text := '';

  {set state of memo and generate button}
  KeyStringMe.Enabled := (KeyTypeCb.ItemIndex <> 0);
  GenerateBtn.Enabled := (KeyTypeCb.ItemIndex = 0) or
    (KeyStringMe.Lines.Count > 0);

  if KeyTypeCb.ItemIndex > -1 then
    FKeyType := TKeyType(KeyTypeCb.ItemIndex);
end;

procedure TKeyGenerateFrm.BlockKeyEdChange(Sender: TObject);
begin
  CopyBlockSb.Enabled := (BlockKeyEd.Text <> '');
end;

procedure TKeyGenerateFrm.CopyBlockSbClick(Sender: TObject);
var
  OldSelStart: Integer;
begin
  if (BlockKeyEd.SelLength > 0) then
    BlockKeyEd.CopyToClipboard
  else begin
    OldSelStart := BlockKeyEd.SelStart;
    BlockKeyEd.SelStart := 0;
    BlockKeyEd.SelLength := MaxInt;
    BlockKeyEd.CopyToClipboard;
    BlockKeyEd.SelStart := OldSelStart;
    BlockKeyEd.SelLength := 0;
  end;
end;

procedure TKeyGenerateFrm.ByteKeyEdChange(Sender: TObject);
begin
  CopyByteKeySb.Enabled := (ByteKeyEd.Text <> '');
end;

procedure TKeyGenerateFrm.CopyByteKeySbClick(Sender: TObject);
var
  OldSelStart: Integer;
begin
  if (ByteKeyEd.SelLength > 0) then
    ByteKeyEd.CopyToClipboard
  else begin
    OldSelStart := ByteKeyEd.SelStart;
    ByteKeyEd.SelStart := 0;
    ByteKeyEd.SelLength := MaxInt;
    ByteKeyEd.CopyToClipboard;
    ByteKeyEd.SelStart := OldSelStart;
    ByteKeyEd.SelLength := 0;
  end;
end;

procedure TKeyGenerateFrm.GenerateBtnClick(Sender: TObject);
begin
  case KeyTypeCb.ItemIndex of
    0:
      begin
        GenerateRandomKeyPrim(FKey, SizeOf(FKey));
        BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
        ByteKeyEd.Text := BufferToHexBytes(FKey, SizeOf(FKey));
      end;
    1:
      begin
        GenerateTMDKeyPrim(FKey, SizeOf(FKey), AnsiUpperCase(KeyStringMe.Text));
        BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
        ByteKeyEd.Text := BufferToHexBytes(FKey, SizeOf(FKey));
      end;
    2:
      begin
        GenerateTMDKeyPrim(FKey, SizeOf(FKey), KeyStringMe.Text);
        BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
        ByteKeyEd.Text := BufferToHexBytes(FKey, SizeOf(FKey));
      end;
  end;
end;

procedure TKeyGenerateFrm.SetKeyType(Value : TKeyType);
begin
  if Value <> FKeyType then begin
    FKeyType := Value;
    KeyTypeCb.ItemIndex := Ord(FKeyType);
  end;
end;

procedure TKeyGenerateFrm.GetKey(var Value : TKey);
begin
  Value := FKey;
end;

procedure TKeyGenerateFrm.SetKey(Value : TKey);
begin
  FKey := Value;
end;


procedure TKeyGenerateFrm.FormShow(Sender: TObject);
begin
  KeyTypeCbChange(Sender);
end;

end.

