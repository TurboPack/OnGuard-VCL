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
 *
 * Boguslaw Brandys      brandys@o2.pl
 *                       conversion to Free Pascal
 *                       June 04, 2006
 *
 *
 * ***** END LICENSE BLOCK ***** *)
{*********************************************************}
{*                  OGPROEXE.PAS 1.15                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit FMX.ogproexe;

interface

uses
  Winapi.Windows, System.Classes, WinApi.MMSystem, System.SysUtils,
  FMX.ogutil;

type
  {exe signature record}
  PSignatureRec = ^TSignatureRec;
  TSignatureRec = packed record
    Sig1   : DWord;                                                  {!!.07}
    Sig2   : DWord;                                                  {!!.07}
    Sig3   : DWord;                                                  {!!.07}
    Offset : DWord;                                                  {!!.07}
    Size   : DWord;                                                  {!!.07}
    CRC    : DWord;                                                  {!!.07}
    Sig4   : DWord;                                                  {!!.07}
    Sig5   : DWord;                                                  {!!.07}
    Sig6   : DWord;                                                  {!!.07}
  end;

  TExeStatus = (
    exeSuccess,             {no error}
    exeSizeError,           {the file size has changed}
    exeIntegrityError,      {CRC does not match}
    exeNotStamped,          {the exe has not been stamped}
    exeAccessDenied         {share violation}                          {!!.05}
  );

type
  TCheckedExeEvent =
    procedure(Sender : TObject; Status : TExeStatus)
    of object;

  TOgProtectExe = class(TComponent)
  protected {private}
    {property variables}
    FAutoCheck  : Boolean;
    FCheckSize  : Boolean;

    {event variables}
    FOnChecked  : TCheckedExeEvent;

    {property methods}
    function GetAbout : string;                                      {!!.08}
    procedure SetAbout(const AValue : string);                        {!!.08}

  protected
    procedure DoOnChecked(Status : TExeStatus);
      dynamic;
    procedure Loaded;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    function CheckExe(Report : Boolean) : TExeStatus;
      {-test the exe file for tampering}
    function StampExe(const FileName : string ;  EraseMarker : Boolean) : Boolean;
      {-stamp exe with crc and file size. optionally erase search markers}
    function UnStampExe(const FileName : string) : Boolean;
      {-writes uninitialized signature record. marker must not have been erased}

  published
    {properties}
    property AutoCheck : Boolean
      read FAutoCheck
      write FAutoCheck
      default DefAutoCheck;

    property CheckSize : Boolean
      read FCheckSize
      write FCheckSize
      default DefCheckSize;

    property About : string                                          {!!.08}
      read GetAbout                                                  {!!.08}
      write SetAbout                                                 {!!.08}
      stored False;

    {events}
    property OnChecked : TCheckedExeEvent
      read FOnChecked
      write FOnChecked;
  end;


function IsExeTampered(CheckSize : Boolean) : TExeStatus;
  {-return one of the possible TExeResult states}
function ProtectExe(const FileName : string ;  EraseMarker : Boolean) : Boolean;
  {-stamp exe with crc and file size. optionally erase search markers}
function UnprotectExe(const FileName : string) : Boolean;
  {-writes uninitialized signature record. marker must not have been erased}

{checksum/CRC routines}
procedure UpdateChecksum(var Sum : Integer;  const Buf;  BufSize : Integer);
function FileCRC32(const FileName : string) : DWord;                     {!!.07}
procedure UpdateCRC32(var CRC : DWord;  const Buf;  BufSize : Integer);  {!!.07}


implementation


{signature = '!~~@CRC32@~~' used before and after}
const
  StoredSignature : TSignatureRec = (
    Sig1:$407E7E21;  Sig2:$33435243;  Sig3:$7E7E4032;
    Offset:1;  Size:2;  CRC:3;
    Sig4:$407E7E21;  Sig5:$33435243;  Sig6:$7E7E4032);

{CRC32 lookup table}
const
  CRC32Table: array[0..255] of DWord = (                             {!!.07}
    $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f, $e963a535, $9e6495a3,
    $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988, $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,
    $1db71064, $6ab020f2, $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
    $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9, $fa0f3d63, $8d080df5,
    $3b6e20c8, $4c69105e, $d56041e4, $a2677172, $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
    $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
    $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
    $2802b89e, $5f058808, $c60cd9b2, $b10be924, $2f6f7c87, $58684c11, $c1611dab, $b6662d3d,
    $76dc4190, $01db7106, $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
    $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,
    $6b6b51f4, $1c6c6162, $856530d8, $f262004e, $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
    $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
    $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
    $4369e96a, $346ed9fc, $ad678846, $da60b8d0, $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,
    $5005713c, $270241aa, $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
    $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,
    $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a, $ead54739, $9dd277af, $04db2615, $73dc1683,
    $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
    $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb, $196c3671, $6e6b06e7,
    $fed41b76, $89d32be0, $10da7a5a, $67dd4acc, $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,
    $d6d6a3e8, $a1d1937e, $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
    $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55, $316e8eef, $4669be79,
    $cb61b38c, $bc66831a, $256fd2a0, $5268e236, $cc0c7795, $bb0b4703, $220216b9, $5505262f,
    $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
    $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f, $72076785, $05005713,
    $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38, $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,
    $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
    $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69, $616bffd3, $166ccf45,
    $a00ae278, $d70dd2ee, $4e048354, $3903b3c2, $a7672661, $d06016f7, $4969474d, $3e6e77db,
    $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
    $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693, $54de5729, $23d967bf,
    $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94, $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d);


{*** TOgProtectExe ***}

constructor TOgProtectExe.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FAutoCheck := DefAutoCheck;
  FCheckSize := DefCheckSize;
end;

function TOgProtectExe.CheckExe(Report : Boolean) : TExeStatus;
begin
  Result := IsExeTampered(FCheckSize);

  if Report then
    DoOnChecked(Result);
end;

procedure TOgProtectExe.DoOnChecked(Status : TExeStatus);
begin
  if Assigned(FOnChecked) then
    FOnChecked(Self, Status);
end;

function TOgProtectExe.GetAbout : string;                            {!!.08}
begin
  Result := OgVersionStr;
end;

procedure TOgProtectExe.Loaded;
begin
  inherited Loaded;

  if FAutoCheck then
    CheckExe(True);
end;

procedure TOgProtectExe.SetAbout(const AValue : string);              {!!.08}
begin
  // do nothing
end;

function TOgProtectExe.StampExe(const FileName : string ;  EraseMarker : Boolean) : Boolean;
begin
  Result := ProtectExe(FileName,  EraseMarker);
end;

function TOgProtectExe.UnStampExe(const FileName : string) : Boolean;
begin
  Result := UnprotectExe(FileName);
end;

function IsExeTampered(CheckSize : Boolean) : TExeStatus;
  {-return one of the possible TExeResult states}
var
  Fh      : THandle;
  FileMap : THandle;
  Memory  : PByteArray;
  CRC     : DWord;                                                   {!!.07}
  Buf     : array [0..MAX_PATH - 1] of Char;
begin
  Result := exeIntegrityError;

  {check if exe has been stamped}
  if (StoredSignature.Offset = 1) and (StoredSignature.Size = 2) and
     (StoredSignature.CRC = 3) then begin
    Result := exeNotStamped;
    Exit;
  end;

  Winapi.Windows.GetModuleFileName(HInstance, Buf, SizeOf(Buf));
  Fh := CreateFile(Buf, GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (Fh <> INVALID_HANDLE_VALUE) then begin                         {!!.07}
    if CheckSize and (StoredSignature.Size <> Winapi.Windows.GetFileSize(Fh, nil)) then
      Result := exeSizeError
    else begin
      FileMap := CreateFileMapping(Fh, nil, PAGE_READONLY, 0, 0, nil);
      if (FileMap <> 0) then begin
        Memory := MapViewOfFile(FileMap, FILE_MAP_READ, 0, 0, 0);
        if (Memory <> nil) then begin
          CRC := $FFF00FFF;  {special CRC init}
          UpdateCRC32(CRC, Memory^, StoredSignature.Offset);
          UpdateCRC32(CRC, Memory^[StoredSignature.Offset + SizeOf(TSignatureRec)],
           StoredSignature.Size - (StoredSignature.Offset + SizeOf(TSignatureRec)));
          if (StoredSignature.CRC = not CRC) then
            Result := exeSuccess;
          UnmapViewOfFile(Memory);
        end;
        CloseHandle(FileMap);
      end;
    end;
    CloseHandle(Fh);
  end else begin                                                       {!!.05}
    if GetLastError = ERROR_ACCESS_DENIED then                         {!!.05}
      Result := exeAccessDenied;                                       {!!.05}
  end;                                                                 {!!.05}
end;

function ProtectExe(const FileName : string;  EraseMarker : Boolean) : Boolean;
  {-stamp exe with crc and file size. optionally erase search markers}
var
  Fh      : THandle;
  FileMap : THandle;
  Memory  : PByteArray;
  I, Size : Integer;
  Sig     : PSignatureRec;
begin
  Result := False;

  Fh := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (Fh <> INVALID_HANDLE_VALUE) then begin
    Size := Winapi.Windows.GetFileSize(Fh, nil);

    FileMap := CreateFileMapping(Fh, nil, PAGE_READWRITE, 0, 0, nil);
    if (FileMap <> 0) then begin
      Memory := MapViewOfFile(FileMap, FILE_MAP_WRITE, 0, 0, 0);
      if (Memory <> nil) then begin
        for I := 0 to (Size - SizeOf(TSignatureRec)) - 1 do begin
          if (PSignatureRec(@Memory[I])^.Sig1 = $407E7E21) and
             (PSignatureRec(@Memory[I])^.Sig2 = $33435243) and
             (PSignatureRec(@Memory[I])^.Sig3 = $7E7E4032) and
             (PSignatureRec(@Memory[I])^.Sig4 = $407E7E21) and
             (PSignatureRec(@Memory[I])^.Sig5 = $33435243) and
             (PSignatureRec(@Memory[I])^.Sig6 = $7E7E4032) then begin
            {found it}
            Sig := @Memory^[I];

            if EraseMarker then begin
              Sig.Sig1 := Sig.Sig1 xor timeGetTime;
              Sig.Sig2 := Sig.Sig2 xor timeGetTime;
              Sig.Sig3 := Sig.Sig3 xor timeGetTime;
              Sig.Sig4 := Sig.Sig4 xor timeGetTime;
              Sig.Sig5 := Sig.Sig5 xor timeGetTime;
              Sig.Sig6 := Sig.Sig6 xor timeGetTime;
            end;

            Sig.Offset := I;
            Sig.Size := Size;
            Sig.CRC := $FFF00FFF;  {special CRC init}

            {compute crc ignoring the signature record}
            UpdateCRC32(Sig.CRC, Memory^, Sig.Offset);
            UpdateCRC32(Sig.CRC, Memory^[Sig.Offset + SizeOf(TSignatureRec)],
              Sig.Size - (Sig.Offset + SizeOf(TSignatureRec)));
            Sig.CRC := not Sig.CRC;

            Result := True;
            Break;
          end;
        end;
        UnmapViewOfFile(Memory);
      end;
      CloseHandle(FileMap);
    end;
    CloseHandle(Fh);
  end;
end;

function UnprotectExe(const FileName : string) : Boolean;
  {-writes uninitialized signature record. marker must not have been erased}
var
  Fh      : THandle;
  FileMap : THandle;
  Memory  : PByteArray;
  I, Size : Integer;
  Sig     : PSignatureRec;
begin
  Result := False;

  Fh := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (Fh <> INVALID_HANDLE_VALUE) then begin
    Size := Winapi.Windows.GetFileSize(Fh, nil);

    FileMap := CreateFileMapping(Fh, nil, PAGE_READWRITE, 0, 0, nil);
    if (FileMap <> 0) then begin
      Memory := MapViewOfFile(FileMap, FILE_MAP_WRITE, 0, 0, 0);
      if (Memory <> nil) then begin
        for I := 0 to (Size - SizeOf(TSignatureRec)) - 1 do begin
          if (PSignatureRec(@Memory[I])^.Sig1 = $407E7E21) and
             (PSignatureRec(@Memory[I])^.Sig2 = $33435243) and
             (PSignatureRec(@Memory[I])^.Sig3 = $7E7E4032) and
             (PSignatureRec(@Memory[I])^.Sig4 = $407E7E21) and
             (PSignatureRec(@Memory[I])^.Sig5 = $33435243) and
             (PSignatureRec(@Memory[I])^.Sig6 = $7E7E4032) then begin
            {found it}
            Sig := @Memory^[I];

            {restore to uninitialized state}
            Sig.Offset := 1;                                         {!!.08}
            Sig.Size := 2;                                           {!!.08}
            Sig.CRC := 3;                                            {!!.08}
            Result := True;
            Break;
          end;
        end;
        UnmapViewOfFile(Memory);
      end;
      CloseHandle(FileMap);
    end;
    CloseHandle(Fh);
  end;
end;

{checksum/CRC routines}

procedure UpdateChecksum(var Sum : Integer;  const Buf;  BufSize : Integer);
var
  Bytes : TByteArray absolute Buf;
  I     : Integer;
begin
  for I := 0 to BufSize - 1 do
    Sum := Sum + Bytes[I];
end;

{$IFDEF Win32}
function FileCRC32(const FileName : string) : DWord;                 {!!.07}
var
  Fh      : THandle;
  FileMap : THandle;
  Size    : Integer;
  Memory  : PByteArray;
  Buf     : array [0..MAX_PATH - 1] of Char;
begin
  Result := $FFFFFFFF;                                               {!!.07}
  StrPLCopy(Buf, FileName, SizeOf(Buf)-1);
  Fh := CreateFile(Buf, GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (Fh <> INVALID_HANDLE_VALUE) then begin                         {!!.07}
    Size := Winapi.Windows.GetFileSize(Fh, nil);
    FileMap := CreateFileMapping(Fh, nil, PAGE_READONLY, 0, 0, nil);
    if (FileMap <> 0) then begin
      Memory := MapViewOfFile(FileMap, FILE_MAP_READ, 0, 0, 0);
      if (Memory <> nil) then begin
        Result := $FFF00FFF;  {special CRC init}
        UpdateCRC32(Result, Memory^, Size);
        UnmapViewOfFile(Memory);
      end;
      CloseHandle(FileMap);
    end;
    CloseHandle(Fh);
  end;
end;
{$ELSE}
function FileCRC32(const FileName : string) : Integer;
const
  BufSize = 4096;
var
  Fh        : Integer;
  BytesRead : Integer;
  Buf       : PAnsiChar;
begin
  Buf := StrAlloc(BufSize);
  try
    StrPLCopy(Buf, FileName, BufSize-1);
    Fh := FileOpen(StrPas(Buf), fmOpenRead or fmShareDenyWrite);
    if (Fh >= 0 {HFILE_ERROR}) then begin
      Result := $FFF00FFF;  {special CRC init}
      repeat
        BytesRead := FileRead(Fh, Buf^, BufSize);
        UpdateCRC32(Result, Buf^, BytesRead);
      until (BytesRead < BufSize);
      FileClose(Fh);
    end;
  finally
    StrDispose(Buf);
  end;
end;
{$ENDIF}

procedure UpdateCRC32(var CRC : DWord;  const Buf;  BufSize : Integer); {!!.07}
var
  Bytes : TByteArray absolute Buf;
  I     : Integer;
  B     : Byte;
begin
  for I := 0 to BufSize - 1 do begin
    B := TIntegerRec(CRC).LoLo xor Bytes[I];
    CRC := (CRC shr 8) xor CRC32Table[B];
  end;
end;

end.
