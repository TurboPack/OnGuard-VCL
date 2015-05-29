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
{*                  ONGUARD.PAS 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit Vcl.onguard;
  {-code and key classes and routines}

interface

uses
  System.Classes, System.SysUtils, System.UITypes, Winapi.Windows, Vcl.ogutil;

{$REGION 'Component declarations'}
type
  TChangeCodeEvent =
    procedure(Sender : TObject; Code : TCode)
    of object;
  TCheckedCodeEvent =
    procedure(Sender : TObject; Status : TCodeStatus)
    of object;
  TGetCodeEvent =
    procedure(Sender : TObject; var Code : TCode)
    of object;
  TGetKeyEvent =
    procedure(Sender : TObject; var Key : TKey)
    of object;
  TGetModifierEvent =
    procedure(Sender : TObject; var Value : Integer)
    of object;
  TGetRegStringEvent =
    procedure(Sender : TObject; var Value : string)
    of object;

  {base regisration code component}
  TOgCodeBase = class(TComponent)
  protected {private}
    {property variables}
    FAutoCheck     : Boolean;          {true to test code when loaded}
    FCode          : TCode;            {release code}
    FModifier      : Integer;          {key modifier}
    FStoreCode     : Boolean;          {true to store release code on stream}
    FStoreModifier : Boolean;          {true to store key modifier on stream}

    {event variables}
    FOnChecked     : TCheckedCodeEvent;{called after auto check is made}
    FOnGetCode     : TGetCodeEvent;    {called to retrieve release code}
    FOnGetKey      : TGetKeyEvent;     {called to retrieve key}
    FOnGetModifier : TGetModifierEvent;{called to retrieve key modifier}

    {property methods}
    function GetCode : string;
    function GetModifier : string;
    function GetAbout : string;                                      {!!.08}
    procedure SetCode(const Value : string);
    procedure SetModifier(const Value : string);
    procedure SetAbout(const Value : string);                        {!!.08}

  protected
    procedure Loaded;
      override;

    procedure DoOnChecked(Value : TCodeStatus);
      dynamic;
    function DoOnGetCode : TCode;
      dynamic;
    procedure DoOnGetKey(var Key : TKey);
      dynamic;
    function DoOnGetModifier : Integer;
      dynamic;

    {protected properties}
    property Code : string
      read GetCode
      write SetCode;

    property StoreCode : Boolean
      read FStoreCode
      write FStoreCode;

  public
    constructor Create(AOwner : TComponent);
      override;

    function CheckCode(Report : Boolean) : TCodeStatus;
      virtual; abstract;
    function IsCodeValid : Boolean;
      {-return true if code is valid}

  published
    {properties}
    property AutoCheck : Boolean
      read FAutoCheck
      write FAutoCheck
      default DefAutoCheck;

    property Modifier : string
      read GetModifier
      write SetModifier
      stored FStoreModifier;

    property StoreModifier : Boolean
      read FStoreModifier
      write FStoreModifier
      default DefStoreModifier;

    property About : string                                          {!!.08}
      read GetAbout                                                  {!!.08}
      write SetAbout                                                 {!!.08}
      stored False;

    {events}
    property OnChecked : TCheckedCodeEvent
      read FOnChecked
      write FOnChecked;

    property OnGetKey : TGetKeyEvent
      read FOnGetKey
      write FOnGetKey;

    property OnGetCode : TGetCodeEvent
      read FOnGetCode
      write FOnGetCode;

    property OnGetModifier : TGetModifierEvent
      read FOnGetModifier
      write FOnGetModifier;
  end;

  TOgMakeCodes = class(TComponent)
  protected {private}
    {property variables}
    FCode        : TCode;
    FCodeType    : TCodeType;
    FKey         : TKey;
    FKeyFileName : string;
    FKeyType     : TKeyType;
    FShowHints   : Boolean;

    {property methods}
    function GetAbout : string;                                      {!!.08}
    procedure SetAbout(const Value : string);                        {!!.08}

  public
    constructor Create(AOwner : TComponent);
      override;
    function Execute : Boolean;
    procedure GetCode(var Value : TCode);                            {!!.08}
    procedure SetCode(Value : TCode);                                {!!.08}
    procedure GetKey(var Value : TKey);                              {!!.08}
    procedure SetKey(Value : TKey);                                  {!!.08}

    property KeyType : TKeyType
      read FKeyType
      write FKeyType;

  published

    {properties}
    property CodeType : TCodeType
      read FCodeType
      write FCodeType
      default DefCodeType;

     property KeyFileName : string
      read FKeyFileName
      write FKeyFileName;

    property ShowHints : Boolean
      read FShowHints
      write FShowHints
      default False;

    property About : string                                          {!!.08}
      read GetAbout                                                  {!!.08}
      write SetAbout                                                 {!!.08}
      stored False;
  end;

type
  TOgMakeKeys = class(TComponent)
  protected {private}
    {property variables}
    FKeyFileName : string;
    FKey         : TKey;
    FKeyType     : TKeyType;
    FShowHints   : Boolean;

    {property methods}
    function GetAbout : string;                                      {!!.08}
    procedure SetAbout(const Value : string);                        {!!.08}

  public
    constructor Create(AOwner : TComponent);
      override;
    function Execute : Boolean;

    procedure ApplyModifierToKey(Modifier : Integer; var Key; KeySize : Cardinal);
      {-signs the key with the modifier}
    function GenerateDateModifier(D : TDateTime) : Integer;
      {-returns a modifier based on the current date}
    function GenerateMachineModifier : Integer;
      {-returns a modifier based on hardware information}
    procedure GenerateMDKey(var Key; KeySize : Cardinal; const Str : string);
      {-generate a key based on the message digest of Str}
    procedure GenerateRandomKey(var Key; KeySize : Cardinal);
      {-generate a random key}
    function GenerateStringModifier(const S : string) : Integer;
      {-returns a modifier based on S}
    function GenerateUniqueModifier : Integer;
      {-returns a unique/random modifier}
    procedure SetKey(Value : TKey);                                  {!!.08}
    procedure GetKey(var Value : TKey);                              {!!.08}

  published

    {properties}
    property About : string                                          {!!.08}
      read GetAbout                                                  {!!.08}
      write SetAbout                                                 {!!.08}
      stored False;

    property KeyFileName : string
      read FKeyFileName
      write FKeyFileName;

    property KeyType : TKeyType
      read FKeyType
      write FKeyType
      default DefKeyType;

    property ShowHints : Boolean
      read FShowHints
      write FShowHints
      default False;
  end;

  TOgDateCode = class(TOgCodeBase)
  public
    function CheckCode(Report : Boolean) : TCodeStatus;
      override;
    function GetValue : TDateTime;
      {-return expiration date (0 for error)}

  published
    {properties}
    property Code
      stored FStoreCode;

    property StoreCode
      default DefStoreCode;
  end;

  TOgDaysCode = class(TOgCodeBase)
  protected {private}
    {property variables}
    FAutoDecrease : Boolean;

    {event variables}
    FOnChangeCode : TChangeCodeEvent;

  protected
    procedure Loaded;
      override;

    procedure DoOnChangeCode(Value : TCode);
      dynamic;

  public
    constructor Create(AOwner : TComponent);
      override;
    function CheckCode(Report : Boolean) : TCodeStatus;
      override;
    procedure Decrease;
      {-reduce days and generate modified code}
    function GetValue : Integer;
      {-return number of days remaining}

  published
    {properties}
    property AutoDecrease : Boolean
      read FAutoDecrease
      write FAutoDecrease
      default DefAutoDecrease;

    {events}
    property OnChangeCode : TChangeCodeEvent
      read FOnChangeCode
      write FOnChangeCode;
  end;

  TOgRegistrationCode = class(TOgCodeBase)
  protected {private}
    {property variables}
    FRegString      : string;
    FStoreRegString : Boolean;

    {event variables}
    FOnGetRegString : TGetRegStringEvent;

  protected
    function DoOnGetRegString : string;
      dynamic;

  public
    constructor Create(AOwner : TComponent);
      override;

    function CheckCode(Report : Boolean) : TCodeStatus;
      override;

  published
    {properties}
    property Code
      stored FStoreCode;

    property StoreCode
      default DefStoreCode;

    property RegString : string
      read FRegString
      write FRegString
      stored FStoreRegString;

    property StoreRegString : Boolean
      read FStoreRegString
      write FStoreRegString
      default DefStoreRegString;

    {events}
    property OnGetRegString : TGetRegStringEvent
      read FOnGetRegString
      write FOnGetRegString;
  end;

  TOgSerialNumberCode = class(TOgCodeBase)
  public
    function CheckCode(Report : Boolean) : TCodeStatus;
      override;
    function GetValue : Integer;
      {-return serial number (0 for error)}

  published
    {properties}
    property Code
      stored FStoreCode;

    property StoreCode
      default DefStoreCode;

  end;

  TOgSpecialCode = class(TOgCodeBase)
    function CheckCode(Report : Boolean) : TCodeStatus;
      override;
    function GetValue : Integer;
      {-return serial number (0 for error)}

  published
    {properties}
    property Code
      stored FStoreCode;

    property StoreCode
      default DefStoreCode;
  end;

  TOgUsageCode = class(TOgCodeBase)
  protected {private}
    {property variables}
    FAutoDecrease : Boolean;

    {event variables}
    FOnChangeCode : TChangeCodeEvent;

  protected
    procedure Loaded;
      override;

    procedure DoOnChangeCode(Value : TCode);
      dynamic;

  public
    constructor Create(AOwner : TComponent);
      override;
    function CheckCode(Report : Boolean) : TCodeStatus;
      override;
    procedure Decrease;
      {-reduce number of uses and generate code}
    function GetValue : Integer;
      {-return number of uses remaining}

  published
    {properties}
    property AutoDecrease : Boolean
      read FAutoDecrease
      write FAutoDecrease
      default DefAutoDecrease;

    {events}
    property OnChangeCode : TChangeCodeEvent
      read FOnChangeCode
      write FOnChangeCode;
  end;

{$ENDREGION}


implementation

uses
  Winapi.ActiveX
  {$IFNDEF NoMakeCodesSupport}, Vcl.onguard2{$ENDIF}
  {$IFNDEF NoMakeKeysSupport}, Vcl.onguard3{$ENDIF}
  ;

resourcestring
  SCNoOnCheck = '%s has no OnChecked event handler assigned';
  SCNoOnGetCode = '%s has no OnGetCode event handler assigned';
  SCNoOnGetKey = '%s has no OnGetKey event handler assigned';
  SCNoOnChangeCode = '%s has no OnChangeCode event handler assigned';

{$REGION '*** TOgCodeBase ***'}
{*** TOgCodeBase ***}

constructor TOgCodeBase.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FAutoCheck := DefAutoCheck;
  FStoreCode := DefStoreCode;
  FStoreModifier := DefStoreModifier;

end;

procedure TOgCodeBase.DoOnChecked(Value : TCodeStatus);
begin
  if Assigned(FOnChecked) then
    FOnChecked(Self, Value)
  else if FAutoCheck then
    raise EOnGuardException.CreateFmt(SCNoOnCheck, [Self.ClassName]);
end;

function TOgCodeBase.DoOnGetCode : TCode;
begin
  FillChar(Result, SizeOf(Result), 0);
  if FStoreCode then
    Result := FCode
  else begin
    if Assigned(FOnGetCode) then
      FOnGetCode(Self, Result)
    else
      raise EOnGuardException.CreateFmt(SCNoOnGetCode, [Self.ClassName]);
  end;

  {store code for easy access using the Code property}                 {!!.02}
  FCode := Result;                                                     {!!.02}
end;

procedure TOgCodeBase.DoOnGetKey(var Key : TKey);
begin
  FillChar(Key, SizeOf(TKey), 0);
  if Assigned(FOnGetKey) then
    FOnGetKey(Self, Key)
  else
    raise EOnGuardException.CreateFmt(SCNoOnGetKey, [Self.ClassName]);
end;

{!!.02} {revised}
function TOgCodeBase.DoOnGetModifier : Integer;
var
  L : Integer;
begin
  Result := 0;
  if FStoreModifier then
    Result := FModifier
  else if Assigned(FOnGetModifier) then begin
    FOnGetModifier(Self, L);
    if FStoreModifier then begin
      {byte and word swap the modifier}
      TIntegerRec(Result).HiHi := TIntegerRec(L).LoLo;
      TIntegerRec(Result).HiLo := TIntegerRec(L).LoHi;
      TIntegerRec(Result).LoHi := TIntegerRec(L).HiLo;
      TIntegerRec(Result).LoLo := TIntegerRec(L).HiHi;
    end else
      Result := L;
  end;

  {store modifier for easy access using the Modifier property}         {!!.02}
  FModifier := Result;                                                 {!!.02}
end;

function TOgCodeBase.GetCode : string;
var
  Work : TCode;
begin
  Result := '$' + BufferToHex(FCode, SizeOf(FCode));
  if not HexToBuffer(Result, Work, SizeOf(Work)) then
    Result := '';

  if HexStringIsZero(Result) then
    Result := '';
end;

function TOgCodeBase.GetModifier : string;
var
  Work : Integer;
begin
  Result := '$' + BufferToHex(FModifier, SizeOf(FModifier));
  if not HexToBuffer(Result, Work, SizeOf(Work)) then
    Result := '';

  if HexStringIsZero(Result) then
    Result := '';
end;

function TOgCodeBase.GetAbout : string;                              {!!.08}
begin
  Result := OgVersionStr;
end;

function TOgCodeBase.IsCodeValid : Boolean;
begin
  Result := (CheckCode(False) = ogValidCode);
end;

procedure TOgCodeBase.Loaded;
begin
  inherited Loaded;

  if FAutoCheck and not (csDesigning in ComponentState) then
    CheckCode(True);
end;

procedure TOgCodeBase.SetCode(const Value : string);
begin
  if not HexToBuffer(Value, FCode, SizeOf(FCode)) then
    FillChar(FCode, SizeOf(FCode), 0);
end;

procedure TOgCodeBase.SetModifier(const Value : string);
begin
  if not HexToBuffer(Value, FModifier, SizeOf(FModifier)) then
    FModifier := 0;
end;

procedure TOgCodeBase.SetAbout(const Value : string);                {!!.08}
begin
end;

{$ENDREGION}

{$REGION '*** TOgDateCode ***'}
{*** TOgDateCode ***}

function TOgDateCode.CheckCode(Report : Boolean) : TCodeStatus;
var
  Code     : TCode;
  Key      : TKey;
  Modifier : Integer;
begin
  Result := ogValidCode;

  DoOnGetKey(Key);
  Code := DoOnGetCode;
  Modifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  if IsDateCodeValid(Key, Code) then begin
    if IsDateCodeExpired(Key, Code) then
      Result := ogPastEndDate;
  end else
    Result := ogInvalidCode;

  if Report then
    DoOnChecked(Result);
end;

function TOgDateCode.GetValue : TDateTime;
var
  Code     : TCode;
  Key      : TKey;
  Modifier : Integer;
begin
  DoOnGetKey(Key);
  Code := DoOnGetCode;
  Modifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  Result := GetDateCodeValue(Key, Code);
end;
{$ENDREGION}

{$REGION '*** TOgDaysCode ***'}
{*** TOgDaysCode ***}

function TOgDaysCode.CheckCode(Report : Boolean) : TCodeStatus;
var
  Code     : TCode;
  Key      : TKey;
  Modifier : Integer;
begin
  Result := ogValidCode;

  DoOnGetKey(Key);
  Code := DoOnGetCode;
  Modifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  if IsDaysCodeValid(Key, Code) then begin
    if IsDaysCodeExpired(Key, Code) then begin
      Result := ogDayCountUsed;
      if GetExpirationDate(Key, Code) < Date then
        Result := ogCodeExpired;
    end;
  end else
    Result := ogInvalidCode;

  if Report then
    DoOnChecked(Result);
end;

constructor TOgDaysCode.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FAutoDecrease := DefAutoDecrease;
end;

procedure TOgDaysCode.Decrease;
var
  Code     : TCode;
  Work     : TCode;
  Key      : TKey;
  Modifier : Integer;
begin
  DoOnGetKey(Key);
  Code := DoOnGetCode;
  Work := Code;
  Modifier := DoOnGetModifier;
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));

  {code is only decreased once per day - no matter how many times called}
  DecDaysCode(Key, Work);

  {save code if it was changed}
  if (Work.CheckValue <> Code.CheckValue) or (Work.Days <> Code.Days) then
    DoOnChangeCode(Work);
