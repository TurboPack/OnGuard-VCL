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

{$IFDEF DELPHI}
{$IFDEF Win32}
  {$J+} {Assignable Typed Constants}                                   {!!.11}
{$ENDIF}
{$ENDIF}

unit onguard2;
  {-Code generation dialog}

interface

{.$DEFINE UseOgFMX}

uses
  {$IFDEF Win16} WinTypes, WinProcs, {$ENDIF}
  {$IFDEF Win32} Windows, ComCtrls, {$ENDIF}
  {$IFDEF MSWINDOWS}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Mask,
  ExtCtrls, Tabnotbk, StdCtrls, Buttons, Messages,
  {$ENDIF}
  {$IFDEF UseOgFMX}
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects,
  FMX.ExtCtrls, FMX.TabControl, FMX.Layouts, FMX.Edit, FMX.Platform,
  Fmx.StdCtrls, FMX.Header, FMX.Graphics, FMX.DateTimeCtrls,
  {$ENDIF}

  ogconst,
  ognetwrk,
  ogutil,
  onguard,
  onguard3;

{$IFNDEF UseOgFMX}
const
  OGM_CHECK = WM_USER + 100;
  OGM_QUIT  = WM_USER + 101;
{$ENDIF}

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
    {$IFNDEF UseOgFMX}
    CodesNbk: TTabbedNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    UsageExpiresEd: TEdit;
    SpecialExpiresEd: TEdit;
    SerialExpiresEd: TEdit;
    RegExpiresEd: TEdit;
    DaysExpiresEd: TEdit;
    ModDateEd: TEdit;
    StartDateEd: TEdit;
    EndDateEd: TEdit;
    DaysCountEd: TEdit;
    SerialNumberEd: TEdit;
    UsageCountEd: TEdit;
    NetworkSlotsEd: TEdit;
    SpecialDataEd: TEdit;
    {$ENDIF}
    RegCodeEd: TEdit;
    RegStrEd: TEdit;
    ModifierEd: TEdit;
    BlockKeyEd: TEdit;
    ModStringEd: TEdit;                                              {!!.11}

    {$IFDEF UseOgFMX}
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
    StartDateCalendarEdit: TCalendarEdit;
    EndDateCalendarEdit: TCalendarEdit;
    DaysCountSpinBox: TSpinBox;
    DaysExpiresCalendarEdit: TCalendarEdit;
    RegExpiresCalendarEdit: TCalendarEdit;
    SerialNumberNumberBox: TNumberBox;
    SerialExpiresCalendarEdit: TCalendarEdit;
    UsageCountNumberBox: TNumberBox;
    UsageExpiresCalendarEdit: TCalendarEdit;
    NetworkSlotsNumberBox: TNumberBox;
    SpecialDataNumberBox: TNumberBox;
    SpecialExpiresCalendarEdit: TCalendarEdit;
    ModDateCalendarEdit: TCalendarEdit;                                              {!!.11}
    {$ENDIF}

    procedure FormCreate(Sender: TObject);
    procedure ModifierClick(Sender: TObject);
    procedure RegRandomBtnClick(Sender: TObject);
    procedure GenerateBtnClick(Sender: TObject);
    procedure SerRandomBtnClick(Sender: TObject);
    procedure ParametersChanged(Sender: TObject);
    procedure ModifierEdKeyPress(Sender: TObject; var Key: Char);
    procedure RegStrCopySbClick(Sender: TObject);
    procedure RegCodeCopySbClick(Sender: TObject);
    {$IFNDEF UseOgFMX}
    procedure DateEdKeyPress(Sender: TObject; var Key: Char);
    procedure NumberEdKeyPress(Sender: TObject; var Key: Char);
    procedure TabbedNotebook1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    {$ENDIF}
    procedure GenerateKeySbClick(Sender: TObject);
    procedure InfoChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCode        : TCode;
    FCodeType    : TCodeType;
    FKey         : TKey;
    FKeyType     : TKeyType;
    FKeyFileName : string;

    {$IFNDEF UseOgFMX}
    procedure OGMCheck(var Msg : TMessage);
      message OGM_CHECK;
    procedure OGMQuit(var Msg : TMessage);
      message OGM_QUIT;
    {$ENDIF}

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

{$IFDEF MSWINDOWS}{$R *.DFM}{$ENDIF}
{$IFDEF UseOgFMX}{$R *.FMX}{$ENDIF}


procedure TCodeGenerateFrm.FormCreate(Sender: TObject);
var
  D : TDateTime;
