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
{*                   OGUTIL.PAS 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogutil;
  {-general constants, types, and utility routines}

interface

uses
  {$IFDEF Win16} WinTypes, WinProcs, OLE2, {$ENDIF}
  {$IFDEF Win32} Windows, {$ENDIF}
  {$IFDEF KYLIX} Libc, {$ENDIF}
  {$IFDEF FPC}{$IFDEF UNIX} BaseUnix, {$ENDIF}{$ENDIF}
  {$IFDEF UsingCLX} Types, {$IFNDEF CONSOLE} QDialogs, {$ENDIF} {$ENDIF}
  {$IFDEF DELPHI15UP} System.AnsiStrings, {$ENDIF}
  SysUtils,
  {$IFDEF DELPHI19UP}
    {$IFDEF POSIX}Posix.Base, Posix.SysSocket, Posix.NetIf, Posix.NetinetIn, Posix.ArpaInet, ogposix,{$ENDIF}
    {$IFDEF IOS}iOSApi.UIKit,{$ENDIF}
    {$IFDEF ANDROID}androidapi.JNI.JavaTypes, androidapi.JNI.Os,{$ENDIF}
  {$ENDIF}
  ogconst {$IFNDEF NoOgSrMgr},  ogsrmgr {$ENDIF} {$IFDEF UseOgJcl}, ogjcl{$ENDIF} ;

const
  DefAutoCheck      = True;
  DefAutoDecrease   = True;
  DefCheckSize      = True;
  DefStoreCode      = False;
  DefStoreModifier  = False;
  DefStoreRegString = False;

const
  OgVersionStr      = '1.15';



const
  {largest structure that can be created}
  {$IFDEF Win32}
  MaxStructSize = 1024 * 2000000; {2G}
  {$ELSE}
  MaxStructSize = 1024 * 64 - 1;  {64K}
  {$ENDIF}

type
  {$IFDEF Win16}
  DWord      = LongInt;
  PDWord     = ^DWord;
  TGUID      = GUID;   {Delphi 1.0 defines it as GUID - Delphi 2.0 defines it as TGUID}
  AnsiChar   = Char;
  PAnsiChar  = PChar;
  {$ENDIF}

  {$IFDEF MACOS}
  DWord      = Cardinal;
  PDWord     = ^DWord;
  {$ENDIF}

  {$IFNDEF FPC}
  PByte         = ^Byte;
  PByteArray    = ^TByteArray;
  TByteArray    = array [0..MaxStructSize div SizeOf(Byte) - 1] of Byte;
  PLongInt      = ^LongInt;
  {$ENDIF}
  PLongIntArray = ^TLongIntArray;
  TLongIntArray = array [0..MaxStructSize div SizeOf(LongInt) - 1] of LongInt;

  TLongIntRec = record
    case Byte of
      1: (Lo: Word;
          Hi: Word);
      2: (LoLo: Byte;
          LoHi: Byte;
          HiLo: Byte;
          HiHi: Byte);
  end;

{$REGION 'moved from onguard.pas'}
// moved from onguard.pas
const
  {magic values}
  DaysCheckCode    = Word($649B);
  DateCheckCode    = Word($A4CB);
  NetCheckCode     = Word($9341);
  RegCheckCode     = Word($D9F6);
  SerialCheckCode  = Word($3C69);
  UsageCheckCode   = Word($F3D5);
  SpecialCheckCode = Word($9C5B);

type
  {code tyes}
  PCode = ^TCode;
  TCode = packed record
    CheckValue : Word;               {magic value}
    Expiration : Word;               {expiration date or 0, if none}
    case Byte of
      0 : (FirstDate    : Word;      {for date code}
           EndDate      : Word);
      1 : (Days         : Word;      {for days code}
           LastAccess   : Word);
      2 : (RegString    : LongInt);  {for reg code}
      3 : (SerialNumber : LongInt);  {for serial number code}
      4 : (UsageCount   : Word;      {for usage count code}            {!!.02}
           LastChange   : Word);                                       {!!.02}
      5 : (Value        : LongInt);  {for specail codes}
      6 : (NetIndex     : LongInt);  {for net codes}
  end;

type
  TCodeType = (ctDate, ctDays, ctRegistration, ctSerialNumber,
               ctUsage, ctNetwork, ctSpecial, ctUnknown);
  {order must match tab order for code generation notebook}

type
  TKey     = array [0..15] of Byte;
  TKeyType = (ktRandom, ktMessageDigest, ktMessageDigestCS);
  {order must match order for key generation combobox string list}

type
  {contexts}
  TTMDContext = array [0..279] of Byte;
  TMD5Context = array [0..87] of Byte;
  TMD5Digest  = array [0..15] of Byte;

  {bit mixing types}
  T128Bit     = array [0..3] of LongInt;
  T256Bit     = array [0..7] of LongInt;

const
  DefCodeType      = ctDate;
  DefKeyType       = ktRandom;

type
  TEsMachineInfoSet =                                                  {!!.05}
    set of (midUser, midSystem, midNetwork, midDrives,                 {!!.05}
            midCPUID, midCPUIDJCL, midBIOS, midWinProd, midCryptoID, midNetMAC, midDomain);  {!!.15}

type
  {result of code verification}
  TCodeStatus = (ogValidCode,    {code is valid but may still be expired}
                 ogInvalidCode,  {code is invalid}
                 ogPastEndDate,  {end date has been reached}
                 ogDayCountUsed, {number of days authorized have been used}
                 ogRunCountUsed, {number of runs authorized have been used}
                 ogNetCountUsed, {number of authorized users has been exceeded}
                 ogCodeExpired); {expiration date has been reached}

type
  EOnGuardException = class(Exception);
  EOnGuardBadDateException = class(EOnGuardException);                 {!!.15}
  EOnGuardClockIssueException = class(EOnGuardException);              {!!.15}


function GetCodeType(const Key : TKey; const Code : TCode) : TCodeType;
  {-return the type of code}
function GetExpirationDate(const Key : TKey; const Code : TCode) : TDateTime;
  {-return the date this code expires}

procedure InitDateCode(const Key : TKey; StartDate, EndDate : TDateTime; var Code : TCode);
function IsDateCodeValid(const Key : TKey; const Code : TCode) : Boolean;
function GetDateCodeValue(const Key : TKey; const Code : TCode) : TDateTime;
function IsDateCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
procedure InitDateCodeEx(const Key : TKey; StartDate, EndDate, Expires : TDateTime; var Code : TCode);
function GetDateCodeStart(const Key : TKey; const Code : TCode) : TDateTime;
function GetDateCodeEnd(const Key : TKey; const Code : TCode) : TDateTime;

procedure InitDaysCode(const Key : TKey; Days : Word; Expires : TDateTime; var Code : TCode);
function IsDaysCodeValid(const Key : TKey; const Code : TCode) : Boolean;
procedure DecDaysCode(const Key : TKey; var Code : TCode);
function GetDaysCodeValue(const Key : TKey; const Code : TCode) : LongInt;
function IsDaysCodeExpired(const Key : TKey; const Code : TCode) : Boolean;

procedure InitRegCode(const Key : TKey; const RegStr : AnsiString; Expires : TDateTime; var Code : TCode);
function IsRegCodeValid(const Key : TKey; const Code : TCode) : Boolean;
function IsRegCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
function IsRegCodeRegisteredTo(const Key : TKey; const Code : TCode; const RegStr: AnsiString) : Boolean;

procedure InitSerialNumberCode(const Key : TKey;  Serial : LongInt; Expires : TDateTime; var Code : TCode);
function IsSerialNumberCodeValid(const Key : TKey; const Code : TCode) : Boolean;
function GetSerialNumberCodeValue(const Key : TKey; const Code : TCode) : LongInt;
function IsSerialNumberCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
function IsSerialNumberCodeValidFor(const Key : TKey; const Code : TCode; const Serial: LongInt) : Boolean;

procedure InitSpecialCode(const Key : TKey; Value : LongInt; Expires : TDateTime; var Code : TCode);
function IsSpecialCodeValid(const Key : TKey; const Code : TCode) : Boolean;
function GetSpecialCodeValue(const Key : TKey; const Code : TCode) : LongInt;
function IsSpecialCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
function IsSpecialCodeValidFor(const Key : TKey; const Code : TCode; const Value: LongInt) : Boolean;

procedure InitUsageCode(const Key : TKey; Count : Word; Expires : TDateTime; var Code : TCode);
function IsUsageCodeValid(const Key : TKey; const Code : TCode) : Boolean;
procedure DecUsageCode(const Key : TKey; var Code : TCode);
function GetUsageCodeValue(const Key : TKey; const Code : TCode) : LongInt;
function IsUsageCodeExpired(const Key : TKey; const Code: TCode) : Boolean;
{$IFDEF OgUsageUnlimited}
procedure InitUsageCodeUnlimited(const Key : TKey; var Code : TCode);
{$ENDIF}

{generate key routines}
procedure GenerateRandomKeyPrim(var Key; KeySize : Cardinal);
procedure GenerateTMDKeyPrim(var Key; KeySize : Cardinal; const Str : AnsiString);
procedure GenerateMD5KeyPrim(var Key: TKey; const Str : AnsiString);

{modifier routines}
function CreateMachineID(MachineInfo : TEsMachineInfoSet; Ansi: Boolean = True) : LongInt;   {!!.05}
function GenerateStringModifierPrim(const S : AnsiString) : LongInt;
function GenerateUniqueModifierPrim : LongInt;
function GenerateMachineModifierPrim : LongInt;
function GenerateDateModifierPrim(D : TDateTime) : LongInt;
procedure ApplyModifierToKeyPrim(Modifier : LongInt; var Key; KeySize : Cardinal);

{hash routines}
function StringHashElf(const Str : AnsiString) : LongInt;

{mixing routines}
procedure MixBlock(const Matrix : T128Bit; var Block; Encrypt : Boolean);

{utility routines}
function ExpandDate(D : Word) : TDateTime;
function ShrinkDate(D : TDateTime) : Word;

const
  BaseDate : LongInt = 35065;  //35065 = 1996-Jan-1


{$ENDREGION}


function BufferToHex(const Buf; BufSize : Cardinal) : string;
function BufferToHexBytes(const Buf; BufSize : Cardinal) : string;
{$IFDEF Win16}
function GetDiskSerialNumber(Drive : AnsiChar) : LongInt;
{$ENDIF}
{$IFDEF LINUX}
function GetDiskSerialNumber(Drive : AnsiChar) : LongInt;
function MyHashElf(const Buf;  BufSize : LongInt) : LongInt;
{$ENDIF}
function HexStringIsZero(const Hex : string) : Boolean;
function HexToBuffer(const Hex : string; var Buf; BufSize : Cardinal) : Boolean;
function Max(A, B : LongInt): LongInt;
function Min(A, B : LongInt) : LongInt;
procedure XorMem(var Mem1; const Mem2; Count : Cardinal);
function OgFormatDate(Value : TDateTime) : string;                     {!!.09}


{$IFDEF KYLIX}
function GetDriveType(drive:Integer): Integer;
function HiWord(I: DWORD):Word;
function CoCreateGuid(out guid: TGUID): HResult;
function timeGetTime: DWord;
{$ENDIF}
{$IFDEF FPC}
{$IFDEF LINUX}
function GetDriveType(drive:Integer): Integer;
function HiWord(I: DWORD):Word;
function CoCreateGuid(out guid: TGUID): HResult;
function timeGetTime: Cardinal;
{$ENDIF}
{$IFDEF FREEBSD}
function GetDriveType(drive:Integer): Integer;
function HiWord(I: DWORD):Word;
function CoCreateGuid(out guid: TGUID): HResult;
function timeGetTime: Cardinal;
{$ENDIF}
{$ENDIF}

{$IFNDEF NoOgSrMgr}
var
  StrRes : TOgStringResource;                                           {!!.08}
{$ENDIF}

implementation

{$IFDEF MSWINDOWS}
uses
  {$IFDEF DELPHI}{$IFDEF DELPHI3UP} ActiveX; {$ELSE} OLE2; {$ENDIF}{$ENDIF}
{$ENDIF}

{first 2048 bits of Pi in hexadecimal, low to high, without the leading "3"}
const
  Pi2048: array [0..255] of Byte = (
    $24, $3F, $6A, $88, $85, $A3, $08, $D3, $13, $19, $8A, $2E, $03, $70, $73, $44,
    $A4, $09, $38, $22, $29, $9F, $31, $D0, $08, $2E, $FA, $98, $EC, $4E, $6C, $89,
    $45, $28, $21, $E6, $38, $D0, $13, $77, $BE, $54, $66, $CF, $34, $E9, $0C, $6C,
    $C0, $AC, $29, $B7, $C9, $7C, $50, $DD, $3F, $84, $D5, $B5, $B5, $47, $09, $17,
    $92, $16, $D5, $D9, $89, $79, $FB, $1B, $D1, $31, $0B, $A6, $98, $DF, $B5, $AC,
    $2F, $FD, $72, $DB, $D0, $1A, $DF, $B7, $B8, $E1, $AF, $ED, $6A, $26, $7E, $96,
    $BA, $7C, $90, $45, $F1, $2C, $7F, $99, $24, $A1, $99, $47, $B3, $91, $6C, $F7,
    $08, $01, $F2, $E2, $85, $8E, $FC, $16, $63, $69, $20, $D8, $71, $57, $4E, $69,
    $A4, $58, $FE, $A3, $F4, $93, $3D, $7E, $0D, $95, $74, $8F, $72, $8E, $B6, $58,
    $71, $8B, $CD, $58, $82, $15, $4A, $EE, $7B, $54, $A4, $1D, $C2, $5A, $59, $B5,
    $9C, $30, $D5, $39, $2A, $F2, $60, $13, $C5, $D1, $B0, $23, $28, $60, $85, $F0,
    $CA, $41, $79, $18, $B8, $DB, $38, $EF, $8E, $79, $DC, $B0, $60, $3A, $18, $0E,
    $6C, $9E, $0E, $8B, $B0, $1E, $8A, $3E, $D7, $15, $77, $C1, $BD, $31, $4B, $27,
    $78, $AF, $2F, $DA, $55, $60, $5C, $60, $E6, $55, $25, $F3, $AA, $55, $AB, $94,
    $57, $48, $98, $62, $63, $E8, $14, $40, $55, $CA, $39, $6A, $2A, $AB, $10, $B6,
    $B4, $CC, $5C, $34, $11, $41, $E8, $CE, $A1, $54, $86, $AF, $7C, $72, $E9, $93);


{mixing routines}
procedure Mix128(var X : T128Bit);
var
  AA, BB, CC, DD : LongInt;
begin
  AA := X[0];  BB := X[1];  CC := X[2];  DD := X[3];

  AA := AA + DD;  DD := DD + AA;  AA := AA xor (AA shr 7);
  BB := BB + AA;  AA := AA + BB;  BB := BB xor (BB shl 13);
  CC := CC + BB;  BB := BB + CC;  CC := CC xor (CC shr 17);
  DD := DD + CC;  CC := CC + DD;  DD := DD xor (DD shl 9);
  AA := AA + DD;  DD := DD + AA;  AA := AA xor (AA shr 3);
  BB := BB + AA;  AA := AA + BB;  BB := BB xor (BB shl 7);
  CC := CC + BB;  BB := BB + CC;  CC := CC xor (DD shr 15);
  DD := DD + CC;  CC := CC + DD;  DD := DD xor (DD shl 11);

  X[0] := AA;  X[1] := BB;  X[2] := CC;  X[3] := DD;
end;

{quick (block) mixer routine}
procedure MixBlock(const Matrix : T128bit; var Block; Encrypt : Boolean);
const
  CKeyBox : array [False..True, 0..3, 0..2] of LongInt =
    (((0, 3, 1), (2, 1, 3), (1, 0, 2), (3, 2, 0)),
     ((3, 2, 0), (1, 0, 2), (2, 1, 3), (0, 3, 1)));
var
  Blocks  : array [0..1] of LongInt absolute Block;
  Work    : LongInt;
  Right   : LongInt;
  Left    : LongInt;
  R       : LongInt;
  AA, BB  : LongInt;
  CC, DD  : LongInt;
begin
  Right := Blocks[0];
  Left := Blocks[1];

  for R := 0 to 3 do begin
    {transform the right side}
    AA := Right;
    BB := Matrix[CKeyBox[Encrypt, R, 0]];
    CC := Matrix[CKeyBox[Encrypt, R, 1]];
    DD := Matrix[CKeyBox[Encrypt, R, 2]];

    {commented code does not affect results - removed for speed}
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 7);
    BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 13);
    CC := CC + BB; BB := BB + CC; CC := CC xor (CC shr 17);
    DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 9);
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 3);
    BB := BB + AA; {AA := AA + BB;}  BB := BB xor (BB shl 7);
    CC := CC + BB; {BB := BB + CC;}  CC := CC xor (DD shr 15);
    DD := DD + CC; {CC := CC + DD;}  DD := DD xor (DD shl 11);

    Work := Left xor DD;
    Left := Right;
    Right := Work;
  end;

  Blocks[0] := Left;
  Blocks[1] := Right;