end;

procedure TOgDaysCode.DoOnChangeCode(Value : TCode);
begin
  if Assigned(FOnChangeCode) then
    FOnChangeCode(Self, Value)
  else
    raise EOnGuardException.CreateFmt(SCNoOnChangeCode, [Self.ClassName]);
end;

function TOgDaysCode.GetValue : Integer;
var
  Code     : TCode;
  Key      : TKey;
  Modifier : Integer;
begin
  DoOnGetKey(Key);
  Code := DoOnGetCode;
  Modifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  Result := GetDaysCodeValue(Key, Code);
end;

procedure TOgDaysCode.Loaded;
begin
  inherited Loaded;

  if FAutoDecrease and not (csDesigning in ComponentState) then
    Decrease;
end;
{$ENDREGION}

{$REGION '*** TOgMakeCodes ***'}
{*** TOgMakeCodes ***}

constructor TOgMakeCodes.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FCodeType := DefCodeType;
  FShowHints := False;
end;

function TOgMakeCodes.Execute : Boolean;
{$IFNDEF NoMakeCodesSupport}                                         {!!.10}
var
  F : TCodeGenerateFrm;
{$ENDIF}                                                             {!!.10}
begin
{$IFNDEF NoMakeCodesSupport}                                         {!!.10}
  F := TCodeGenerateFrm.Create(Owner);
  try
    F.CodeType := FCodeType;
    F.SetKey(FKey);                                                  {!!.08}
    F.KeyType := FKeyType;
    F.KeyFileName := FKeyFileName;
    F.ShowHint := FShowHints;
    Result := F.ShowModal = mrOK;// was mrOK but that pulls in a GUI framework
    if Result then begin
      FCode := F.Code;
      F.GetKey(FKey);                                                {!!.08}
      FKeyType := F.KeyType;
      FKeyFileName := F.KeyFileName;
    end;
  finally
    F.Free;
  end;
{$ELSE}                                                              {!!.10}
  Result := False;                                                   {!!.10}
{$ENDIF}                                                             {!!.10}
end;

