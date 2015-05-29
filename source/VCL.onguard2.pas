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
{*                  ONGUARD2.PAS 1.15                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit FMX.onguard2;
  {-Code generation dialog}

interface

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.SpinBox, FMX.ExtCtrls, FMX.TabControl, FMX.Layouts,
  FMX.Edit, FMX.Platform, Fmx.StdCtrls, FMX.Header, FMX.Graphics, FMX.DateTimeCtrls,
  FMX.CalendarEdit, FMX.NumberBox, FMX.onguard, FMX.onguard3, FMX.EditBox,
  FMX.ComboEdit, FMX.Controls.Presentation, FMX.ogutil;

type
  TCodeGenerateFrm = class(TForm)
    GroupBox1: TGroupBox;
    GenerateGb: TGroupBox;
    RegCodeCopySb: TSpeedButton;
    RegStrCopySb: TSpeedButton;
    GenerateKeySb: TSpeedButton;
    GenerateBtn: TButton;
    RegRandomBtn: TButton;
    SerRandomBtn: TButton;
    StringModifierCb: TCheckBox;                                     {!!.11}
    UniqueModifierCb: TCheckBox;
    MachineModifierCb: TCheckBox;
    DateModifierCb: TCheckBox;
    NoModifierCb: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    RegCodeEd: TEdit;
    RegStrEd: TEdit;
    ModifierEd: TEdit;
    BlockKeyEd: TEdit;
    ModStringEd: TEdit;                                              {!!.11}
    OKBtn: TButton;
    CancelBtn: TButton;
    CodesTC: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    TabItem7: TTabItem;
    StartDateCalendarEdit: TDateEdit;
    EndDateCalendarEdit: TDateEdit;
    DaysCountSpinBox: TSpinBox;
    DaysExpiresCalendarEdit: TDateEdit;
    RegExpiresCalendarEdit: TDateEdit;
    SerialNumberNumberBox: TNumberBox;
    SerialExpiresCalendarEdit: TDateEdit;
    UsageCountNumberBox: TNumberBox;
    UsageExpiresCalendarEdit: TDateEdit;
    NetworkSlotsNumberBox: TNumberBox;
    SpecialDataNumberBox: TNumberBox;
    SpecialExpiresCalendarEdit: TDateEdit;
    ModDateCalendarEdit: TDateEdit;                                              {!!.11}

    procedure FormCreate(Sender: TObject);
    procedure ModifierClick(Sender: TObject);
    procedure RegRandomBtnClick(Sender: TObject);
    procedure GenerateBtnClick(Sender: TObject);
    procedure SerRandomBtnClick(Sender: TObject);
    procedure ParametersChanged(Sender: TObject);
    procedure ModifierEdKeyPress(Sender: TObject; var Key: Char);
    procedure RegStrCopySbClick(Sender: TObject);
    procedure RegCodeCopySbClick(Sender: TObject);
    procedure GenerateKeySbClick(Sender: TObject);
    procedure InfoChanged(Sender: TObject);
  private
    FBusy        : Boolean;
    FCode        : TCode;
    FCodeType    : TCodeType;
    FKey         : TKey;
    FKeyType     : TKeyType;
    FKeyFileName : string;

    procedure SetCodeType(Value : TCodeType);

  public
    procedure SetKey(Value : TKey);                                  {!!.08}
    procedure GetKey(var Value : TKey);                              {!!.08}

    property Code : TCode
      read FCode;

    property CodeType : TCodeType
      read FCodeType
      write SetCodeType;

    property KeyFileName : string
      read FKeyFileName
      write FKeyFileName;

    property KeyType : TKeyType
      read FKeyType
      write FKeyType;
  end;


implementation

{$R *.fmx}

uses
  System.Character, FMX.ognetwrk;

resourcestring
  SCInvalidStartDate = 'Invalid start date';
  SCInvalidKeyOrModifier = 'Invalid key or modifier';
  SCInvalidExDate = 'Invalid expiration date';

{ TCodeGenerateFrm }

procedure TCodeGenerateFrm.FormCreate(Sender: TObject);
var
  D : TDateTime;
begin
  NoModifierCb.IsChecked := True;
  CodesTC.TabIndex := Ord(FCodeType);
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(BlockKeyEd.Text)then
    BlockKeyEd.Text := '';

  {initialize date edits}
  D := EncodeDate(9999,12,31);
  StartDateCalendarEdit.Date      := Date();
  EndDateCalendarEdit.Date        := Date();
  ModDateCalendarEdit.Date        := Date();
  DaysExpiresCalendarEdit.Date    := D;
  RegExpiresCalendarEdit.Date     := D;
  SerialExpiresCalendarEdit.Date  := D;
  UsageExpiresCalendarEdit.Date   := D;
  SpecialExpiresCalendarEdit.Date := D;
  NoModifierCb.IsChecked := True;                                      {!!.11}
  InfoChanged(Self);
end;

procedure TCodeGenerateFrm.ModifierClick(Sender: TObject);
var
  L : Integer;
  D : TDateTime;
  S : string;                                                        {!!.11}
  i : Integer;                                                       {!!.12}
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
      StringModifierCb.IsChecked := False;                             {!!.11}
      ModifierEd.ReadOnly := True;                                   {!!.11}
    end else begin
      NoModifierCb.IsChecked := False;
      ModifierEd.ReadOnly := False;                                  {!!.11}
    end;

    if MachineModifierCb.IsChecked then begin
      if L = 0 then
        L := GenerateMachineModifierPrim
      else
        L := L xor GenerateMachineModifierPrim;
    end;

    {set status of string field}                                     {!!.11}
    ModStringEd.Enabled := StringModifierCb.IsChecked;                 {!!.11}
                                                                     {!!.11}
    if StringModifierCb.IsChecked then begin                           {!!.11}
      S := ModStringEd.Text;                                         {!!.11}
      {strip accented characters from the string}                    {!!.12}
      for i := S.Length downto 0 do                                  {!!.12}
        if Ord(S.Chars[i]) > 127 then                                {!!.12}
          S.Remove(i, 1);                                             {!!.12}
      L := StringHashELF(S);                                         {!!.11}
    end;                                                             {!!.11}

    {set status of date field}
    ModDateCalendarEdit.Enabled := DateModifierCb.IsChecked;

    if DateModifierCb.IsChecked then begin
      try
        D := ModDateCalendarEdit.Date;
      except
        {ignore errors and don't generate modifier}
        D := 0;
      end;

      if Trunc(D) <> 0 then begin
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
  finally
    FBusy := False;
  end;
end;

procedure TCodeGenerateFrm.RegRandomBtnClick(Sender: TObject);
var
  I     : Integer;
  L     : Integer;
  Bytes : array[0..3] of Byte absolute L;
begin
  Randomize;
  for I := 0 to 3 do
    Bytes[I] := Random(256);
  RegStrEd.Text := IntToHex(L, 8);
end;

procedure TCodeGenerateFrm.GenerateBtnClick(Sender: TObject);
var
  I        : Integer;
  Work     : TCode;
  K        : TKey;
  Modifier : Integer;
  D1, D2   : TDateTime;
begin
  Modifier := 0;
  if ((ModifierEd.Text = '') or HexToBuffer(ModifierEd.Text, Modifier, SizeOf(Integer))) then begin
    K := FKey;
    ApplyModifierToKeyPrim(Modifier, K, SizeOf(K));

    case CodesTC.TabIndex of
      0 : begin
            try
              D1 := StartDateCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidStartDate);
                StartDateCalendarEdit.SetFocus;
                Exit;
              end else
                raise;
            end;

            try
              D2 := EndDateCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidStartDate);
                EndDateCalendarEdit.SetFocus;
                Exit;
              end else
                raise;
            end;

            InitDateCode(K, Trunc(D1), Trunc(D2), FCode);
            Work := FCode;
            MixBlock(T128bit(K), Work, False);

            {sanity check}
            StartDateCalendarEdit.Date := Work.FirstDate+BaseDate;
            EndDateCalendarEdit.Date := Work.EndDate+BaseDate;
          end;
      1 : begin
            try
              D1 := DaysExpiresCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                Exit;
              end else
                raise;
            end;
            InitDaysCode(K, Trunc(DaysCountSpinBox.Value), D1, FCode);
          end;
      2 : begin
            try
              D1 := RegExpiresCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                Exit;
              end else
                raise;
            end;
            InitRegCode(K, RegStrEd.Text, D1, FCode);
          end;
      3 : begin
            try
              D1 := SerialExpiresCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                Exit;
              end else
                raise;
            end;
            InitSerialNumberCode(K, Trunc(SerialNumberNumberBox.Value), D1, FCode);
          end;
      4 : begin
            try
              D1 := UsageExpiresCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                Exit;
              end else
                raise;
            end;
            InitUsageCode(K, Trunc(UsageCountNumberBox.Value), D1, FCode);
          end;
      5 : begin
            I := Trunc(NetworkSlotsNumberBox.Value);
            EncodeNAFCountCode(K, I, FCode);
          end;
      6 : begin
            try
              D1 := SpecialExpiresCalendarEdit.Date;
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                Exit;
              end else
                raise;
            end;
            InitSpecialCode(K, Trunc(SpecialDataNumberBox.Value), D1, FCode);
          end;
    end;

    RegCodeEd.Text := BufferToHex(FCode, SizeOf(FCode));
  end else
    MessageDlg(SCInvalidKeyOrModifier, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
end;

procedure TCodeGenerateFrm.SerRandomBtnClick(Sender: TObject);
var
  I     : Integer;
  L     : Integer;
  Bytes : array[0..3] of Byte absolute L;
begin
  Randomize;
  for I := 0 to 3 do
    Bytes[I] := Random(256);
  SerialNumberNumberBox.Value := Abs(L);
end;

procedure TCodeGenerateFrm.ParametersChanged(Sender: TObject);
begin
  RegCodeEd.Text := '';
end;

procedure TCodeGenerateFrm.RegStrCopySbClick(Sender: TObject);
var
  OldSelStart: Integer;
begin
  if (RegStrEd.SelLength > 0) then
    RegStrEd.CopyToClipboard
  else begin
    OldSelStart := RegStrEd.SelStart;
    RegStrEd.SelStart := 0;
    RegStrEd.SelLength := MaxInt;
    RegStrEd.CopyToClipboard;
    RegStrEd.SelStart := OldSelStart;
    RegStrEd.SelLength := 0;
  end;
end;

procedure TCodeGenerateFrm.ModifierEdKeyPress(Sender: TObject; var Key: Char);
var
  pChars: TArray<Char>;
  cBuffer: Char;
begin
  pChars := TArray<Char>.Create('$', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
  cBuffer := Key.ToUpper;
  if (not cBuffer.IsInArray(pChars)) and (not (Key < #32)) then begin
    Key := #0;
  end;
end;

procedure TCodeGenerateFrm.RegCodeCopySbClick(Sender: TObject);
var
  OldSelStart: Integer;
begin
  if (RegCodeEd.SelLength > 0) then
    RegCodeEd.CopyToClipboard
  else begin
    OldSelStart := RegCodeEd.SelStart;
    RegCodeEd.SelStart := 0;
    RegCodeEd.SelLength := MaxInt;
    RegCodeEd.CopyToClipboard;
    RegCodeEd.SelStart := OldSelStart;
    RegCodeEd.SelLength := 0;
  end;
end;

procedure TCodeGenerateFrm.GenerateKeySbClick(Sender: TObject);
var
  F    : TKeyMaintFrm;
begin
  F := TKeyMaintFrm.Create(Self);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.KeyFileName := FKeyFileName;
    if F.ShowModal = mrOK then begin
      F.GetKey(FKey);
      BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
      if HexStringIsZero(BlockKeyEd.Text)then
        BlockKeyEd.Text := '';
      FKeyType := F.KeyType;
      FKeyFileName := F.KeyFileName;
      InfoChanged(Self);
    end;
  finally
    F.Free;
  end;
end;

procedure TCodeGenerateFrm.SetCodeType(Value : TCodeType);
begin
  if Value <> TCodeType(CodesTC.TabIndex) then begin
    FCodeType := Value;
    CodesTC.TabIndex := Ord(FCodeType);
  end;
end;

procedure TCodeGenerateFrm.SetKey(Value : TKey);
begin
  FKey := Value;
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(BlockKeyEd.Text)then
    BlockKeyEd.Text := '';
end;

procedure TCodeGenerateFrm.InfoChanged(Sender: TObject);
begin
  GenerateBtn.Enabled := HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey));
  OKBtn.Enabled := Length(RegCodeEd.Text) > 0;
end;

procedure TCodeGenerateFrm.GetKey(var Value : TKey);
begin
  Value := FKey;
end;

end.