end;

function HashElf(const Buf;  BufSize : LongInt) : LongInt;
var
  Bytes : TByteArray absolute Buf;
  I, X  : LongInt;
begin
  Result := 0;
  for I := 0 to BufSize - 1 do begin
    Result := (Result shl 4) + Bytes[I];
    X := Result and $F0000000;
    if (X <> 0) then
      Result := Result xor (X shr 24);
    Result := Result and (not X);
  end;
end;

function StringHashElf(const Str : AnsiString) : LongInt;
begin
  Result := HashElf(Str[1], Length(Str));
end;

{$REGION 'MD5 routines'}
{internal routines for MD5}
type
  TMD5ContextEx = record
    Count : array [0..1] of DWord;  {number of bits handled mod 2^64}
    State : array [0..3] of DWord;  {scratch buffer}
    Buf   : array [0..63] of Byte;    {input buffer}
  end;

{MD5 routines}


{$IFDEF OgPUREPASCAL_ROLX}
function RolX(I,C: DWord): DWord;
begin
  Result := (I shl C) or (I shr (32-C));
end;
{$ELSE}
{$IFDEF Win32}
function RolX(I, C : DWord) : DWord; register;                         {!!.07}
asm
  mov  ecx, edx         {get count to cl}
  rol  eax, cl          {rotate eax by cl}
end;
{$ENDIF}
{$IFDEF Win16}
function RolX(I, C : DWord) : DWord; assembler;                        {!!.07}
asm
  db $66
  mov  ax,word ptr I    {eax = I}
  db $66
  mov  cx,word ptr C    {ecx = C}
  db $66
  rol  ax, cl           {rotate eax by cl}
  db $66
  push ax               {push eax}
  {set result}
  pop  ax               {low word to ax}
  pop  dx               {high word to dx}
end;
{$ENDIF}
{$IFDEF KYLIX}
function RolX(I, C : DWord) : DWord; register;                         {!!.07}
asm
  mov  ecx, edx         {get count to cl}
  rol  eax, cl          {rotate eax by cl}
end;
{$ENDIF}
{$ENDIF OgPUREPASCAL_ROLX}

{!!.07}
procedure Transform(var Buffer : array of DWord;  const InBuf : array of DWord);
const
  S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;
  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;
  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;
  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;
var
  Buf : array [0..3] of DWord absolute Buffer;
  InA : array [0..15] of DWord absolute InBuf;
  A   : DWord;
  B   : DWord;
  C   : DWord;
  D   : DWord;

  procedure FF(var A : DWord;  B, C, D, X, S, AC : DWord);
  begin
    A := RolX(A + ((B and C) or (not B and D)) + X + AC, S) + B;
  end;

  procedure GG(var A : DWord;  B, C, D, X, S, AC : DWord);
  begin
    A := RolX(A + ((B and D) or (C and not D)) + X + AC, S) + B;
  end;

  procedure HH(var A : DWord;  B, C, D, X, S, AC : DWord);
  begin
    A := RolX(A + (B xor C xor D) + X + AC, S) + B;
  end;

  procedure II(var A : DWord;  B, C, D, X, S, AC : DWord);
  begin
    A := RolX(A + (C xor (B or not D)) + X + AC, S) + B;
  end;

begin
  A := Buf [0];
  B := Buf [1];
  C := Buf [2];
  D := Buf [3];

  {round 1}
  FF(A, B, C, D, InA [ 0], S11, $D76AA478);  { 1 }
  FF(D, A, B, C, InA [ 1], S12, $E8C7B756);  { 2 }
  FF(C, D, A, B, InA [ 2], S13, $242070DB);  { 3 }
  FF(B, C, D, A, InA [ 3], S14, $C1BDCEEE);  { 4 }
  FF(A, B, C, D, InA [ 4], S11, $F57C0FAF);  { 5 }
  FF(D, A, B, C, InA [ 5], S12, $4787C62A);  { 6 }
  FF(C, D, A, B, InA [ 6], S13, $A8304613);  { 7 }
  FF(B, C, D, A, InA [ 7], S14, $FD469501);  { 8 }
  FF(A, B, C, D, InA [ 8], S11, $698098D8);  { 9 }
  FF(D, A, B, C, InA [ 9], S12, $8B44F7AF);  { 10 }
  FF(C, D, A, B, InA [10], S13, $FFFF5BB1);  { 11 }
  FF(B, C, D, A, InA [11], S14, $895CD7BE);  { 12 }
  FF(A, B, C, D, InA [12], S11, $6B901122);  { 13 }
  FF(D, A, B, C, InA [13], S12, $FD987193);  { 14 }
  FF(C, D, A, B, InA [14], S13, $A679438E);  { 15 }
  FF(B, C, D, A, InA [15], S14, $49B40821);  { 16 }

  {round 2}
  GG(A, B, C, D, InA [ 1], S21, $F61E2562);  { 17 }
  GG(D, A, B, C, InA [ 6], S22, $C040B340);  { 18 }
  GG(C, D, A, B, InA [11], S23, $265E5A51);  { 19 }
  GG(B, C, D, A, InA [ 0], S24, $E9B6C7AA);  { 20 }
  GG(A, B, C, D, InA [ 5], S21, $D62F105D);  { 21 }
  GG(D, A, B, C, InA [10], S22, $02441453);  { 22 }
  GG(C, D, A, B, InA [15], S23, $D8A1E681);  { 23 }
  GG(B, C, D, A, InA [ 4], S24, $E7D3FBC8);  { 24 }
  GG(A, B, C, D, InA [ 9], S21, $21E1CDE6);  { 25 }
  GG(D, A, B, C, InA [14], S22, $C33707D6);  { 26 }
  GG(C, D, A, B, InA [ 3], S23, $F4D50D87);  { 27 }
  GG(B, C, D, A, InA [ 8], S24, $455A14ED);  { 28 }
  GG(A, B, C, D, InA [13], S21, $A9E3E905);  { 29 }
  GG(D, A, B, C, InA [ 2], S22, $FCEFA3F8);  { 30 }
  GG(C, D, A, B, InA [ 7], S23, $676F02D9);  { 31 }
  GG(B, C, D, A, InA [12], S24, $8D2A4C8A);  { 32 }

  {round 3}
  HH(A, B, C, D, InA [ 5], S31, $FFFA3942);  { 33 }
  HH(D, A, B, C, InA [ 8], S32, $8771F681);  { 34 }
  HH(C, D, A, B, InA [11], S33, $6D9D6122);  { 35 }
  HH(B, C, D, A, InA [14], S34, $FDE5380C);  { 36 }
  HH(A, B, C, D, InA [ 1], S31, $A4BEEA44);  { 37 }
  HH(D, A, B, C, InA [ 4], S32, $4BDECFA9);  { 38 }
  HH(C, D, A, B, InA [ 7], S33, $F6BB4B60);  { 39 }
  HH(B, C, D, A, InA [10], S34, $BEBFBC70);  { 40 }
  HH(A, B, C, D, InA [13], S31, $289B7EC6);  { 41 }
  HH(D, A, B, C, InA [ 0], S32, $EAA127FA);  { 42 }
  HH(C, D, A, B, InA [ 3], S33, $D4EF3085);  { 43 }
  HH(B, C, D, A, InA [ 6], S34,  $4881D05);  { 44 }
  HH(A, B, C, D, InA [ 9], S31, $D9D4D039);  { 45 }
  HH(D, A, B, C, InA [12], S32, $E6DB99E5);  { 46 }
  HH(C, D, A, B, InA [15], S33, $1FA27CF8);  { 47 }
  HH(B, C, D, A, InA [ 2], S34, $C4AC5665);  { 48 }

  {round 4}
  II(A, B, C, D, InA [ 0], S41, $F4292244);  { 49 }
  II(D, A, B, C, InA [ 7], S42, $432AFF97);  { 50 }
  II(C, D, A, B, InA [14], S43, $AB9423A7);  { 51 }
  II(B, C, D, A, InA [ 5], S44, $FC93A039);  { 52 }
  II(A, B, C, D, InA [12], S41, $655B59C3);  { 53 }
  II(D, A, B, C, InA [ 3], S42, $8F0CCC92);  { 54 }
  II(C, D, A, B, InA [10], S43, $FFEFF47D);  { 55 }
  II(B, C, D, A, InA [ 1], S44, $85845DD1);  { 56 }
  II(A, B, C, D, InA [ 8], S41, $6FA87E4F);  { 57 }
  II(D, A, B, C, InA [15], S42, $FE2CE6E0);  { 58 }
  II(C, D, A, B, InA [ 6], S43, $A3014314);  { 59 }
  II(B, C, D, A, InA [13], S44, $4E0811A1);  { 60 }
  II(A, B, C, D, InA [ 4], S41, $F7537E82);  { 61 }
  II(D, A, B, C, InA [11], S42, $BD3AF235);  { 62 }
  II(C, D, A, B, InA [ 2], S43, $2AD7D2BB);  { 63 }
  II(B, C, D, A, InA [ 9], S44, $EB86D391);  { 64 }

  Inc(Buf [0], A);
  Inc(Buf [1], B);
  Inc(Buf [2], C);
  Inc(Buf [3], D);
