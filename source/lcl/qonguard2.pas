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

{$I ONGUARD.INC}


unit qonguard2;
  {-Code generation dialog}

interface

uses
//{$IFDEF MSWINDOWS}                                                 {AH.01}
//  Windows,
//  Messages,                                              {AH.01}
//{$ENDIF}                                                           {AH.01}
//{$IFDEF UsingCLX}                                                  {AH.01}
//  Types,                                                           {AH.01}
//{$ENDIF}                                                           {AH.01}
 LCLIntf,
 LResources,
//{$IFDEF LINUX}                                                     {AH.01}
//  Libc,                                                            {AH.01}
//{$ENDIF}                                                           {AH.01}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls,
  ogconst,
  ognetwrk,
  ogutil,
  onguard,
  qonguard3;                                                       {AH.01}

(*
{$IFDEF MSWINDOWS}                                                 {AH.01}
const
  OGM_CHECK = WM_USER + 100;
  OGM_QUIT  = WM_USER + 101;
{$ENDIF}                                                           {AH.01}
*)

type

  { TCodeGenerateFrm }

  TCodeGenerateFrm = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CodesNbk: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    RegRandomBtn: TButton;
    Label4: TLabel;
    RegStrCopySb: TSpeedButton;
    Label7: TLabel;
    Label15: TLabel;
    SerRandomBtn: TButton;
    Label14: TLabel;
    Label17: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    GroupBox1: TGroupBox;
    NoModifierCb: TCheckBox;
    MachineModifierCb: TCheckBox;
    UniqueModifierCb: TCheckBox;
    DateModifierCb: TCheckBox;
    StringModifierCb: TCheckBox;
    Label1: TLabel;
    Label5: TLabel;
    GenerateKeySb: TSpeedButton;
    GroupBox2: TGroupBox;
    GenerateBtn: TButton;
    RegCodeCopySb: TSpeedButton;
    ModDateEd: TEdit;
    ModStringEd: TEdit;
    ModifierEd: TEdit;
    BlockKeyEd: TEdit;
    RegCodeEd: TEdit;
    StartDateEd: TEdit;
    EndDateEd: TEdit;
    DaysCountEd: TEdit;
    DaysExpiresEd: TEdit;
    RegStrEd: TEdit;
    RegExpiresEd: TEdit;
    SerialNumberEd: TEdit;
    SerialExpiresEd: TEdit;
    UsageCountEd: TEdit;
    UsageExpiresEd: TEdit;
    NetworkSlotsEd: TEdit;
    SpecialDataEd: TEdit;
    SpecialExpiresEd: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GenerateBtnClick(Sender: TObject);
    procedure InfoChanged(Sender: TObject);
    procedure RegCodeCopySbClick(Sender: TObject);
    procedure ParametersChanged(Sender: TObject);
    procedure ModifierEdKeyPress(Sender: TObject; var Key: Char);
    procedure ModifierClick(Sender: TObject);
    procedure DateEdKeyPress(Sender: TObject; var Key: Char);
    procedure GenerateKeySbClick(Sender: TObject);
    procedure NumberKeyEdPress(Sender: TObject; var Key: Char);
    procedure RegStrCopySbClick(Sender: TObject);
    procedure RegRandomBtnClick(Sender: TObject);
    procedure CodesNbkChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure SerRandomBtnClick(Sender: TObject);
  private
    { Private declarations }
    FCode        : TCode;
    FCodeType    : TCodeType;
    FKey         : TKey;
    FKeyType     : TKeyType;
    FKeyFileName : string;

(*
{$IFDEF MSWINDOWS}                                                 {AH.01}
    procedure OGMCheck(var Msg : TMessage);
      message OGM_CHECK;
    procedure OGMQuit(var Msg : TMessage);
      message OGM_QUIT;
{$ELSE}                                                            {AH.01}
*)
    procedure OGMCheck;                                            {AH.01}
    procedure OGMQuit;                                             {AH.01}
//{$ENDIF}                                                           {AH.01}

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

var
  CodeGenerateFrm: TCodeGenerateFrm;

implementation



procedure TCodeGenerateFrm.FormCreate(Sender: TObject);
var
  D : TDateTime;