function TOgMakeCodes.GetAbout : string;                             {!!.08}
begin
  Result := OgVersionStr;
end;

procedure TOgMakeCodes.SetAbout(const Value : string);               {!!.08}
begin
end;

procedure TOgMakeCodes.GetCode(var Value : TCode);                   {!!.08}
begin
  Value := FCode;
end;

procedure TOgMakeCodes.SetCode(Value : TCode);                       {!!.08}
begin
  FCode := Value;
end;

procedure TOgMakeCodes.GetKey(var Value : TKey);                     {!!.08}
begin
  Value := FKey;
end;

procedure TOgMakeCodes.SetKey(Value : TKey);                         {!!.08}
begin
  FKey := Value;
end;
{$ENDREGION}

{$REGION '*** TOgMakeKeys ***'}
{*** TOgMakeKeys ***}

constructor TOgMakeKeys.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FKeyType := DefKeyType;
  FShowHints := False;
end;

function TOgMakeKeys.Execute : Boolean;
{$IFNDEF NoMakeCodesSupport}                                         {!!.10}
var
  F : TKeyMaintFrm;
{$ENDIF}                                                             {!!.10}
begin
{$IFNDEF NoMakeCodesSupport}                                         {!!.10}
  F := TKeyMaintFrm.Create(Owner);
  try
    F.SetKey(FKey);                                                  {!!.08}
    F.KeyType := FKeyType;
    F.KeyFileName := FKeyFileName;
    F.ShowHint := FShowHints;
    Result := F.ShowModal = mrOK;// was mrOK but that pulls in a GUI framework
    if Result then begin
      F.GetKey(FKey);                                                {!!.08}
      FKeyType := F.KeyType;
      FKeyFileName := F.KeyFileName;
    end;
  finally
    F.Free;
  end;
{$ELSE}                                                              {!!.10}
  Result := False;                                                   {!!.10}
{$ENDIF}                                                             {!!.10}
end;