end;

procedure InitMD5(var Context : TMD5Context);
var
  MD5 : TMD5ContextEx absolute Context;
begin
  MD5.Count[0] := 0;
  MD5.Count[1] := 0;

  {load magic initialization constants}
  MD5.State[0] := $67452301;
  MD5.State[1] := $EFCDAB89;
  MD5.State[2] := $98BADCFE;
  MD5.State[3] := $10325476;
end;

procedure UpdateMD5(var Context : TMD5Context;  const Buf;  BufSize : LongInt);
var
  MD5    : TMD5ContextEx absolute Context;
  Bytes  : TByteArray absolute Buf;
  InBuf  : array [0..15] of DWord;                                     {!!.07}
  BufOfs : LongInt;
  MDI    : Word;
  I      : Word;
  II     : Word;
begin
  {compute number of bytes mod 64}
  MDI := (MD5.Count[0] shr 3) and $3F;

  {update number of bits}
  if ((MD5.Count[0] + (DWord(BufSize) shl 3)) < MD5.Count[0]) then
    Inc(MD5.Count[1]);
  Inc(MD5.Count[0], BufSize shl 3);
  Inc(MD5.Count[1], BufSize shr 29);

  {add new byte acters to buffer}
  BufOfs := 0;
  while (BufSize > 0) do begin
    Dec(BufSize);
    MD5.Buf[MDI] := Bytes[BufOfs];
    Inc(MDI);
    Inc(BufOfs);
    if (MDI = $40) then begin
      II := 0;
      for I := 0 to 15 do begin
        InBuf[I] := LongInt(MD5.Buf[II + 3]) shl 24 or
          LongInt(MD5.Buf[II + 2]) shl 16 or
          LongInt(MD5.Buf[II + 1]) shl 8 or
          LongInt(MD5.Buf[II]);
        Inc(II, 4);
      end;
      Transform(MD5.State, InBuf);
      MDI := 0;
    end;
  end;
end;

function FinalizeMD5(var Context : TMD5Context) : TMD5Digest;
const
  Padding: array [0..63] of Byte = (
    $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00);
var
  MD5    : TMD5ContextEx absolute Context;
  InBuf  : array [0..15] of DWord;                                     {!!.07}
  MDI    : LongInt;
  I      : Word;
  II     : Word;
  PadLen : Word;
begin
  {save number of bits}
  InBuf[14] := MD5.Count[0];
  InBuf[15] := MD5.Count[1];

  {compute number of bytes mod 64}
  MDI := (MD5.Count[0] shr 3) and $3F;

  {pad out to 56 mod 64}
  if (MDI < 56) then
    PadLen := 56 - MDI
  else
    PadLen := 120 - MDI;
  UpdateMD5(Context, Padding, PadLen);

  {append length in bits and transform}
  II := 0;
  for I := 0 to 13 do begin
    InBuf[I] := (LongInt(MD5.Buf[II + 3]) shl 24) or
      (LongInt(MD5.Buf[II + 2]) shl 16) or
      (LongInt(MD5.Buf[II + 1]) shl 8) or
      LongInt(MD5.Buf[II]);
    Inc(II, 4);
  end;
  Transform(MD5.State, InBuf);

  {store buffer in digest (Result)}
  II := 0;
  for I := 0 to 3 do begin
    Result[II] := Byte(MD5.State[I] and $FF);
    Result[II + 1] := Byte((MD5.State[I] shr 8) and $FF);
    Result[II + 2] := Byte((MD5.State[I] shr 16) and $FF);
    Result[II + 3] := Byte((MD5.State[I] shr 24) and $FF);

    Inc(II, 4);
  end;
end;

function HashMD5(const Buf;  BufSize : LongInt) : TMD5Digest;
var
  Context : TMD5Context;
begin
  InitMD5(Context);
  UpdateMD5(Context, Buf, BufSize);
  Result := FinalizeMD5(Context);
end;
{$ENDREGION}

{$REGION 'message digest routines'}
{message digest routines}
type
  TMDContextEx = record
    DigestIndex : LongInt;
    Digest      : array [0..255] of Byte;
    KeyIndex    : LongInt;
    case Byte of
      0: (KeyInts : array [0..3] of LongInt);
      1: (Key     : TKey);
  end;
  TBlock2048 = array [0..255] of Byte;

procedure InitTMD(var Context : TTMDContext);
var
  ContextEx : TMDContextEx absolute Context;
begin
  ContextEx.DigestIndex := 0;
  TBlock2048(ContextEx.Digest) := TBlock2048(Pi2048);

  ContextEx.KeyIndex := 0;
  ContextEx.KeyInts[0] := $55555555;
  ContextEx.KeyInts[1] := $55555555;
  ContextEx.KeyInts[2] := $55555555;
  ContextEx.KeyInts[3] := $55555555;
end;

procedure UpdateTMD(var Context : TTMDContext; const Buf; BufSize : LongInt);
var
  ContextEx : TMDContextEx absolute Context;
  BufBytes  : TByteArray absolute Buf;
  AA, BB    : LongInt;
  CC, DD    : LongInt;
  I, R      : LongInt;
begin
  for I := 0 to BufSize - 1 do
    with ContextEx do begin
      {update Digest}
      Digest[DigestIndex] := Digest[DigestIndex] xor BufBytes[I];
      DigestIndex := DigestIndex + 1;
      if (DigestIndex = SizeOf(Digest)) then
        DigestIndex := 0;

      {update BlockKey}
      Key[KeyIndex] := Key[KeyIndex] xor BufBytes[I];
      KeyIndex := KeyIndex + 1;
      if (KeyIndex = SizeOf(Key) div 2) then begin
        AA := KeyInts[3];
        BB := KeyInts[2];
        CC := KeyInts[1];
        DD := KeyInts[0];

        {mix all the bits around for 4 rounds}
        {achieves avalanche and eliminates funnels}
        for R := 0 to 3 do begin
          AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 7);
          BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 13);
          CC := CC + BB; BB := BB + CC; CC := CC xor (CC shr 17);
          DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 9);
          AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 3);
          BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 7);
          CC := CC + BB; BB := BB + CC; CC := CC xor (DD shr 15);
          DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 11);
        end;

        KeyInts[0] := AA;
        KeyInts[1] := BB;
        KeyInts[2] := CC;
        KeyInts[3] := DD;

        KeyIndex := 0;
      end;
    end;
end;

procedure FinalizeTMD(var Context : TTMDContext; var Digest; DigestSize : LongInt);
const
  Padding : array [0..7] of Byte = (1, 0, 0, 0, 0, 0, 0, 0);
var
  ContextEx : TMDContextEx absolute Context;
  I         : Integer;
begin
  {pad with "1", followed by as many "0"s as needed to fill the block}
  UpdateTMD(Context, Padding, SizeOf(Padding) - ContextEx.KeyIndex);

  {mix each block within Context with the key}
  for I := 0 to (SizeOf(ContextEx.Digest) div SizeOf(TCode)) - 1 do
    MixBlock(T128Bit(ContextEx.Key), PCode(@ContextEx.Digest[I * SizeOf(TCode)])^, True);

  {return Digest of requested DigestSize}
  {max digest is 2048-bit, although it could be greater if Pi2048 was larger}
  Move(ContextEx.Digest, Digest, Min(SizeOf(ContextEx.Digest), DigestSize));
end;

{message digest hash}
procedure HashTMD(var Digest; DigestSize : LongInt; const Buf; BufSize : LongInt);
var
  Context : TTMDContext;
begin
  InitTMD(Context);
  UpdateTMD(Context, Buf, BufSize);
  FinalizeTMD(Context, Digest, DigestSize);
end;

{$ENDREGION}

{$REGION 'CreateMachineID'}

{$REGION 'Win32 + Win64'}
{$IFDEF MSWINDOWS}
{$IFNDEF Win16}
{!!.05} {added}
function CreateMachineID(MachineInfo : TEsMachineInfoSet; Ansi: Boolean = True) : LongInt;
{ Obtains information from:
    - Volume sizes (NOT free space)
    - Volume serial numbers
    - Registration name and company
    - GetSystemInfo relevant info
    - Network card ID (if available)
}
const
  sCurVer    = 'Software\Microsoft\Windows\CurrentVersion';           {!!.11}
  sCurVerNT  = 'Software\Microsoft\Windows NT\CurrentVersion';        {!!.11}
  sRegOwner  = 'RegisteredOwner';                                     {!!.11}
  sRegOrg    = 'RegisteredOrganization';                              {!!.11}
  sProdKey1  = 'ProductID';                                           {!!.15}
  sProdKey2  = 'InstallDate';                                         {!!.15}
  sProdKey3  = 'ProductName';                                         {!!.15}
  sProdKey4  = 'InstallationType';                                    {!!.15}
  sProdKey5  = 'EditionID';                                           {!!.15}
  sCrypto    = 'Software\Microsoft\Cryptography';                     {!!.15}
  sMachID    = 'MachineGUID';                                         {!!.15}
  sBIOS      = 'HARDWARE\DESCRIPTION\System\BIOS';                    {!!.15}
  sBIOSKey1  = 'BaseBoardManufacturer';                               {!!.15}
  sBIOSKey2  = 'BaseBoardProduct';                                    {!!.15}
  sBIOSKey3  = 'BaseBoardVersion';                                    {!!.15}
  sBIOSKey4  = 'BIOSReleaseDate';                                     {!!.15}
  sBIOSKey5  = 'BIOSVendor';                                          {!!.15}
  sBIOSKey6  = 'BIOSVersion';                                         {!!.15}
  sBIOSKey7  = 'SystemFamily';                                        {!!.15}
  sBIOSKey8  = 'SystemManufacturer';                                  {!!.15}
  sBIOSKey9  = 'SystemProductName';                                   {!!.15}
  sBIOSKey10 = 'SystemSKU';                                           {!!.15}
  sBIOSKey11 = 'SystemVersion';                                       {!!.15}
  sCPU       = 'HARDWARE\DESCRIPTION\System\CentralProcessor\0';      {!!.15}
  sCPUKey1   = 'Identifier';                                          {!!.15}
  sCPUKey2   = 'ProcessorNameString';                                 {!!.15}
  sCPUKey3   = 'VendorIdentifier';                                    {!!.15}
  sDomain    = 'System\CurrentControlSet\Services\Tcpip\Parameters';  {!!.15}
  sDomainKey1= 'Domain';                                              {!!.15}
  sDomainKey2= 'ICSDomain';                                           {!!.15}
  sDomainKey3= 'DhcpDomain';                                          {!!.15}
  sDomainKey4= 'NV Domain';                                           {!!.15}