begin
  NoModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := True;
  {$IFNDEF UseOgFMX}
  CodesNbk.PageIndex := Ord(FCodeType);
  {$ELSE}
  CodesTC.TabIndex := Ord(FCodeType);
  {$ENDIF}
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(BlockKeyEd.Text)then
    BlockKeyEd.Text := '';

  {initialize date edits}
  D := EncodeDate(9999,12,31);
  {$IFNDEF UseOgFMX}
  StartDateEd.Text      := OgFormatDate(Date);                       {!!.09}
  EndDateEd.Text        := OgFormatDate(Date);                       {!!.09}
  ModDateEd.Text        := OgFormatDate(Date);                       {!!.09}
  UsageExpiresEd.Text   := OgFormatDate(D);                          {!!.09}
  SpecialExpiresEd.Text := OgFormatDate(D);                          {!!.09}
  SerialExpiresEd.Text  := OgFormatDate(D);                          {!!.09}
  RegExpiresEd.Text     := OgFormatDate(D);                          {!!.09}
  DaysExpiresEd.Text    := OgFormatDate(D);                          {!!.09}
  {$ELSE}
  StartDateCalendarEdit.Date      := Date();
  EndDateCalendarEdit.Date        := Date();
  ModDateCalendarEdit.Date        := Date();
  DaysExpiresCalendarEdit.Date    := D;
  RegExpiresCalendarEdit.Date     := D;
  SerialExpiresCalendarEdit.Date  := D;
  UsageExpiresCalendarEdit.Date   := D;
  SpecialExpiresCalendarEdit.Date := D;
  {$ENDIF}
  NoModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := True;                                      {!!.11}
  InfoChanged(Self);
end;

procedure TCodeGenerateFrm.ModifierClick(Sender: TObject);
const
  Busy : Boolean = False;
var
  L : LongInt;
  D : TDateTime;
  S : string;                                                        {!!.11}
  i : Integer;                                                       {!!.12}
begin
  if Busy then
    Exit;

  {set busy flag so that setting "Checked" won't recurse}
  Busy := True;
  try
    L := 0;

    if (Sender = NoModifierCb) and NoModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} then begin
      UniqueModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := False;
      MachineModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := False;
      DateModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := False;
      StringModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := False;                             {!!.11}
      {$IFNDEF UseOgFMX}
      ModifierEd.Color := clBtnFace;                                 {!!.11}
      {$ENDIF}
      ModifierEd.ReadOnly := True;                                   {!!.11}
    end else begin
      NoModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} := False;
      {$IFNDEF UseOgFMX}
      ModifierEd.Color := clWindow;                                  {!!.11}
      {$ENDIF}
      ModifierEd.ReadOnly := False;                                  {!!.11}
    end;

    if MachineModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} then begin
      if L = 0 then
        L := GenerateMachineModifierPrim
      else
        L := L xor GenerateMachineModifierPrim;
    end;

    {set status of string field}                                     {!!.11}
    ModStringEd.Enabled := StringModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF};                 {!!.11}
    {$IFNDEF UseOgFMX}
    if ModStringEd.Enabled then                                      {!!.11}
      ModStringEd.Color := clWindow                                  {!!.11}
    else                                                             {!!.11}
      ModStringEd.Color := clBtnFace;                                {!!.11}
    {$ENDIF}
                                                                     {!!.11}
    if StringModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} then begin                           {!!.11}
      S := ModStringEd.Text;                                         {!!.11}
      {strip accented characters from the string}                    {!!.12}
      for i := Length(S) downto 1 do                                 {!!.12}
        if Ord(S[i]) > 127 then                                      {!!.12}
          Delete(S, i, 1);                                           {!!.12}
      L := StringHashELF(S);                                         {!!.11}
    end;                                                             {!!.11}

    {set status of date field}
    {$IFNDEF UseOgFMX}
    ModDateEd.Enabled := DateModifierCb.Checked;
    if ModDateEd.Enabled then
      ModDateEd.Color := clWindow
    else
      ModDateEd.Color := clBtnFace;
    {$ELSE}
    ModDateCalendarEdit.Enabled := DateModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF};
    {$ENDIF}

    if DateModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} then begin
      try
        {$IFNDEF UseOgFMX}
        D := StrToDate(ModDateEd.Text);
        {$ELSE}
        D := ModDateCalendarEdit.Date;
        {$ENDIF}
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

    if UniqueModifierCb.{$IFDEF UseOgFMX}IsChecked{$ELSE}Checked{$ENDIF} then begin
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
    Busy := False;
  end;
end;

procedure TCodeGenerateFrm.RegRandomBtnClick(Sender: TObject);
var
  I     : Integer;
  L     : LongInt;
  Bytes : array[0..3] of Byte absolute L;
begin
  Randomize;
  for I := 0 to 3 do
    Bytes[I] := Random(256);
  RegStrEd.Text := IntToHex(L, 8);
end;

