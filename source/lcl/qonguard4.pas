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
{*                  ONGUARD4.PAS 1.13                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I ONGUARD.INC}


unit qonguard4;
  {-Product description dialog}

interface

uses
  SysUtils,Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ogutil, onguard, qonguard1, Buttons, ExtCtrls,LResources;

type
  TEditProductFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    GenerateKeySb: TSpeedButton;
    KeyPasteSb: TSpeedButton;
    ProductEd: TEdit;
    KeyEd: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure InfoChanged(Sender: TObject);
    procedure KeyPasteSbClick(Sender: TObject);
    procedure GenerateKeySbClick(Sender: TObject);
  private
    { Private declarations }
    FKey         : TKey;
    FKeyType     : TKeyType;

    function GetShowHints : Boolean;
    procedure SetShowHints(Value : Boolean);

  public
    { Public declarations }
    procedure SetKey(Value : TKey);                                  {!!.08}
    procedure GetKey(var Value : TKey);                              {!!.08}

    property KeyType : TKeyType
      read FKeyType
      write FKeyType;

    property ShowHints : Boolean
      read GetShowHints
      write SetShowHints;
  end;

var
  EditProductFrm: TEditProductFrm;

implementation



procedure TEditProductFrm.FormCreate(Sender: TObject);
begin
  InfoChanged(Sender);
end;

procedure TEditProductFrm.InfoChanged(Sender: TObject);
var
  Work: TKey;
begin
  {$HINTS OFF}
  FillChar(Work, SizeOf(Work), 0); // Fill array with zeros
  {$HINTS ON}
  OKBtn.Enabled := (Length(ProductEd.Text) > 0) and
    (HexToBuffer(KeyEd.Text, Work, SizeOf(Work)));
end;

procedure TEditProductFrm.KeyPasteSbClick(Sender: TObject);
begin
  KeyEd.PasteFromClipboard;
end;

procedure TEditProductFrm.GenerateKeySbClick(Sender: TObject);
var
  F    : TKeyGenerateFrm;
begin
  F := TKeyGenerateFrm.Create(Self);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.ShowHint := GetShowHints;
    if F.ShowModal = mrOK then begin
      F.GetKey(FKey);
      FKeyType := F.KeyType;
      KeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
      if HexStringIsZero(KeyEd.Text)then begin
        KeyEd.Text := '';
        FillChar(FKey, SizeOf(FKey), 0);
      end;

      InfoChanged(Sender);
    end;
  finally
    F.Free;
  end;
end;

function TEditProductFrm.GetShowHints : Boolean;
begin
  Result := ShowHint;
end;

procedure TEditProductFrm.SetShowHints(Value : Boolean);
begin
  ShowHint := Value;
end;

procedure TEditProductFrm.GetKey(var Value : TKey);
begin
  Value := FKey;
end;

procedure TEditProductFrm.SetKey(Value : TKey);
begin
  FKey := Value;
end;

initialization
{$I qonguard4.lrs}


end.