type                                                                     {!!.11}
  TUuidCreateSequential = function (lpGUID : Pointer): HResult; stdcall; {!!.11}

var
  hRPCTR4 : THandle;                                                 {!!.11}
  UuidCreateSequential : TUuidCreateSequential;                      {!!.11}
  I       : DWord;
  RegKey  : HKEY;
  GUID1   : TGUID;
  GUID2   : TGUID;
  Drive   : Char;
  SysInfo : TSystemInfo;
  Context : TTMDContext;
  UserInfoFound : Boolean;                                           {!!.11}
  Buf     : array [0..1023] of Byte;
  // for ticket #8
  device  : array [0..2] of AnsiChar;                                {!!.15}
  subst   : array [0..1023] of AnsiChar;                             {!!.15}
  {$IFDEF FPC}
  iController, iDrive, maxController : Integer;
  BufStr : AnsiString;
  {$ENDIF}
  {$IFDEF UseOgJcl}
  myCPUInfo : TCpuInfo;
  {$ENDIF}
begin
  Result := 0;
  InitTMD(Context);

  {include user specific information}
  if Ansi then
  begin
    {!!.11}
    if midUser in MachineInfo then
    begin
      UserInfoFound := False;
      { first look for registered info in \Windows\CurrentVersion }
      if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sCurVer, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then
      begin
        I := SizeOf(Buf);
        if RegQueryValueExA(RegKey, sRegOwner, nil, nil, @Buf, @I) = ERROR_SUCCESS then
        begin
          UserInfoFound := True;
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sRegOrg, nil, nil, @Buf, @I) = ERROR_SUCCESS then
            UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;

      { if not found, then look in \Windows NT\CurrentVersion }
      if not UserInfoFound then
        if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sCurVerNT, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then
        begin
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sRegOwner, nil, nil, @Buf, @I) = ERROR_SUCCESS then
          begin
            UpdateTMD(Context, Buf, I);
            I := SizeOf(Buf);
            if RegQueryValueExA(RegKey, sRegOrg, nil, nil, @Buf, @I) = ERROR_SUCCESS then
              UpdateTMD(Context, Buf, I);
          end;
          RegCloseKey(RegKey);
        end;
    end;
  end
  else
  begin
    if midUser in MachineInfo then
    begin
      UserInfoFound := False;
      { first look for registered info in \Windows\CurrentVersion }
      if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sCurVer, 0,
          KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then
      begin
        I := SizeOf(Buf);
        if RegQueryValueEx(RegKey, sRegOwner, nil, nil, @Buf, @I) = ERROR_SUCCESS then
        begin
          UserInfoFound := True;
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sRegOrg, nil, nil, @Buf, @I) = ERROR_SUCCESS then
            UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;

      { if not found, then look in \Windows NT\CurrentVersion }
      if not UserInfoFound then
        if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sCurVerNT, 0,
            KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then
        begin
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sRegOwner, nil, nil, @Buf, @I) = ERROR_SUCCESS then
          begin
            UpdateTMD(Context, Buf, I);
            I := SizeOf(Buf);
            if RegQueryValueEx(RegKey, sRegOrg, nil, nil, @Buf, @I) = ERROR_SUCCESS then
              UpdateTMD(Context, Buf, I);
          end;
          RegCloseKey(RegKey);
        end;
    end;
  end;

  if midSystem in MachineInfo then begin
    {include system specific information}
    GetSystemInfo(SysInfo);
    PDWord(@Buf[0])^ := SysInfo.dwOemId;
    PDWord(@Buf[4])^ := SysInfo.dwProcessorType;
    UpdateTMD(Context, Buf, 8);
  end;

  if midNetwork in MachineInfo then begin
    {include network ID}
	  {$IFNDEF FPC}
    CoCreateGuid(GUID1);
    CoCreateGuid(GUID2);
	  {$ELSE}
    CreateGuid(GUID1);
    CreateGuid(GUID2);
	  {$ENDIF}

    {!!.11}
    { use UuidCreateSequential instead of CoCreateGuid if available }
    hRPCTR4 := LoadLibrary('rpcrt4.dll');
    if (hRPCTR4 <> 0) then begin
      {$IFNDEF FPC}
      @UuidCreateSequential := GetProcAddress(hRPCTR4, 'UuidCreateSequential');
      {$ELSE}
      UuidCreateSequential := TUuidCreateSequential(GetProcAddress(hRPCTR4, 'UuidCreateSequential'));
      {$ENDIF}
      if Assigned(UuidCreateSequential) then begin
        UuidCreateSequential(@GUID1);
        UuidCreateSequential(@GUID2);
      end;
      FreeLibrary(hRPCTR4);                                      {!!.13}
    end;

    {check to see if "network" ID is available}
    if (GUID1.D4[2] = GUID2.D4[2]) and
       (GUID1.D4[3] = GUID2.D4[3]) and
       (GUID1.D4[4] = GUID2.D4[4]) and
       (GUID1.D4[5] = GUID2.D4[5]) and
       (GUID1.D4[6] = GUID2.D4[6]) and
       (GUID1.D4[7] = GUID2.D4[7]) then
      UpdateTMD(Context, GUID1.D4[2], 6);
  end;

  if midDrives in MachineInfo then begin
    {include drive specific information}
    {$IFDEF FPC}
    maxController := 15;
    if Win32Platform <> VER_PLATFORM_WIN32_NT then
      maxController := 0;
    for iController := 0 to maxController do
    begin
      for iDrive := 0 to 4 do
      begin
        BufStr := '';
        if GetIdeDiskSerialNumber(iController,iDrive,BufStr) then
           if BufStr<>'' then UpdateTMD(Context, BufStr[1], 5);
      end;
    end;
    {$ELSE}
    for Drive := 'C' to 'Z' do begin

      if (GetDriveType(PChar(Drive + ':\')) = DRIVE_FIXED) then begin
        // detect SUBST drives and ignore - see ticket #8                        {!!.15}
        device[0] := AnsiChar(Drive);                                            {!!.15}
        device[1] := ':';                                                        {!!.15}
        device[2] := #0;                                                         {!!.15}
        FillChar(subst, SizeOf(subst), 0);                                       {!!.15}
        QueryDosDeviceA(device, subst, 1024);                                    {!!.15}
        OutputDebugString(PChar(Format('CreateMachineID:midDrives %s:\ %s', [Drive, {$IFDEF DELPHI15UP}System.AnsiStrings.StrPas(subst){$ELSE}StrPas(subst){$ENDIF}])));
        // SUBST drives return a \??\ prefix                                     {!!.15}
        if(Copy({$IFDEF DELPHI15UP}System.AnsiStrings.StrPas(subst){$ELSE}StrPas(subst){$ENDIF}, 1, 4)) <> '\??\' then begin                        {!!.15}
          FillChar(Buf, Sizeof(Buf), 0);
          Buf[0] := Byte(Drive);
          {!!.15} {removed cluster information}
          GetVolumeInformation(PChar(Drive + ':\'), nil, 0,
            PDWord(@Buf[1]){serial number}, I{not used}, I{not used}, nil, 0);

          UpdateTMD(Context, Buf, 5);
        end;                                                                     {!!.15}
      end;
    end;
	  {$ENDIF}
  end;

  if midBIOS in MachineInfo then
  begin
    if Ansi then
    begin
      if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sBIOS, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then
      begin
        I := SizeOf(Buf);
        if RegQueryValueExA(RegKey, sBIOSKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then
        begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey4, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey5, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey6, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey7, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey8, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey9, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey10, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sBIOSKey11, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end
    else
      if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sBIOS, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then
      begin
        I := SizeOf(Buf);
        if RegQueryValueEx(RegKey, sBIOSKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then
        begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey4, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey5, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey6, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey7, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey8, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey9, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey10, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sBIOSKey11, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
  end;

  if midWinProd in MachineInfo then
  begin
    if Ansi then
    begin
      if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sCurVerNT, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueExA(RegKey, sProdKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sProdKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sProdKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sProdKey4, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sProdKey5, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end
    else
    begin
      if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sCurVerNT, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueEx(RegKey, sProdKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sProdKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sProdKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sProdKey4, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sProdKey5, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end;
  end;

  {!!.15}
  if midCPUID in MachineInfo then
  begin
    if Ansi then
    begin
      if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sCPU, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueExA(RegKey, sCPUKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sCPUKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sCPUKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end
    else
    begin
      if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sCPU, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueEx(RegKey, sCPUKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sCPUKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sCPUKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end;
  end;

  {!!.15}
  if midCryptoID in MachineInfo then
  begin
    if Ansi then
    begin
      if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sCrypto, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueExA(RegKey, sMachID, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end
    else
    begin
      if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sCrypto, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueEx(RegKey, sMachID, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end;
  end;

  {!!.15}
  {$IFDEF UseOgJcl}
  if midCPUIDJCL in MachineInfo then
  begin
    ogjcl.GetCPUInfo(myCPUInfo);
    if myCPUInfo.CPUType > 0 then
    begin
      //[to do]
    end;
  end;
  {$ENDIF}

  {!!.15}
  if midDomain in MachineInfo then
  begin
    if Ansi then
    begin
      if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, sDomain, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueExA(RegKey, sDomainKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sDomainKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sDomainKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueExA(RegKey, sDomainKey4, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end
    else
    begin
      if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, sDomain, 0, KEY_QUERY_VALUE, RegKey) = ERROR_SUCCESS) then begin
        I := SizeOf(Buf);
        if RegQueryValueEx(RegKey, sDomainKey1, nil, nil, @Buf, @I) = ERROR_SUCCESS then begin
          UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sDomainKey2, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sDomainKey3, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
          I := SizeOf(Buf);
          if RegQueryValueEx(RegKey, sDomainKey4, nil, nil, @Buf, @I) = ERROR_SUCCESS then UpdateTMD(Context, Buf, I);
        end;
        RegCloseKey(RegKey);
      end;
    end;
  end;

  FinalizeTMD(Context, Result, SizeOf(Result));
end;
{$ENDIF Win16}
{$ENDIF MSWINDOWS}
{$ENDREGION}

{$REGION 'Win16'}
{$IFDEF Win16}
function CreateMachineID(MachineInfo : TEsMachineInfoSet) : LongInt;
var
  I       : DWord;
  RegKey  : DWord;
  GUID1   : TGUID;
  GUID2   : TGUID;
  Drive   : Integer;
  Context : TTMDContext;
  Buf     : array [0..1023] of Char;
begin
  InitTMD(Context);

  {no user (midUser) information under Win16}

  if midSystem in MachineInfo then begin
    {include system specific information}
    I := GetWindowsDirectory(@Buf, Length(Buf));
    UpdateTMD(Context, Buf, I);
    I := GetSystemDirectory(@Buf, Length(Buf));
    UpdateTMD(Context, Buf, I);

    PLongInt(@Buf[0])^ := GetWinFlags;
    PLongInt(@Buf[4])^ := WinProcs.GetVersion;
    UpdateTMD(Context, Buf, 8);
  end;

  if midNetwork in MachineInfo then begin
    {include network ID}
    CoCreateGuid(GUID1);
    CoCreateGuid(GUID2);
    {check to see if "network" ID is available}
    if (GUID1.Data4[2] = GUID2.Data4[2]) and
       (GUID1.Data4[3] = GUID2.Data4[3]) and
       (GUID1.Data4[4] = GUID2.Data4[4]) and
       (GUID1.Data4[5] = GUID2.Data4[5]) and
       (GUID1.Data4[6] = GUID2.Data4[6]) and
       (GUID1.Data4[7] = GUID2.Data4[7]) then
      UpdateTMD(Context, GUID1.Data4[2], 6);
  end;

  if midDrives in MachineInfo then begin
    {include drive specific information}
    for Drive := 2 {C} to 25 {Z} do begin
      if GetDriveType(Drive) = DRIVE_FIXED then begin
        FillChar(Buf, Sizeof(Buf), 0);
        Buf[0] := Drive;
        {!!.06} {removed cluster information}
        PLongInt(@Buf[1])^ := GetDiskSerialNumber(Chr(Drive+Ord('A')));{!!.06}
        UpdateTMD(Context, Buf, 5);
      end;
    end;
  end;

  FinalizeTMD(Context, Result, SizeOf(Result));
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'Kylix'}
{$IFDEF KYLIX}
function CreateMachineID(MachineInfo : TEsMachineInfoSet) : LongInt;
var
  I       : DWord;
  RegKey  : DWord;
  GUID1   : TGUID;
  GUID2   : TGUID;
  Drive   : Integer;
  Context : TTMDContext;
  Buf     : array [0..2047] of Byte;
  iFileHandle : Integer;
begin
  InitTMD(Context);

  {include user specific information}
  if midUser in MachineInfo then
  begin
   //[to do] find some organization specific info
  end;

  if midSystem in MachineInfo then
  begin
    {include system specific information}
    iFileHandle := FileOpen('/proc/cpuinfo', fmopenRead or fmShareDenyNone);
    I := FileSeek(iFileHandle,0,2);
    FileSeek(iFileHandle,0,0);
    if I < 2047 then
    begin
     FileRead(iFileHandle, Buf, I);
     UpdateTMD(Context, Buf, I);
    end;
    FileClose(iFileHandle);

    iFileHandle := FileOpen('/proc/sys/kernel/version', fmopenRead or fmShareDenyNone);
    I := FileSeek(iFileHandle,0,2);
    FileSeek(iFileHandle,0,0);
    if I < 2047 then
    begin
     FileRead(iFileHandle, Buf, I);
     UpdateTMD(Context, Buf, I);
    end;
    FileClose(iFileHandle);

    iFileHandle := FileOpen('/proc/sys/kernel/osrelease', fmopenRead or fmShareDenyNone);
    I := FileSeek(iFileHandle,0,2);
    FileSeek(iFileHandle,0,0);
    if I < 2047 then
    begin
     FileRead(iFileHandle, Buf, I);
     UpdateTMD(Context, Buf, I);
    end;
    FileClose(iFileHandle);

    iFileHandle := FileOpen('/proc/sys/kernel/hostname', fmopenRead or fmShareDenyNone);
    I := FileSeek(iFileHandle,0,2);
    FileSeek(iFileHandle,0,0);
    if I < 2047 then
    begin
     FileRead(iFileHandle, Buf, I);
     UpdateTMD(Context, Buf, I);
    end;
    FileClose(iFileHandle);
  end;

  if midNetwork in MachineInfo then
  begin
    {include network ID}
    CoCreateGuid(GUID1);
    CoCreateGuid(GUID2);
    {check to see if "network" ID is available}
    if (GUID1.D4[2] = GUID2.D4[2]) and
       (GUID1.D4[3] = GUID2.D4[3]) and
       (GUID1.D4[4] = GUID2.D4[4]) and
       (GUID1.D4[5] = GUID2.D4[5]) and
       (GUID1.D4[6] = GUID2.D4[6]) and
       (GUID1.D4[7] = GUID2.D4[7]) then
      UpdateTMD(Context, GUID1.D4[2], 6);
  end;

  if midDrives in MachineInfo then
  begin
    {include drive specific information}
    for Drive := 2 {C} to 25 {Z} do begin
      if GetDriveType(Drive) = 3 {DRIVE_FIXED} then begin
        FillChar(Buf, Sizeof(Buf), 0);
        Buf[0] := Drive;
        {!!.06} {removed cluster information}
        PLongInt(@Buf[1])^ := GetDiskSerialNumber(Chr(Drive+Ord('A')));{!!.06}
        UpdateTMD(Context, Buf, 5);
      end;
    end;
  end;

  FinalizeTMD(Context, Result, SizeOf(Result));
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'FPC-UNIX'}
{$IFDEF FPC}
{$IFDEF UNIX}
{$NOTE Make sure we have some FreeBSD and MacOSX support too at some point }
{ We now assume Linux is used }
function CreateMachineID(MachineInfo : TEsMachineInfoSet) : LongInt;
var
  I       : LongInt;
  RegKey  : DWord;
  GUID1   : TGUID;
  GUID2   : TGUID;
  Drive   : Integer;
  Context : TTMDContext;
  Buf     : array [0..2047] of Byte;
  sl: TStringList;
  iFileHandle : LongInt;
  s: string;

  function lGetUnixUserName: string;
  begin
    // the first two are used when run from a normal login shell
    Result := GetEnvironmentVariable('USERNAME');
    if Result = '' then
      Result := GetEnvironmentVariable('USER');
    // Used if program is run from cron jobs
    if Result = '' then
      Result := GetEnvironmentVariable('LOGNAME');
  end;

begin
  InitTMD(Context);

  {include user specific information}
  if midUser in MachineInfo then
  begin
    // There is no organization specific info, so lets use the user login name
    s := lGetUnixUserName;
    I := Length(s);
    if i > 2048 then
    begin
      s := Copy(s, 1, 2048);  // only first 2048 characters
      i := 2048;
    end;
    FillChar(Buf, Sizeof(Buf), 0);
    Move(s[1], Buf, I);
    UpdateTMD(Context, Buf, I);
  end;

  if midSystem in MachineInfo then
  begin
    {include system specific information}
    iFileHandle := FileOpen('/proc/cpuinfo', fmopenRead or fmShareDenyNone);
    I := FileRead(iFileHandle, Buf,2048);
    if I > 0 then
    begin
      sl := TStringList.Create;
      try
        SetLength(s, Length(Buf));
        Move(Buf, s[1], Length(Buf));
        sl.Text := s;
        { two cpu properties change between reboot. Blank them out }
        for i := 0 to sl.Count-1 do
        begin
          if Pos('cpu MHz', sl[i]) > 0 then
            sl[i] := 'cpu MHz'
          else if Pos('bogomips', sl[i]) > 0 then
            sl[i] := 'bogomips';
        end;
        s := sl.Text;
        { place new data into Buf buffer }
        FillChar(Buf, Sizeof(Buf), 0);
        Move(s[1], Buf, Length(s));
        UpdateTMD(Context, Buf, I-1);
      finally
        sl.Free;
      end;
    end;
    FileClose(iFileHandle);

    iFileHandle := FileOpen('/proc/sys/kernel/version', fmopenRead or fmShareDenyNone);
    I := FileRead(iFileHandle, Buf, 2048);
    if I > 0 then  UpdateTMD(Context, Buf, I-1);
    FileClose(iFileHandle);

    iFileHandle := FileOpen('/proc/sys/kernel/osrelease', fmopenRead or fmShareDenyNone);
    I := FileRead(iFileHandle, Buf, 2048);
    if I > 0 then  UpdateTMD(Context, Buf, I-1);
    FileClose(iFileHandle);

    iFileHandle := FileOpen('/proc/sys/kernel/hostname', fmopenRead or fmShareDenyNone);
    I := FileRead(iFileHandle, Buf, 2048);
    if I > 0 then  UpdateTMD(Context, Buf, I-1);
    FileClose(iFileHandle);
  end;

  if midNetwork in MachineInfo then
  begin
    {include network ID}
    CreateGuid(GUID1);
    CreateGuid(GUID2);
    {check to see if "network" ID is available}
    if (GUID1.D4[2] = GUID2.D4[2]) and
       (GUID1.D4[3] = GUID2.D4[3]) and
       (GUID1.D4[4] = GUID2.D4[4]) and
       (GUID1.D4[5] = GUID2.D4[5]) and
       (GUID1.D4[6] = GUID2.D4[6]) and
       (GUID1.D4[7] = GUID2.D4[7]) then
      UpdateTMD(Context, GUID1.D4[2], 6);
  end;

  // TODO: This midDrives code is rubbish and doesn't work with SATA or SCSI drives.
(*
  if midDrives in MachineInfo then
  begin
    {include drive specific information}
    for Drive := 2 {C} to 25 {Z} do begin
      if GetDriveType(Drive) = 3 {DRIVE_FIXED} then begin
        FillChar(Buf, Sizeof(Buf), 0);
        Buf[0] := Drive;
        PLongInt(@Buf[1])^ := GetDiskSerialNumber(Chr(Drive+Ord('A')));
        UpdateTMD(Context, Buf, 5);
      end;
    end;
  end;
*)

  FinalizeTMD(Context, Result, SizeOf(Result));
end;

{$ENDIF}
{$ENDIF}
{$ENDREGION}

{$REGION 'Delphi-POSIX: MACOS LINUX IOS ANDROID'}
{$IFDEF DELPHI19UP}
{$IFDEF POSIX}
function CreateMachineID(MachineInfo : TEsMachineInfoSet; Ansi: Boolean = True) : LongInt;
var
  Context : TTMDContext;
  Buf     : array [0..2047] of Byte;

  {$IF defined(MACOS) or defined(LINUX)}
  ifap, Next : pifaddrs;
  sdp : sockaddr_dl;
  {$ENDIF}

  {$IFDEF IOS}
  Device : UIDevice;
  ID : UTF8String absolute Buf;
  {$ENDIF}

  {$IFDEF ANDROID}
  ID: String absolute Buf;
  {$ENDIF}


begin
  InitTMD(Context);

  {$IFDEF IOS}
  Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  {$ENDIF}

  if midUser in MachineInfo then
  begin
    //UpdateTMD(Context, Buf, I);

    {$IFDEF ANDROID}
    ID := JStringToString(TJBuild.JavaClass.USER);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    {$ENDIF}
  end;

  if midSystem in MachineInfo then
  begin
    {$IFDEF IOS}
    // see https://developer.apple.com/library/ios/documentation/uikit/reference/UIDevice_Class/Reference/UIDevice.html
    ID := Device.identifierForVendor.UUIDString.UTF8String;
    UpdateTMD(Contect, Buf, Length(ID));
    {$ENDIF}

    {$IFDEF ANDROID}
    ID := JStringToString(TJBuild.JavaClass.BOARD);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.BOOTLOADER);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.BRAND);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.DEVICE);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.DISPLAY);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char))));
    ID := JStringToString(TJBuild.JavaClass.HARDWARE);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.HOST);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.ID);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.MANUFACTURER);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.MODEL);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.PRODUCT);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.RADIO);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.MODEL);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.SERIAL);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    ID := JStringToString(TJBuild.JavaClass.TAGS);
    UpdateTMD(Context, Buf, (Length(ID)*SizeOf(Char)));
    {$ENDIF}
  end;

  if midNetwork in MachineInfo then
  begin
  end;

  if midDrives in MachineInfo then
  begin
  end;

  if midCPUID in MachineInfo then
  begin
  end;

  if midCPUIDJCL in MachineInfo then
  begin
  end;

  if midBIOS in MachineInfo then
  begin
  end;

  if midWinProd in MachineInfo then
  begin
  end;

  if midCryptoID in MachineInfo then
  begin
  end;

  if midNetMAC in MachineInfo then
  begin
    // not available in IOS 7 and later
    {$IF defined(MACOS) or defined(LINUX)}

    if getifaddrs(ifap)=0 then
    begin
      try
        Next := ifap;
        while Next <> nil do
        begin
          case Next.ifa_addr.sa_family of
            AF_LINK:
              begin
                sdp := psockaddr_dl(Next.ifa_addr)^;
                if sdp.sdl_type = IFT_ETHER then
                begin
                  Move(Pointer(PAnsiChar(@sdp.sdl_data[0]) + sdp.sdl_nlen)^, Buf, 6);
                  UpdateTMD(Context, Buf, 6);
                end;
              end;
            AF_INET,
            AF_INET6:
              begin
              end;
          end;
          Next := Next.ifa_next;
        end;
      finally
        freeifaddrs(ifap);
      end;
    end;

    {$ENDIF}
  end;

  if midDomain in MachineInfo then
  begin
  end;

  FinalizeTMD(Context, Result, SizeOf(Result));
