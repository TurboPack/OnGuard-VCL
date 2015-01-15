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
{*                  ONGUARD3.PAS 1.13                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit qonguard3;
  {-Key selection and maintenance}

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, IniFiles,
  ogconst,
  ogutil,
  onguard,
  qonguard1,
  qonguard4;

type
  TKeyMaintFrm = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    FileNameGb: TGroupBox;
    OpenFileSb: TSpeedButton;
    OpenBtn: TBitBtn;
    FileNameEd: TEdit;
    ProductsGb: TGroupBox;
    AddBtn: TButton;
    EditBtn: TButton;
    DeleteBtn: TButton;
    ProductsLb: TListBox;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    CopyBlockKeySb: TSpeedButton;
    KeyPasteSb: TSpeedButton;
    CopyByteKeySb: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BlockKeyEd: TEdit;
    BytesKeyEd: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure InfoChanged(Sender: TObject);
    procedure ProductsLbDblClick(Sender: TObject);
    procedure CopyBlockKeySbClick(Sender: TObject);
    procedure KeyPasteSbClick(Sender: TObject);
    procedure CopyByteKeySbClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    function GetListBoxItemIndex : integer;                          {!!.07}
  private
    { Private declarations }
    FKey         : TKey;
    FKeyType     : TKeyType;

    function GetKeyFileName : string;
    procedure SetKeyFileName(Value : string);

  public
    { Public declarations }
    procedure SetKey(Value : TKey);                                  {!!.08}
    procedure GetKey(var Value : TKey);                              {!!.08}

    property KeyFileName : string
      read GetKeyFileName
      write SetKeyFileName;

    property KeyType : TKeyType
      read FKeyType
      write FKeyType;

  end;

var
  KeyMaintFrm: TKeyMaintFrm;

implementation

{$R *.xfm}

{!! This function is required to get round a bug in Delphi 4}        {!!.07}
function TKeyMaintFrm.GetListBoxItemIndex : integer;                 {!!.07}
begin                                                                {!!.07}
  if (ProductsLB.Items.Count = 0) then                               {!!.07}
    Result := -1                                                     {!!.07}
  else                                                               {!!.07}
    {Result := SendMessage(ProductsLB.Handle, LB_GETCURSEL, 0, 0);}  {!!.07}
    {Note: The above doesn't work - cannot delete item 0}            {!!.07}
    {      This works but looks odd in D4 so still a bug}            {!!.07}
    Result := ProductsLB.ItemIndex;                                  {!!.07}
end;                                                                 {!!.07}

procedure TKeyMaintFrm.FormCreate(Sender: TObject);
begin
  InfoChanged(Sender);
end;

procedure TKeyMaintFrm.OpenBtnClick(Sender: TObject);
begin
  OpenDialog1.FileName := FileNameEd.Text;
  FileNameEd.Text := OpenDialog1.FileName;
  InfoChanged(Sender);
end;

procedure TKeyMaintFrm.AddBtnClick(Sender: TObject);
var
  F       : TEditProductFrm;
  IniFile : TIniFile;
begin
  F := TEditProductFrm.Create(Self);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.ShowHint := ShowHint;
    if F.ShowModal = mrOK then begin
      IniFile := TIniFile.Create(KeyFileName);
      try
        IniFile.WriteString(OgKeySection, F.ProductEd.Text, F.KeyEd.Text);
      finally
        IniFile.Free;
      end;
      F.GetKey(FKey);
      FKeyType := F.KeyType;
    end;
  finally
    F.Free;
  end;

  InfoChanged(Self);
end;

procedure TKeyMaintFrm.EditBtnClick(Sender: TObject);
var
  F       : TEditProductFrm;
  IniFile : TIniFile;
begin
  F := TEditProductFrm.Create(Self);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.ShowHint := ShowHint;
    IniFile := TIniFile.Create(KeyFileName);
    try
      F.ProductEd.Text := ProductsLb.Items[GetListBoxItemIndex];     {!!.07}
      F.KeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
      if F.ShowModal = mrOK then
        IniFile.WriteString(OgKeySection, F.ProductEd.Text, F.KeyEd.Text);
    finally
      IniFile.Free;
    end;
  finally
    F.Free;
  end;

  InfoChanged(Self);
end;

procedure TKeyMaintFrm.DeleteBtnClick(Sender: TObject);
var
  IniFile : TIniFile;
  I       : Integer;
  {$IFNDEF Win32}
  Buf1    : array[0..255] of Char;
  Buf2    : array[0..255] of Char;
  {$ENDIF}
begin
  I := GetListBoxItemIndex;                                          {!!.07}
  if (I > -1) then                                                   {!!.07}
    if MessageDlg(StrRes[SCDeleteQuery], mtConfirmation,
       [mbYes, mbNo], 0) = mrYes then begin
      {$IFDEF Win32}
      IniFile := TIniFile.Create(KeyFileName);
      try
        IniFile.DeleteKey(OgKeySection, ProductsLb.Items[I]);        {!!.07}
      finally
        IniFile.Free;
      end;
      {$ELSE}
      {$IFDEF LINUX}
      IniFile := TIniFile.Create(KeyFileName);
      try
        IniFile.DeleteKey(OgKeySection, ProductsLb.Items[I]);        {!!.07}
      finally
        IniFile.Free;
      end;
      {$ELSE}
      StrPLCopy(Buf1, ProductsLb.Items[I], 255);                     {!!.07}
      StrPLCopy(Buf2, KeyFileName, 255);
      WritePrivateProfileString(OgKeySection, Buf1, nil, Buf2);
      {$ENDIF}
      {$ENDIF}
      BlockKeyEd.Text := '';
      BytesKeyEd.Text := '';

      InfoChanged(Self);
    end;
end;

procedure TKeyMaintFrm.InfoChanged(Sender: TObject);
var
  I       : Integer;
  IniFile : TIniFile;
begin
  OpenBtn.Enabled := Length(FileNameEd.Text) > 0;
  FillChar(FKey, SizeOf(FKey), 0);

  if Length(KeyFileName) > 0 then begin
    IniFile := TIniFile.Create(KeyFileName);
    try
      I := GetListBoxItemIndex;                                      {!!.07}
      ProductsLb.Items.BeginUpdate;
      try
        ProductsLb.Items.Clear;
        IniFile.ReadSection(OgKeySection, ProductsLb.Items);
        if I < ProductsLb.Items.Count then
          ProductsLb.ItemIndex := I                                  {!!.07}
        else begin                                                   {!!.07}
          ProductsLb.ItemIndex := pred(ProductsLb.Items.Count);      {!!.07}
          I := GetListBoxItemIndex;                                  {!!.07}
        end;                                                         {!!.07}

        if (I > -1) then begin                                       {!!.07}
          EditBtn.Enabled := True;                                   {!!.07}
          DeleteBtn.Enabled := True;                                 {!!.07}
          BlockKeyEd.Text := IniFile.ReadString(OgKeySection,
            ProductsLb.Items[I], '');                                {!!.07}

          HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey));

          BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
          BytesKeyEd.Text := BufferToHexBytes(FKey, SizeOf(FKey));

          if HexStringIsZero(BlockKeyEd.Text)then
            BlockKeyEd.Text := '';
          if HexStringIsZero(BytesKeyEd.Text)then
            BytesKeyEd.Text := '';
        end else begin                                               {!!.07}
          EditBtn.Enabled := False;                                  {!!.07}
          DeleteBtn.Enabled := False;                                {!!.07}
        end;                                                         {!!.07}
      finally
        ProductsLb.Items.EndUpdate;
      end;
    finally
      IniFile.Free;
    end;
  end else
    ProductsLb.Items.Clear;

  OKBtn.Enabled := HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey));