procedure TOgMakeKeys.ApplyModifierToKey(Modifier : Integer; var Key; KeySize : Cardinal);
begin
  ApplyModifierToKeyPrim(Modifier, Key, KeySize);
end;

function TOgMakeKeys.GenerateDateModifier(D : TDateTime) : Integer;
begin
  Result := GenerateDateModifierPrim(D);
end;

function TOgMakeKeys.GenerateMachineModifier : Integer;
begin
  Result := GenerateMachineModifierPrim;
end;

procedure TOgMakeKeys.GenerateMDKey(var Key; KeySize : Cardinal; const Str : string);
begin
  GenerateTMDKeyPrim(Key, KeySize, Str);
end;

procedure TOgMakeKeys.GenerateRandomKey(var Key; KeySize : Cardinal);
begin
  GenerateRandomKeyPrim(Key, KeySize);
end;

function TOgMakeKeys.GenerateUniqueModifier : Integer;
begin
  Result := GenerateUniqueModifierPrim;
end;

function TOgMakeKeys.GenerateStringModifier(const S : string) : Integer;
begin
  Result := GenerateStringModifierPrim(S);
end;

function TOgMakeKeys.GetAbout : string;                              {!!.08}
begin
  Result := OgVersionStr;
end;

procedure TOgMakeKeys.SetAbout(const Value : string);                {!!.08}
begin
end;