end;
{$ENDIF POSIX}
{$ENDIF DELPHI19UP}
{$ENDREGION}


{$ENDREGION}

{$REGION 'key generation routines'}
{key generation routines }
procedure GenerateRandomKeyPrim(var Key; KeySize: Cardinal);
var
  Bytes : TByteArray absolute Key;
  I     : Integer;
begin
  Randomize;
  for I := 0 to KeySize - 1 do
    Bytes[I] := Random(256);
end;

procedure GenerateTMDKeyPrim(var Key; KeySize: Cardinal; const Str: AnsiString);
var
  I  : Integer;
  S2 : AnsiString;
begin
  {strip accented characters from the string}                          {!!.06}
  S2 := Str;                                                           {!!.06}
  for I := Length(S2) downto 1 do                                      {!!.06}
    if Ord(S2[I]) > 127 then                                           {!!.06}
      Delete(S2, I, 1);                                                {!!.06}

  HashTMD(Key, KeySize, S2[1], Length(S2));                            {!!.06}
end;

procedure GenerateMD5KeyPrim(var Key: TKey; const Str: AnsiString);
var
  D : TMD5Digest;
  I  : Integer;
  S2 : AnsiString;
begin
  {strip accented characters from the string}                          {!!.06}
  S2 := Str;                                                           {!!.06}
  for I := Length(S2) downto 1 do                                      {!!.06}
    if Ord(S2[I]) > 127 then                                           {!!.06}
      Delete(S2, I, 1);                                                {!!.06}

  D := HashMD5(S2[1], Length(S2));                                     {!!.06}
  Key := TKey(D);