end;

procedure TKeyMaintFrm.ProductsLbDblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TKeyMaintFrm.CopyBlockKeySbClick(Sender: TObject);
var
  OldSelStart: Integer;
begin
  OldSelStart := BlockKeyEd.SelStart;
  BlockKeyEd.SelStart := 0;
  BlockKeyEd.SelLength := MaxInt;
  BlockKeyEd.CopyToClipboard;
  BlockKeyEd.SelStart := OldSelStart;
  BlockKeyEd.SelLength := 0;
end;

procedure TKeyMaintFrm.KeyPasteSbClick(Sender: TObject);
begin
  BlockKeyEd.PasteFromClipboard;
  HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey));
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
  BytesKeyEd.Text := BufferToHexBytes(FKey, SizeOf(FKey));
end;

procedure TKeyMaintFrm.CopyByteKeySbClick(Sender: TObject);
var
  OldSelStart: Integer;
begin
  OldSelStart := BytesKeyEd.SelStart;
  BytesKeyEd.SelStart := 0;
  BytesKeyEd.SelLength := MaxInt;
  BytesKeyEd.CopyToClipboard;
  BytesKeyEd.SelStart := OldSelStart;
  BytesKeyEd.SelLength := 0;
end;

procedure TKeyMaintFrm.SpeedButton1Click(Sender: TObject);
begin
  BytesKeyEd.PasteFromClipboard;
  HexToBuffer(BytesKeyEd.Text, FKey, SizeOf(FKey));
  BytesKeyEd.Text := BufferToHexBytes(FKey, SizeOf(FKey));
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
end;

procedure TKeyMaintFrm.GetKey(var Value : TKey);                     {!!.08}
begin
  Value := FKey;
end;

procedure TKeyMaintFrm.SetKey(Value : TKey);                         {!!.08}
begin
  FKey := Value;
end;

function TKeyMaintFrm.GetKeyFileName : string;
begin
  Result := FileNameEd.Text;
end;

procedure TKeyMaintFrm.SetKeyFileName(Value : string);
begin
  FileNameEd.Text := Value;
  InfoChanged(Self);
end;

end.