procedure TCodeGenerateFrm.GenerateBtnClick(Sender: TObject);
var
  I        : LongInt;
  Work     : TCode;
  K        : TKey;
  Modifier : LongInt;
  D1, D2   : TDateTime;
begin
  Modifier := 0;
  if ((ModifierEd.Text = '') or HexToBuffer(ModifierEd.Text, Modifier, SizeOf(LongInt))) then begin
    K := FKey;
    ApplyModifierToKeyPrim(Modifier, K, SizeOf(K));

    case {$IFNDEF UseOgFMX}CodesNbk.PageIndex{$ELSE}CodesTC.TabIndex{$ENDIF} of
      0 : begin
            try
              {$IFNDEF UseOgFMX}
              D1 := StrToDate(StartDateEd.Text);
              {$ELSE}
              D1 := StartDateCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidStartDate]{$ELSE}SCInvalidStartDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                StartDateEd.SetFocus;
                {$ENDIF}
                {$IFDEF UseOgFMX}
                StartDateCalendarEdit.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;

            try
              {$IFNDEF UseOgFMX}
              D2 := StrToDate(EndDateEd.Text);
              {$ELSE}
              D2 := EndDateCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidStartDate]{$ELSE}SCInvalidStartDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                EndDateEd.SetFocus;
                {$ENDIF}
                {$IFDEF UseOgFMX}
                EndDateCalendarEdit.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;

            InitDateCode(K, Trunc(D1), Trunc(D2), FCode);
            Work := FCode;
            MixBlock(T128bit(K), Work, False);

            {sanity check}
            {$IFNDEF UseOgFMX}
            StartDateEd.Text := OgFormatDate(Work.FirstDate+BaseDate);  {!!.09}
            EndDateEd.Text := OgFormatDate(Work.EndDate+BaseDate);      {!!.09}
            {$ELSE}
            StartDateCalendarEdit.Date := Work.FirstDate+BaseDate;
            EndDateCalendarEdit.Date := Work.EndDate+BaseDate;
            {$ENDIF}
          end;
      1 : begin
            try
              {$IFNDEF UseOgFMX}
              D1 := StrToDate(DaysExpiresEd.Text);
              {$ELSE}
              D1 := DaysExpiresCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidExDate]{$ELSE}SCInvalidExDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                DaysExpiresEd.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;
            InitDaysCode(K, {$IFNDEF UseOgFMX}StrToIntDef(DaysCountEd.Text, 0){$ELSE}Trunc(DaysCountSpinBox.Value){$ENDIF}, D1, FCode);
          end;
      2 : begin
            try
              {$IFNDEF UseOgFMX}
              D1 := StrToDate(RegExpiresEd.Text);
              {$ELSE}
              D1 := RegExpiresCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidExDate]{$ELSE}SCInvalidExDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                RegExpiresEd.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;
            InitRegCode(K, RegStrEd.Text, D1, FCode);
          end;
      3 : begin
            try
              {$IFNDEF UseOgFMX}
              D1 := StrToDate(SerialExpiresEd.Text);
              {$ELSE}
              D1 := SerialExpiresCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidExDate]{$ELSE}SCInvalidExDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                SerialExpiresEd.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;
            InitSerialNumberCode(K, {$IFNDEF UseOgFMX}StrToIntDef(SerialNumberEd.Text, 0){$ELSE}Trunc(SerialNumberNumberBox.Value){$ENDIF}, D1, FCode);
          end;
      4 : begin
            try
              {$IFNDEF UseOgFMX}
              D1 := StrToDate(UsageExpiresEd.Text);
              {$ELSE}
              D1 := UsageExpiresCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidExDate]{$ELSE}SCInvalidExDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                UsageExpiresEd.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;
            InitUsageCode(K, {$IFNDEF UseOgFMX}StrToIntDef(UsageCountEd.Text, 0){$ELSE}Trunc(UsageCountNumberBox.Value){$ENDIF}, D1, FCode);
          end;
      5 : begin
            {$IFNDEF UseOgFMX}
            I := StrToIntDef(NetworkSlotsEd.Text, 2);
            if I < 1 then                                            {!!.08}
              I := 1;                                                {!!.08}
            NetworkSlotsEd.Text := IntToStr(I);
            {$ELSE}
            I := Trunc(NetworkSlotsNumberBox.Value);
            {$ENDIF}
            EncodeNAFCountCode(K, I, FCode);
          end;
      6 : begin
            try
              {$IFNDEF UseOgFMX}
              D1 := StrToDate(SpecialExpiresEd.Text);
              {$ELSE}
              D1 := SpecialExpiresCalendarEdit.Date;
              {$ENDIF}
            except
              on EConvertError do begin
                ShowMessage({$IFNDEF NoOgSrMgr}StrRes[SCInvalidExDate]{$ELSE}SCInvalidExDate{$ENDIF});
                {$IFDEF MSWINDOWS}
                SpecialExpiresEd.SetFocus;
                {$ENDIF}
                Exit;
              end else
                raise;
            end;
            InitSpecialCode(K, {$IFNDEF UseOgFMX}StrToIntDef(SpecialDataEd.Text, 0){$ELSE}Trunc(SpecialDataNumberBox.Value){$ENDIF}, D1, FCode);
          end;
    end;

    RegCodeEd.Text := BufferToHex(FCode, SizeOf(FCode));
  end else
    MessageDlg({$IFNDEF NoOgSrMgr}StrRes[SCInvalidKeyOrModifier]{$ELSE}SCInvalidKeyOrModifier{$ENDIF}, {$IFDEF UseOgFMX}TMsgDlgType.{$ENDIF}mtError, [TMsgDlgBtn.mbOK], 0);