end;
{$ENDREGION}

{$REGION 'modifier routines'}
{modifier routines}
function GenerateStringModifierPrim(const S : AnsiString) : LongInt;
var
  I   : Integer;                                                       {!!.06}
  Sig : array [0..4] of AnsiChar;
  S2  : AnsiString;                                                        {!!.06}
begin
  FillChar(Sig, SizeOf(Sig), 0);

  {strip accented characters from the string}                          {!!.06}
  S2 := S;                                                             {!!.06}
  for I := Length(S2) downto 1 do                                      {!!.06}
    if Ord(S2[I]) > 127 then                                           {!!.06}
      Delete(S2, I, 1);                                                {!!.06}

  {$IFDEF DELPHI15UP}
  System.AnsiStrings.StrPLCopy(Sig, AnsiString(System.AnsiStrings.AnsiUpperCase(S2)), Min(4, Length(S2)));               {!!.06}
  {$ELSE}
  StrPLCopy(Sig, AnsiString(AnsiUpperCase(S2)), Min(4, Length(S2)));               {!!.06}
  {$ENDIF}
  Result := PLongInt(@Sig[0])^;
end;

function GenerateUniqueModifierPrim : LongInt;
var
  ID : TGUID;
begin
  CreateGuid(ID);
  Mix128(T128Bit(ID));
  Result := T128Bit(ID)[3];
end;

{!!.05} {revised}
function GenerateMachineModifierPrim : LongInt;
begin
  Result := CreateMachineID([midUser, midSystem, {midNetwork,} midDrives]);
end;

function GenerateDateModifierPrim(D : TDateTime) : LongInt;
begin
  Result := Trunc(D);
  TLongIntRec(Result).Hi := TLongIntRec(Result).Lo xor $AAAA;
end;

procedure ApplyModifierToKeyPrim(Modifier : LongInt; var Key; KeySize : Cardinal);
begin
  if Modifier <> 0 then
    XorMem(Key, Modifier, Min(SizeOf(Modifier), KeySize));
end;

{$ENDREGION}




{$REGION '*** general routines ***'}

{$REGION 'general'}
{*** general routines ***}
function GetCodeType(const Key : TKey; const Code : TCode) : TCodeType;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  case Work.CheckValue of
    DateCheckCode    : Result := ctDate;
    DaysCheckCode    : Result := ctDays;
    RegCheckCode     : Result := ctRegistration;
    SerialCheckCode  : Result := ctSerialNumber;
    UsageCheckCode   : Result := ctUsage;
    NetCheckCode     : Result := ctNetwork;
    SpecialCheckCode : Result := ctSpecial;
  else
    Result := ctUnknown;
  end;
end;

function ExpandDate(D : Word) : TDateTime;
begin
  if D > 0 then
    Result := LongInt(D) + BaseDate
  else
    Result := EncodeDate(9999, 1, 1);
end;

function ShrinkDate(D : TDateTime) : Word;
begin
  if (Trunc(D) = 0) or (Trunc(D) - BaseDate > High(Word)) then
    Result := 0
  else
    Result := Trunc(D) - BaseDate;
end;

function GetExpirationDate(const Key : TKey; const Code : TCode) : TDateTime;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  case Work.CheckValue of
    DateCheckCode    : if (Work.Expiration > 0) then Result := ExpandDate(Work.Expiration) else Result := ExpandDate(Work.EndDate);
    DaysCheckCode    : Result := ExpandDate(Work.Expiration);
    RegCheckCode     : Result := ExpandDate(Work.Expiration);
    SerialCheckCode  : Result := ExpandDate(Work.Expiration);
    UsageCheckCode   : Result := ExpandDate(Work.Expiration);
    SpecialCheckCode : Result := ExpandDate(Work.Expiration);
  else
    Result := ExpandDate(0)
  end;
end;
{$ENDREGION}

{$REGION '*** date code ***'}
{*** date code ***}

procedure InitDateCode(const Key : TKey;
          StartDate, EndDate : TDateTime; var Code : TCode);
begin
  if StartDate <= BaseDate then EOnGuardBadDateException.Create('Start Date is less than or equal to BaseDate.');
  if StartDate > EncodeDate(2175,6,6) then EOnGuardBadDateException.Create('Start Date is greater than 2175-Jun-06 which is not supported.');

  Code.CheckValue := DateCheckCode;
  Code.Expiration := 0; {not used for date codes}
  Code.FirstDate := ShrinkDate(StartDate);
  Code.EndDate := ShrinkDate(EndDate);
  MixBlock(T128bit(Key), Code, True);
end;

{!!.15}
procedure InitDateCodeEx(const Key : TKey; StartDate, EndDate, Expires : TDateTime; var Code : TCode);
begin
  if StartDate <= BaseDate then EOnGuardBadDateException.Create('Start Date is less than or equal to BaseDate.');
  if StartDate > EncodeDate(2175,6,6) then EOnGuardBadDateException.Create('Start Date is greater than 2175-Jun-06 which is not supported.');
  if Expires <= BaseDate then EOnGuardBadDateException.Create('Expiration Date is less than or equal to BaseDate.');
  if Expires <= StartDate then EOnGuardBadDateException.Create('Expiration Date is less than or equal to StartDate.');

  Code.CheckValue := DateCheckCode;
  Code.Expiration := ShrinkDate(Expires);
  Code.FirstDate := ShrinkDate(StartDate);
  Code.EndDate := ShrinkDate(EndDate);
  MixBlock(T128bit(Key), Code, True);
end;

function IsDateCodeValid(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = DateCheckCode) and
            (ExpandDate(Work.FirstDate) <= Date);
  {$IFNDEF NoOnGuardExceptions}
    if Work.CheckValue = DateCheckCode then
      if ExpandDate(Work.FirstDate) > Date then EonGuardClockIssueException.Create('The code''s FirstDate is in the future.')
  {$ENDIF}
end;

function GetDateCodeValue(const Key : TKey; const Code : TCode) : TDateTime;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  {return the end date}
  if (Work.CheckValue = DateCheckCode) and
     (ExpandDate(Work.FirstDate) <= Date) then
    Result := ExpandDate(Work.EndDate)
  else
    Result := 0;
end;

function IsDateCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
begin
  Result := (GetDateCodeValue(Key, Code) < Date);
end;

function GetDateCodeStart(const Key : TKey; const Code : TCode) : TDateTime;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  {return the end date}
  if (Work.CheckValue = DateCheckCode) then
    Result := ExpandDate(Work.FirstDate)
  else
    Result := 0;
end;

function GetDateCodeEnd(const Key : TKey; const Code : TCode) : TDateTime;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  {return the end date}
  if (Work.CheckValue = DateCheckCode) then
    Result := ExpandDate(Work.EndDate)
  else
    Result := 0;
end;

{$ENDREGION}

{$REGION '*** days code ***'}
{*** days code ***}

procedure InitDaysCode(const Key : TKey; Days : Word; Expires : TDateTime;
                       var Code : TCode);
begin
  Code.CheckValue := DaysCheckCode;
  Code.Expiration := ShrinkDate(Expires);
  Code.Days := Days;
  Code.LastAccess := ShrinkDate(Date);
  MixBlock(T128bit(Key), Code, True);
end;

function IsDaysCodeValid(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = DaysCheckCode) and
            (ExpandDate(Work.LastAccess) <= Date);
  {$IFNDEF NoOnGuardExceptions}
    if Work.CheckValue = DaysCheckCode then
      if ExpandDate(Work.LastAccess) > Date then EonGuardClockIssueException.Create('The code''s LastAccess is in the future.')
  {$ENDIF}
end;

procedure DecDaysCode(const Key : TKey; var Code : TCode);
var
  X : LongInt;
begin
  MixBlock(T128bit(Key), Code, False);
  X := ShrinkDate(Date);
  if (Code.LastAccess <> X) then begin
    if Code.Days > 0 then                                              {!!.02}
      Code.Days := Max(0, Code.Days - 1);                              {!!.02}
    Code.LastAccess := X;
  end;
  MixBlock(T128bit(Key), Code, True);
end;

function GetDaysCodeValue(const Key : TKey; const Code : TCode) : LongInt;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  if (Work.CheckValue = DaysCheckCode) and
     (ExpandDate(Work.LastAccess) <= Date) then
    Result := Work.Days
  else
    Result := 0;
  {$IFNDEF NoOnGuardExceptions}
    if Work.CheckValue = DaysCheckCode then
      if ExpandDate(Work.LastAccess) > Date then EonGuardClockIssueException.Create('The code''s LastAccess is in the future.')
  {$ENDIF}
end;

function IsDaysCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.Days = 0) or (ExpandDate(Work.Expiration) < Date);
end;
{$ENDREGION}

{$REGION '*** registration code ***'}
{*** registration code ***}

procedure InitRegCode(const Key : TKey; const RegStr : AnsiString; Expires : TDateTime; var Code : TCode);
var
  S : AnsiString;                                                          {!!.06}
  I : Integer;                                                         {!!.06}