procedure TOgMakeKeys.GetKey(var Value : TKey);                      {!!.08}
begin
  Value := FKey;
end;

procedure TOgMakeKeys.SetKey(Value : TKey);                          {!!.08}
begin
  FKey := Value;
end;
{$ENDREGION}

{$REGION '*** TOgRegistrationCode ***'}
{*** TOgRegistrationCode ***}

function TOgRegistrationCode.CheckCode(Report : Boolean) : TCodeStatus;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
  {RegStr   : string;}                                                 {!!.02}
begin
  Result := ogValidCode;

  FRegString := DoOnGetRegString;                                      {!!.02}
  DoOnGetKey(Key);
  ACode       := DoOnGetCode;
  AModifier   := DoOnGetModifier;

  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));
  if not IsRegCodeValid(Key, ACode) then
    Result := ogInvalidCode
  else if GetExpirationDate(Key, ACode) < Date then
    Result := ogCodeExpired;

  if Report then
    DoOnChecked(Result);
end;

constructor TOgRegistrationCode.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FRegString := '';
  FStoreRegString := DefStoreRegString;
end;

function TOgRegistrationCode.DoOnGetRegString : string;
begin
  Result := '';
  if FStoreRegString then
    Result := FRegString
  else if Assigned(FOnGetRegString) then
    FOnGetRegString(Self, Result)