end;

procedure TCodeGenerateFrm.SerRandomBtnClick(Sender: TObject);
var
  I     : Integer;
  L     : LongInt;
  Bytes : array[0..3] of Byte absolute L;
begin
  Randomize;
  for I := 0 to 3 do
    Bytes[I] := Random(256);
  {$IFNDEF UseOgFMX}
  SerialNumberEd.Text := IntToStr(Abs(L));
  {$ELSE}
  SerialNumberNumberBox.Value := Abs(L);
  {$ENDIF}
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

{!!.04}
{$IFNDEF UseOgFMX}
procedure TCodeGenerateFrm.DateEdKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', {$IFDEF DELPHI15UP}FormatSettings.DateSeparator{$ELSE}DateSeparator{$ENDIF}])) and (not (Key < #32)) then begin
    MessageBeep(0);
    Key := #0;
  end;
end;
{$ENDIF}

{$IFNDEF UseOgFMX}
procedure TCodeGenerateFrm.NumberEdKeyPress(Sender: TObject; var Key: Char);
const
  CIntChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not (Key in CIntChars)) and (not (Key < #32)) then begin
    MessageBeep(0);
    Key := #0;
  end;
end;
{$ENDIF}

procedure TCodeGenerateFrm.ModifierEdKeyPress(Sender: TObject; var Key: Char);
const
  CHexChars = ['$', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not (Key in CHexChars)) and (not (Key < #32)) then begin
    {$IFDEF MSWINDOWS}MessageBeep(0);{$ENDIF}
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

{$IFNDEF UseOgFMX}
procedure TCodeGenerateFrm.TabbedNotebook1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  AllowChange := True;

  RegCodeEd.Text := '';
  NoModifierCb.Checked := True;
  ModifierEd.Text := '';
end;
{$ENDIF}

procedure TCodeGenerateFrm.GenerateKeySbClick(Sender: TObject);
var
  F    : TKeyMaintFrm;
begin
  F := TKeyMaintFrm.Create(Self);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.KeyFileName := FKeyFileName;
    {$IFDEF MSWINDOWS}
    F.ShowHint := ShowHint;
    {$ENDIF}
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
  {$IFNDEF UseOgFMX}
  if Value <> TCodeType(CodesNbk.PageIndex) then begin
    FCodeType := Value;
    CodesNbk.PageIndex := Ord(FCodeType);
  end;
  {$ELSE}
  if Value <> TCodeType(CodesTC.TabIndex) then begin
    FCodeType := Value;
    CodesTC.TabIndex := Ord(FCodeType);
  end;
  {$ENDIF}
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

{$IFNDEF UseOgFMX}
procedure TCodeGenerateFrm.OGMCheck(var Msg : TMessage);
var
  F    : TKeyMaintFrm;
begin
  if not HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey)) then begin
    {get a key}
    F := TKeyMaintFrm.Create(Self);
    try
      F.SetKey(FKey);
      F.KeyType := ktRandom;
      F.KeyFileName := FKeyFileName;
      F.ShowHint := ShowHint;
      if F.ShowModal = mrOK then begin
        F.GetKey(FKey);
        BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
        if HexStringIsZero(BlockKeyEd.Text)then
          BlockKeyEd.Text := '';
        FKeyFileName := F.KeyFileName;
        InfoChanged(Self);
      end else
        PostMessage(Handle, OGM_QUIT, 0, 0);
    finally
      F.Free;
    end;
  end;
end;

procedure TCodeGenerateFrm.OGMQuit(var Msg : TMessage);
begin
  ModalResult := mrCancel;
end;
{$ENDIF}

procedure TCodeGenerateFrm.FormShow(Sender: TObject);
begin
  {$IFNDEF UseOgFMX}
  PostMessage(Handle, OGM_CHECK, 0, 0);
  {$ENDIF}
end;

procedure TCodeGenerateFrm.GetKey(var Value : TKey);
begin
  Value := FKey;
end;

end.