begin
  Code.CheckValue := RegCheckCode;
  Code.Expiration := ShrinkDate(Expires);
  {strip accented characters from the registration string}             {!!.06}
  S := RegStr;                                                         {!!.06}
  for I := Length(S) downto 1 do                                       {!!.06}
    if Ord(S[I]) > 127 then                                            {!!.06}
      Delete(S, I, 1);                                                 {!!.06}
  Code.RegString := StringHashElf(AnsiString(AnsiUpperCase(S)));                   {!!.06}
  MixBlock(T128bit(Key), Code, True);
end;

function IsRegCodeValid(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = RegCheckCode);
end;

function IsRegCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := ExpandDate(Work.Expiration) < Date;
end;

function IsRegCodeRegisteredTo(const Key : TKey; const Code : TCode; const RegStr: AnsiString) : Boolean;
var
  Work : TCode;
  S : AnsiString;
  I : Integer;
  v : LongInt;
begin
  Result := False;
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  {strip accented characters from the registration string}             {!!.06}
  S := RegStr;                                                         {!!.06}
  for I := Length(S) downto 1 do                                       {!!.06}
    if Ord(S[I]) > 127 then                                            {!!.06}
      Delete(S, I, 1);                                                 {!!.06}
  v := StringHashElf(AnsiString(AnsiUpperCase(S)));
  Result := v = Work.RegString;
end;
{$ENDREGION}

{$REGION '*** serial number code ***'}
{*** serial number code ***}

procedure InitSerialNumberCode(const Key : TKey; Serial : LongInt; Expires : TDateTime; var Code : TCode);
begin
  Code.CheckValue := SerialCheckCode;
  Code.Expiration := ShrinkDate(Expires);
  Code.SerialNumber := Serial;
  MixBlock(T128bit(Key), Code, True);
end;

function IsSerialNumberCodeValid(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = SerialCheckCode);
end;

function GetSerialNumberCodeValue(const Key : TKey; const Code : TCode) : LongInt;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  if Work.CheckValue = SerialCheckCode then
    Result := Work.SerialNumber
  else
    Result := 0;
end;

function IsSerialNumberCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := ExpandDate(Work.Expiration) < Date;
end;

function IsSerialNumberCodeValidFor(const Key : TKey; const Code : TCode; const Serial: LongInt) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = SerialCheckCode) and (Serial = Work.SerialNumber);
end;

{$ENDREGION}

{$REGION '*** special code ***'}
{*** special code ***}

procedure InitSpecialCode(const Key : TKey; Value : LongInt; Expires : TDateTime; var Code : TCode);
begin
  Code.CheckValue := SpecialCheckCode;
  Code.Expiration := ShrinkDate(Expires);
  Code.Value := Value;
  MixBlock(T128bit(Key), Code, True);
end;

function IsSpecialCodeValid(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = SpecialCheckCode);
end;

function GetSpecialCodeValue(const Key : TKey; const Code : TCode) : LongInt;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  if Work.CheckValue = SpecialCheckCode then
    Result := Work.Value
  else
    Result := 0;
end;

function IsSpecialCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := ExpandDate(Work.Expiration) < Date;
end;

function IsSpecialCodeValidFor(const Key : TKey; const Code : TCode; const Value: LongInt) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = SpecialCheckCode) and (Work.Value = Value);
end;

{$ENDREGION}

{$REGION '*** usage code ***'}
{*** usage code ***}

procedure InitUsageCode(const Key : TKey; Count : Word; Expires : TDateTime; var Code : TCode);
begin
  Code.CheckValue := UsageCheckCode;
  Code.Expiration := ShrinkDate(Expires);
  Code.UsageCount := Count;
  Code.LastChange := ShrinkDate(Date);                                 {!!.02}
  MixBlock(T128bit(Key), Code, True);
end;

function IsUsageCodeValid(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.CheckValue = UsageCheckCode) and                     {!!.02}
            (ExpandDate(Work.LastChange) <= Date);                     {!!.02}
  {$IFNDEF NoOnGuardExceptions}
    if Work.CheckValue = UsageCheckCode then
      if ExpandDate(Work.LastChange) > Date then EonGuardClockIssueException.Create('The code''s LastChange is in the future.')
  {$ENDIF}
end;

procedure DecUsageCode(const Key : TKey; var Code : TCode);
var                                                                    {!!.02}
  D : Word;                                                            {!!.02}
begin
  MixBlock(T128bit(Key), Code, False);
  D := ShrinkDate(Date);                                               {!!.02}
  {$IFDEF OgUsageUnlimited}
  if not ((Code.UsageCount = 65535) and (Code.Expiration=65535) and (Code.LastChange=1)) then begin {$ENDIF}
  if (Code.UsageCount > 0) then                                          {!!.02}
    Code.UsageCount := Max(0, Code.UsageCount - 1);                    {!!.02}
  if (Code.LastChange < D) then                                        {!!.02}
    Code.LastChange := D;                                              {!!.02}
  {$IFDEF OgUsageUnlimited} end; {$ENDIF}

  MixBlock(T128bit(Key), Code, True);
end;

function GetUsageCodeValue(const Key : TKey; const Code : TCode) : LongInt;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  if (Work.CheckValue = UsageCheckCode) and                            {!!.02}
     (ExpandDate(Work.LastChange) <= Date) then                        {!!.02}
    Result := Work.UsageCount                                          {!!.02}
  else
    Result := 0;
  {$IFNDEF NoOnGuardExceptions}
    if Work.CheckValue = UsageCheckCode then
      if ExpandDate(Work.LastChange) > Date then EonGuardClockIssueException.Create('The code''s LastChange is in the future.')
  {$ENDIF}
end;

function IsUsageCodeExpired(const Key : TKey; const Code : TCode) : Boolean;
var
  Work : TCode;
begin
  Work := Code;
  MixBlock(T128bit(Key), Work, False);
  Result := (Work.UsageCount = 0) or (ExpandDate(Work.Expiration) < Date);
  {$IFNDEF NoOnGuardExceptions}
    if Work.CheckValue = UsageCheckCode then
      if ExpandDate(Work.LastChange) > Date then EonGuardClockIssueException.Create('The code''s LastChange is in the future.')
  {$ENDIF}
end;

{$IFDEF OgUsageUnlimited}
procedure InitUsageCodeUnlimited(const Key : TKey; var Code : TCode);
begin
  Code.CheckValue := UsageCheckCode;
  Code.Expiration := 65535;
  Code.UsageCount := 65535;
  Code.LastChange := 1;                                 {!!.02}
  MixBlock(T128bit(Key), Code, True);
end;
{$ENDIF}

{$ENDREGION}

{$ENDREGION}



function BufferToHex(const Buf; BufSize : Cardinal) : string;
var
  Bytes : TByteArray absolute Buf;
  I     : LongInt;
begin
  Result := '';
  for I := 0 to BufSize - 1 do
    Result := Result + IntToHex(Bytes[I], 2);
end;

function BufferToHexBytes(const Buf;  BufSize : Cardinal) : string;
var
  Bytes  : TByteArray absolute Buf;
  I      : LongInt;
  HexStr : string;
begin
  {$IFDEF BCB}
  HexStr := '0x';
  {$ELSE}
  HexStr := '$';
  {$ENDIF}
  Result := HexStr + IntToHex(Bytes[0], 2);
  for I := 1 to BufSize - 1 do
    Result := Result + ',' + HexStr + IntToHex(Bytes[I], 2);
end;

{$REGION 'function GetDiskSerialNumber - multiplatform'}
{$IFDEF Win16}
type
  PMediaIDRec = ^TMediaIDRec;
  TMediaIDRec = packed record
    InfoLevel    : Word;                      {reserved for future use}
    SerialNumber : LongInt;                   {disk serial number}
    VolumeLabel  : array[0..10] of AnsiChar;  {disk volume label}
    FileSystemID : array[0..7] of AnsiChar;   {string for internal use by the OS}
  end;

type
  DPMIRegisters = record
    DI : LongInt;
    SI : LongInt;
    BP : LongInt;
    Reserved : LongInt;
    case integer of
    1 : ( BX : LongInt;
          DX : LongInt;
          CX : LongInt;
          AX : LongInt;
          Flags : Word;
          ES : Word;
          DS : Word;
          FS : Word;
          GS : Word;
          IP : Word;
          CS : Word;
          SP : Word;
          SS : Word );
    2 : ( BL, BH : Byte; EBXH : Word;
          DL, DH : Byte; EDXH : Word;
          CL, CH : Byte; ECXH : Word;
          AL, AH : Byte; EAXH : Word );
  end;

  OS = record
    O, S : Word;
  end;

function GetCPUFlags : Byte; assembler;
asm
  lahf
  mov    al,ah
end;

function SimulateRealModeInt(IntNo : Byte; var Regs : DPMIRegisters) : Word; assembler;
asm
  xor     bx,bx
  mov     bl,IntNo
  xor     cx,cx       {StackWords = 0}
  les     di,Regs
  mov     ax,0300h
  int     31h
  jc      @@ExitPoint

  xor     ax,ax
@@ExitPoint:
end;

function GetMediaID(Drive : Byte; var MediaIDRec : TMediaIDRec) : Boolean;
type
  DoubleWord = record LoWord, HiWord : Word; end;
var
  L      : LongInt;
  RP, PP : PMediaIDRec;
  Regs   : DPMIRegisters;
begin
  Result := False;
  L := GlobalDosAlloc(SizeOf(TMediaIDRec));
  if L = 0 then
    Exit;
  try
    RP := Ptr(DoubleWord(L).HiWord, 0);
    PP := Ptr(DoubleWord(L).LoWord, 0);
    FillChar(Regs, SizeOf(Regs), 0);
    with Regs do begin
      DS := OS(RP).S;
      DX := OS(RP).O;
      AX := $440D;
      BX := Drive;
      CX := $0866;
      Flags := GetCPUFlags;
    end;
    SimulateRealModeInt($21, Regs);
    if not Odd(Regs.Flags) then begin
      MediaIDRec := PP^;
      Result := True;
    end;
  finally
    GlobalDosFree(OS(PP).S);
  end;
end;

function GetDiskSerialNumber(Drive : Char) : LongInt;
var
  MR : TMediaIDRec;
begin
  if GetMediaID(Ord(UpCase(Drive))-Ord('A')+1 ,MR) then
    Result := MR.SerialNumber
  else
    Result := -1;
end;
{$ENDIF}

{$IFDEF LINUX}
function MyHashElf(const Buf;  BufSize : LongInt) : LongInt;
var
  Bytes : TByteArray absolute Buf;
  I, X  : LongInt;
begin
  Result := 0;
  for I := 0 to BufSize - 1 do begin
    Result := (Result shl 4) + Bytes[I];
    X := Result and $F0000000;
    if (X <> 0) then
      Result := Result xor (X shr 24);
    Result := Result and (not X);
  end;
end;

function GetDiskSerialNumber(Drive : AnsiChar) : LongInt;
var
   boot_partition : String;
   drive_model : String;
   iFileHandle : Integer;
   Buffer : PChar;
   iFileSize : Integer;
begin
    // read /proc/cmdline
    iFileHandle := FileOpen('/proc/cmdline', fmOpenRead or fmShareDenyNone);
    iFileSize := FileSeek(iFileHandle,0,2);
    Buffer := PChar(AllocMem(iFileSize+1));
    FileSeek(iFileHandle,0,0);
    FileRead(iFileHandle, Buffer^, iFileSize);
    boot_partition := StrPas(Buffer);
    FileClose(iFileHandle);
    FreeMem(Buffer);

    // get root=/dev/? into boot_partition
    if Pos('root=/dev/', boot_partition) > 0 then
    begin
     Delete(boot_partition, 1, Pos('root=/dev/', boot_partition)-1);
     if (Pos(' ', boot_partition) > 0) then
     begin
      boot_partition := Trim(LeftStr(boot_partition, Pos(' ', boot_partition)));
      Delete(boot_partition, 1, 10);
      boot_partition := LeftStr(boot_partition,3);
     end;
    end
    else
    begin
     boot_partition := 'hda';
    end;

    if boot_partition[1] = 'h' then boot_partition := '/ide/' + boot_partition;
    if boot_partition[1] = 's' then boot_partition := '/scsi/' + boot_partition;

    // read /proc/ide/boot_partition/model
    iFileHandle := FileOpen('/proc' + boot_partition + '/model', fmOpenRead or fmShareDenyNone);
    iFileSize := FileSeek(iFileHandle,0,2);
    Buffer := PChar(AllocMem(iFileSize+1));
    FileSeek(iFileHandle,0,0);
    FileRead(iFileHandle, Buffer^, iFileSize);
    drive_model := StrPas(Buffer);
    FileClose(iFileHandle);
    FreeMem(Buffer);

    // create a hash value of the drive_model to return an integer
    Result := MyHashElf(drive_model[1], Length(drive_model));