end;
{$ENDREGION}

{$REGION '*** TOgSerialNumberCode ***'}
{*** TOgSerialNumberCode ***}

function TOgSerialNumberCode.CheckCode(Report : Boolean) : TCodeStatus;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  Result := ogValidCode;

  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  AModifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));
  if not IsSerialNumberCodeValid(Key, ACode) then
    Result := ogInvalidCode
  else if GetExpirationDate(Key, ACode) < Date then
    Result := ogCodeExpired;

  if Report then
    DoOnChecked(Result);
end;

function TOgSerialNumberCode.GetValue : Integer;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  AModifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));
  Result := GetSerialNumberCodeValue(Key, ACode);
end;
{$ENDREGION}

{$REGION '*** TOgSpecialCode ***'}
{*** TOgSpecialCode ***}

function TOgSpecialCode.CheckCode(Report : Boolean) : TCodeStatus;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  Result := ogValidCode;

  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  AModifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));
  if not IsSpecialCodeValid(Key, ACode) then
    Result := ogInvalidCode
  else if GetExpirationDate(Key, ACode) < Date then
    Result := ogCodeExpired;

  if Report then
    DoOnChecked(Result);
end;

function TOgSpecialCode.GetValue : Integer;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  AModifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));
  Result := GetSpecialCodeValue(Key, ACode);
end;
{$ENDREGION}

{$REGION '*** TOgUsageCode ***'}
{*** TOgUsageCode ***}

function TOgUsageCode.CheckCode(Report : Boolean) : TCodeStatus;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  Result := ogValidCode;

  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  AModifier := DoOnGetModifier;
  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));

  if IsUsageCodeValid(Key, ACode) then begin
    if IsUsageCodeExpired(Key, ACode) then begin
      Result := ogRunCountUsed;
      if GetExpirationDate(Key, ACode) < Date then
        Result := ogCodeExpired;
    end;
  end else
    Result := ogInvalidCode;

  if Report then
    DoOnChecked(Result);
end;

constructor TOgUsageCode.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FAutoDecrease := DefAutoDecrease;
end;

procedure TOgUsageCode.Decrease;
var
  ACode     : TCode;
  Work     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  Work := ACode;
  AModifier := DoOnGetModifier;
  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));

  {code is decreased each time this routine is called}
  DecUsageCode(Key, Work);
  {save the changed code}
  DoOnChangeCode(Work);
end;

procedure TOgUsageCode.DoOnChangeCode(Value : TCode);
begin
  if Assigned(FOnChangeCode) then
    FOnChangeCode(Self, Value)
  else
    raise EOnGuardException.CreateFmt(SCNoOnChangeCode, [Self.ClassName]);
end;

function TOgUsageCode.GetValue : Integer;
var
  ACode     : TCode;
  Key      : TKey;
  AModifier : Integer;
begin
  DoOnGetKey(Key);
  ACode := DoOnGetCode;
  AModifier := DoOnGetModifier;

  ApplyModifierToKeyPrim(AModifier, Key, SizeOf(Key));
  Result := GetUsageCodeValue(Key, ACode);
end;

procedure TOgUsageCode.Loaded;
begin
  inherited Loaded;

  // added (not FAutoCheck) to fix ticket #6
  if FAutoDecrease and (not FAutoCheck) and (not (csDesigning in ComponentState)) then
    Decrease;
end;
{$ENDREGION}

end.