begin
  NoModifierCb.Checked := True;
  CodesNbk.ActivePageIndex := Ord(FCodeType);
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(BlockKeyEd.Text)then
    BlockKeyEd.Text := '';

  {initialize date edits}
  StartDateEd.Text := OgFormatDate(Date);                            {!!.09}
  EndDateEd.Text := OgFormatDate(Date);                              {!!.09}
  ModDateEd.Text := OgFormatDate(Date);                              {!!.09}
  D := EncodeDate(9999,12,31);
  UsageExpiresEd.Text := OgFormatDate(D);                            {!!.09}
  SpecialExpiresEd.Text := OgFormatDate(D);                          {!!.09}
  SerialExpiresEd.Text := OgFormatDate(D);                           {!!.09}
  RegExpiresEd.Text := OgFormatDate(D);                              {!!.09}
  DaysExpiresEd.Text := OgFormatDate(D);                             {!!.09}

  NoModifierCb.Checked := True;                                      {!!.11}
  InfoChanged(Self);
end;

procedure TCodeGenerateFrm.FormShow(Sender: TObject);
begin
  OGMCheck;
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

    case CodesNbk.ActivePageIndex of
      0 : begin
            try
              D1 := StrToDate(StartDateEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidStartDate);
                StartDateEd.SetFocus;
                Exit;
              end else
                raise;
            end;

            try
              D2 := StrToDate(EndDateEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidStartDate);
                EndDateEd.SetFocus;
                Exit;
              end else
                raise;
            end;

            InitDateCode(K, Trunc(D1), Trunc(D2), FCode);
            Work := FCode;
            MixBlock(T128bit(K), Work, False);

            {sanity check}
            StartDateEd.Text := OgFormatDate(Work.FirstDate+BaseDate);  {!!.09}
            EndDateEd.Text := OgFormatDate(Work.EndDate+BaseDate);      {!!.09}
          end;
      1 : begin
            try
              D1 := StrToDate(DaysExpiresEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                DaysExpiresEd.SetFocus;
                Exit;
              end else
                raise;
            end;
            InitDaysCode(K, StrToIntDef(DaysCountEd.Text, 0), D1, FCode);
          end;
      2 : begin
            try
              D1 := StrToDate(RegExpiresEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                RegExpiresEd.SetFocus;
                Exit;
              end else
                raise;
            end;
            InitRegCode(K, RegStrEd.Text, D1, FCode);
          end;
      3 : begin
            try
              D1 := StrToDate(SerialExpiresEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                SerialExpiresEd.SetFocus;
                Exit;
              end else
                raise;
            end;
            InitSerialNumberCode(K, StrToIntDef(SerialNumberEd.Text, 0), D1, FCode);
          end;
      4 : begin
            try
              D1 := StrToDate(UsageExpiresEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                UsageExpiresEd.SetFocus;
                Exit;
              end else
                raise;
            end;
            InitUsageCode(K, StrToIntDef(UsageCountEd.Text, 0), D1, FCode);
          end;
      5 : begin
            I := StrToIntDef(NetworkSlotsEd.Text, 2);
            if I < 1 then                                            {!!.08}
              I := 1;                                                {!!.08}
            NetworkSlotsEd.Text := IntToStr(I);
            EncodeNAFCountCode(K, I, FCode);
          end;
      6 : begin
            try
              D1 := StrToDate(SpecialExpiresEd.Text);
            except
              on EConvertError do begin
                ShowMessage(SCInvalidExDate);
                SpecialExpiresEd.SetFocus;
                Exit;
              end else
                raise;
            end;
            InitSpecialCode(K, StrToIntDef(SpecialDataEd.Text, 0), D1, FCode);
          end;
    end;

    RegCodeEd.Text := BufferToHex(FCode, SizeOf(FCode));
  end else
    MessageDlg(SCInvalidKeyOrModifier, mtError, [mbOK], 0);
end;

procedure TCodeGenerateFrm.InfoChanged(Sender: TObject);
begin
 // GenerateBtn.Enabled := HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey));
 // OKBtn.Enabled := Length(RegCodeEd.Text) > 0;
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

procedure TCodeGenerateFrm.ParametersChanged(Sender: TObject);
begin
  RegCodeEd.Text := '';
end;

procedure TCodeGenerateFrm.ModifierEdKeyPress(Sender: TObject; var Key: Char);
const
  CHexChars = ['$', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not (Key in CHexChars)) and (not (Key < #32)) then begin
    Beep();
    Key := #0;
  end;
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

    if (Sender = NoModifierCb) and NoModifierCb.Checked then begin
      UniqueModifierCb.Checked := False;
      MachineModifierCb.Checked := False;
      DateModifierCb.Checked := False;
      StringModifierCb.Checked := False;                             {!!.11}
      ModifierEd.Color := clBtnFace;                                 {!!.11}
      ModifierEd.ReadOnly := True;                                   {!!.11}
    end else begin
      NoModifierCb.Checked := False;
      ModifierEd.Color := clWindow;                                  {!!.11}
      ModifierEd.ReadOnly := False;                                  {!!.11}
    end;

(*
    if not UniqueModifierCb.Checked and
       not MachineModifierCb.Checked and
       not DateModifierCb.Checked and
       not StringModifierCb.Checked and                              {!!.11}
       (ModifierEd.Text = '') then begin                             {!!.11}
      NoModifierCb.Checked := True;
      ModifierEd.Color := clBtnFace;                                 {!!.11}
      ModifierEd.ReadOnly := True;                                   {!!.11}
    end;
*)
    if MachineModifierCb.Checked then begin
      if L = 0 then
        L := GenerateMachineModifierPrim
      else
        L := L xor GenerateMachineModifierPrim;
    end;

    {set status of string field}                                     {!!.11}
    ModStringEd.Enabled := StringModifierCb.Checked;                 {!!.11}
    if ModStringEd.Enabled then                                      {!!.11}
      ModStringEd.Color := clWindow                                  {!!.11}
    else                                                             {!!.11}
      ModStringEd.Color := clBtnFace;                                {!!.11}
                                                                     {!!.11}
    if StringModifierCb.Checked then begin                           {!!.11}
      S := ModStringEd.Text;                                         {!!.11}
      {strip accented characters from the string}                    {!!.12}
      for i := Length(S) downto 1 do                                 {!!.12}
        if Ord(S[i]) > 127 then                                      {!!.12}
          Delete(S, i, 1);                                           {!!.12}
      L := StringHashELF(S);                                         {!!.11}
    end;                                                             {!!.11}

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

      if Trunc(D) <> 0 then begin
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
  finally
    Busy := False;
  end;
end;

procedure TCodeGenerateFrm.DateEdKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', DateSeparator])) and (not (Key < #32)) then begin
    Beep();
    Key := #0;
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
    F.ShowHint := ShowHint;
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

procedure TCodeGenerateFrm.NumberKeyEdPress(Sender: TObject; var Key: Char);
const
  CIntChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
begin
  if (not (Key in CIntChars)) and (not (Key < #32)) then begin
    Beep();
    Key := #0;
  end;
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

procedure TCodeGenerateFrm.CodesNbkChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := True;

  RegCodeEd.Text := '';
  NoModifierCb.Checked := True;
  ModifierEd.Text := '';
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
  SerialNumberEd.Text := IntToHex(L, 8);
end;

procedure TCodeGenerateFrm.GetKey(var Value : TKey);
begin
  Value := FKey;
end;

(*
{$IFDEF MSWINDOWS}                                                 {AH.01}
procedure TCodeGenerateFrm.OGMQuit(var Msg : TMessage);
begin
  ModalResult := mrCancel;
end;
{$ELSE}                                                            {AH.01}
*)

procedure TCodeGenerateFrm.OGMQuit;                                {AH.01}
begin
  ModalResult := mrCancel;
end;


(*
{$IFDEF MSWINDOWS}                                                 {AH.01}
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
        PostMessage(HWND(Handle), OGM_QUIT, 0, 0);
    finally
      F.Free;
    end;
  end;
end;
{$ELSE}                                                            {AH.01}
*)

procedure TCodeGenerateFrm.OGMCheck;                               {AH.01}
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
        OGMQuit;
    finally
      F.Free;
    end;
  end;
end;


procedure TCodeGenerateFrm.SetKey(Value : TKey);
begin
  FKey := Value;
  BlockKeyEd.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(BlockKeyEd.Text)then
    BlockKeyEd.Text := '';
end;

procedure TCodeGenerateFrm.SetCodeType(Value : TCodeType);
begin
  if Value <> TCodeType(CodesNbk.ActivePageIndex) then begin
    FCodeType := Value;
    CodesNbk.ActivePageIndex := Ord(FCodeType);
  end;
end;

initialization
{$I qonguard2.lrs}


end.