end;
{$ENDIF}

{$IFDEF FreeBSD}
function GetDiskSerialNumber(Drive : AnsiChar) : LongInt;
begin
  {$NOTE: Still to be implemented }
  Result := 0;
end;

function MyHashElf(const Buf;  BufSize : LongInt) : LongInt;
begin
  Result := 0;
end;
{$ENDIF FreeBSD}
{$ENDREGION}

function HexStringIsZero(const Hex : string) : Boolean;
var
  I   : Integer;
  Str : string;
begin
  Result := False;

  // check if input is a blank string
  if Hex = '' then Exit;

  Str := '';
  for I := 1 to Length(Hex) do
    if Upcase(Hex[I]) in ['0'..'9', 'A'..'F'] then
      Str := Str + Hex[I];

  // check if string is blank
  if Str = '' then Exit;

  for I := 1 to Length(Str) do
    if Str[I] <> '0' then
      Exit;

  Result := True;
end;


function HexToBuffer(const Hex : string; var Buf; BufSize : Cardinal) : Boolean;
var
  Bytes : TByteArray absolute Buf;
  I, C  : Integer;
  Str   : string;
begin
  Result := False;

  // check if Hex is a blank string
  if Hex = '' then Exit;

  Str := '';
  for I := 1 to Length(Hex) do
    if Upcase(Hex[I]) in ['0'..'9', 'A'..'F'] then
      Str := Str + Hex[I];

  // check if Str is a blank string
  if Str = '' then Exit;

  if (Cardinal(Length(Str) div 2) <> BufSize) then                     {!!.07}
    Exit;

  for I := 0 to BufSize - 1 do begin
    Val('$' + Copy(Str, (I shl 1) + 1, 2), Bytes[I], C);
    if (C <> 0) then
      Exit;
  end;

  Result := True;
end;

{$REGION 'function Max'}
{$IFNDEF OgPUREPASCAL_Max}
{$IFDEF Win32}
function Max(A, B : LongInt) : LongInt; register;
asm
  cmp  eax, edx
  jge  @Exit
  mov  eax, edx
@Exit:
end;
{$ENDIF}
{$ELSE}
function Max(A, B : LongInt) : LongInt;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'function Min'}
{$IFNDEF OgPUREPASCAL_Min}
{$IFDEF Win32}
function Min(A, B : LongInt) : LongInt; register;
asm
  cmp  eax, edx
  jle  @Exit
  mov  eax, edx
@Exit:
end;
{$ENDIF}
{$ELSE}
function Min(A, B : LongInt) : LongInt;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'procedure XorMem'}
{$IFNDEF OgPUREPASCAL_XorMem}
{$IFDEF MSWINDOWS}
{$IFNDEF Win16}
procedure XorMem(var Mem1; const Mem2; Count : Cardinal); register;
asm
  push esi
  push edi

  mov  esi, eax         //esi = Mem1
  mov  edi, edx         //edi = Mem2

  push ecx              //save byte count
  shr  ecx, 2           //convert to dwords
  jz   @Continue

  cld
@Loop1:                 //xor dwords at a time
  mov  eax, [edi]
  xor  [esi], eax
  add  esi, 4
  add  edi, 4
  dec  ecx
  jnz  @Loop1

@Continue:              //handle remaining bytes (3 or less)
  pop  ecx
  and  ecx, 3
  jz   @Done

@Loop2:                 //xor remaining bytes
  mov  al, [edi]
  xor  [esi], al
  inc  esi
  inc  edi
  dec  ecx
  jnz  @Loop2

@Done:
  pop  edi
  pop  esi
end;
{$ENDIF}
{$ENDIF}
{!!.02} {revised}
{$IFDEF Win16}
procedure XorMem(var Mem1; const Mem2; Count : Cardinal); assembler;
asm
  push  ds
  push  es
  lds   si, Mem2
  les   di, Mem1
  mov   cx, Count
  jz    @Done
  cld
@Loop1:
  mov  al, ds:[si]
  xor  es:[di], al
  inc  si
  inc  di
  dec  cx
  jnz  @Loop1
@Done:
  pop  es
  pop  ds
end;
{$ENDIF}
{$IFDEF LINUX}
procedure XorMem(var Mem1; const Mem2; Count : Cardinal); register;
asm
  push esi
  push edi

  mov  esi, eax         //esi = Mem1
  mov  edi, edx         //edi = Mem2

  push ecx              //save byte count
  shr  ecx, 2           //convert to dwords
  jz   @Continue

  cld
@Loop1:                 //xor dwords at a time
  mov  eax, [edi]
  xor  [esi], eax
  add  esi, 4
  add  edi, 4
  dec  ecx
  jnz  @Loop1

@Continue:              //handle remaining bytes (3 or less)
  pop  ecx
  and  ecx, 3
  jz   @Done

@Loop2:                 //xor remaining bytes
  mov  al, [edi]
  xor  [esi], al
  inc  esi
  inc  edi
  dec  ecx
  jnz  @Loop2

@Done:
  pop  edi
  pop  esi
end;
{$ENDIF}
{$ELSE}
procedure XorMem(var Mem1; const Mem2; Count : Cardinal);
var
  pB1,pB2 : PByte;
  B1,B2  : Byte;
  i : Cardinal;
begin
  if Count = 0 then Exit;
  i := 0;
  pB1 := PByte(@Mem1);//Mem1
  pB2 := PByte(@Mem2);//Mem2
  while i < Count do
  begin
    B1 := pB1^;
    B2 := pB2^;
    pB1^ := B1 xor B2;
    Inc(pB1);
    Inc(pB2);
    Inc(i);
  end;
end;
{$ENDIF OgPUREPASCAL_XorMem}
{$ENDREGION}

{!!.09}
function OgFormatDate(Value : TDateTime) : string;
  {convert date to string with 4-digit year and 2-digit month}
var
  S : string;
begin
  {$IFNDEF FPC}
  {$IFDEF DELPHI}
    {$IFDEF DELPHI15UP}
      s := FormatSettings.ShortDateFormat;
    {$ELSE}
      S := ShortDateFormat;
    {$ENDIF}
  {$ENDIF}
  if Pos('yyyy', S) = 0 then
    Insert('yy', S, Pos('yy', S));
  if Pos('MMM', S) > 0 then
    Delete(S, Pos('MMM', S), 1);
  Result := FormatDateTime(S, Value);
  {$ELSE}
  ShortDateFormat := 'yyyy-mm-dd';
  Result := DateToStr(Value);//FormatDateTime(S, Value)
  {$ENDIF}
end;







{$IFDEF LINUX}
function GetDriveType(drive:Integer): Integer;
const
  DRIVE_UNKNOWN = 0;
  DRIVE_NO_ROOT_DIR = 1;
  DRIVE_REMOVABLE = 2;
  DRIVE_FIXED = 3;
  DRIVE_REMOTE = 4;
  DRIVE_CDROM = 5;
  DRIVE_RAMDISK = 6;
var
   f: TextFile;
   fn : String;
   media : String;
begin
 Result := DRIVE_UNKNOWN;
 // drive = 1-25 (A-Z)

 //assuming IDE drives
 //assuming C: = hda
 case drive of
  1: fn := '';
  2: fn := '';
  3: fn := 'hda';
  4: fn := 'hdb';
  5: fn := 'hdc';
  6: fn := 'hdd';
  7: fn := '';
  8..25: fn := '';
 end;

 if fn = '' then
 begin
  Result := DRIVE_UNKNOWN;
 end
 else
 begin
 {$I-}
  if fn[1] = 'h' then AssignFile(f, '/proc/ide/' + fn + '/media');
  Reset(f);
  media := '';
  if IoResult=0 then ReadLn(f, media)
  else
  Exit;
 {$I+}

  if media = 'disk' then Result := DRIVE_FIXED;
  if media = 'cdrom' then Result := DRIVE_CDROM;
  if media = 'floppy' then Result := DRIVE_REMOVABLE;

  CloseFile(f);
 end;
end;

function HiWord(I: DWORD):Word;
begin
 Result := I shl 16;
 Result := I and $FFFF;
end;

function CoCreateGuid(out guid: TGUID): HResult;
begin
  Result := CreateGuid(Guid);
end;

{$IFNDEF FPC}
// from MMSystem.pas
function timeGetTime: DWord;
var
  iFileHandle : Integer;
  iFileLength : Integer;
  iBytesRead : Integer;
  Buffer : PChar;
  sSeconds : String;
  iSeconds : LongInt;
  i64Seconds : Int64;
begin
 iSeconds := -1;
 // returns the milliseconds since the machine was restarted
 // will wrap around to 0 every 2^32 milliseconds (49.7 days)

 // read the uptime from /proc/uptime
 try
  iFileHandle := FileOpen('/proc/uptime', fmOpenRead or fmShareDenyNone);
  iFileLength := FileSeek(iFileHandle,0,2);
  FileSeek(iFileHandle,0,0);
  Buffer := PChar(AllocMem(iFileLength + 1));
  iBytesRead := FileRead(iFileHandle, Buffer^, iFileLength);
  FileClose(iFileHandle);
  // /proc/uptime has 2 values, we want the first one
  sSeconds := StrPas(Buffer);
  if Pos(' ', sSeconds) > 0 then
  begin
   sSeconds := LeftStr(sSeconds, Pos(' ', sSeconds));
  end;
  try
   i64Seconds := Trunc((StrToFloat(sSeconds) * 1000));
   Result := iSeconds;
  finally
   iSeconds := 0;
  end;
 finally
  FreeMem(Buffer);
 end;
 if iSeconds = -1 then Result := 0 else Result := iSeconds;
end;
{$ELSE}
function timeGetTime: Cardinal;
begin
 Result := Cardinal(Trunc(Now * 24 * 60 * 60 * 1000));
end;
{$ENDIF}
{$ENDIF}

{$IFDEF FPC}
{$IFDEF FreeBSD}
function GetDriveType(drive: Integer): Integer;
begin

end;

function HiWord(I: DWORD): Word;
begin
  Result := I shl 16;
  Result := I and $FFFF;
end;

function CoCreateGuid(out guid: TGUID): HResult;
begin
  Result := CreateGuid(Guid);
end;

function timeGetTime: Cardinal;
begin
  Result := Cardinal(Trunc(Now * 24 * 60 * 60 * 1000));
end;
{$ENDIF FreeBSD}
{$ENDIF}

{$IFNDEF NoOgSrMgr}
procedure FreeStrRes; far;
begin
  StrRes.Free;
  StrRes := nil;
end;
{$ENDIF}

initialization
  {$IFNDEF NoOgSrMgr}
  StrRes := TOgStringResource.Create(HInstance, 'ONGUARD_STRINGS_ENGLISH');  {!!.08}
  {$ENDIF}
  {record our baseline date}
  //BaseDate := Trunc(EncodeDate(1996, 1, 1));

{$IFNDEF NoOgSrMgr}
finalization
{$IFDEF Win32} FreeStrRes; {$ENDIF}
{$IFDEF Win16} AddExitProc(FreeStrRes); {$ENDIF}
{$IFDEF KYLIX} FreeStrRes;{$ENDIF}

{$ENDIF}


end.
