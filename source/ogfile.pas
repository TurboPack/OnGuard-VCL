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
{*                   OGFILE.PAS 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogfile;


interface

uses
  {$IFDEF Win16} WinTypes, WinProcs, {$ENDIF}
  {$IFDEF Win32} Windows, {$ENDIF}
  {$IFDEF KYLIX} Libc, {$ENDIF}                                    {AH.01}
  {$IFDEF FPC}{$IFDEF UNIX} BaseUnix, {$ENDIF}{$ENDIF}			       {BB.01}
  {$IFDEF UsingCLX} Types, {$ENDIF}                                {AH.01}
  {$IFDEF MACOS}Posix.Base, Posix.SysStat, Posix.Fcntl, Posix.Stdio, {$ENDIF}
  SysUtils,
  OgUtil;


function GetFileSize(Handle : THandle) : Cardinal;

{$IFDEF Win16}
function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
function FlushFileBuffers(Handle : THandle) : Boolean;
{$ENDIF}
{$IFDEF KYLIX}
function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
function FlushFileBuffers(Handle : THandle) : Boolean;
{$ENDIF}
{$IFDEF FPC}
{$IFNDEF MSWINDOWS}
function LockFile(hFile: THandle; dwFileOffsetLow, dwFileOffsetHigh: DWORD; nNumberOfBytesToLockLow, nNumberOfBytesToLockHigh: DWORD): Boolean;
function UnlockFile(hFile: THandle; dwFileOffsetLow, dwFileOffsetHigh: DWORD; nNumberOfBytesToUnlockLow, nNumberOfBytesToUnlockHigh: DWORD): Boolean;
function FlushFileBuffers(Handle : THandle) : Boolean;
{$ENDIF}
{$ENDIF}

{$IFDEF DELPHI}
{$IFDEF MACOS}
function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
function FlushFileBuffers(Handle : THandle) : Boolean;
{$ENDIF}
{$ENDIF}


implementation


{$REGION 'Win32'}
{$IFDEF Win32}
function GetFileSize(Handle : THandle) : Cardinal;
begin
  Result := Windows.GetFileSize(Handle, nil);
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'Win64'}
{$IFDEF Win64}
function GetFileSize(Handle : THandle) : Cardinal;
begin
  Result := Windows.GetFileSize(Handle, nil);
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'Win16'}
{$IFDEF Win16}
function GetFileSize(Handle : THandle) : Cardinal;
var
  Save : LongInt;
begin
  Save := FileSeek(Handle, 0, 0);     {save current file position}
  Result := FileSeek(Handle, 0, 2);   {get file size}
  FileSeek(Handle, Save, 0);          {restore previous position}
end;

function LockFile(Handle : THandle;
                  FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
var
  Error : Word;
begin
  asm
    mov   ax,$5C00
    mov   bx,Handle
    mov   cx,FileOffsetHigh
    mov   dx,FileOffsetLow
    mov   si,LockCountHigh
    mov   di,LockCountLow
    int   $21
    jc    @@001
    xor   ax,ax
  @@001:
    mov   Error,ax
  end;
  Result := Error = 0;
end;

function UnlockFile(Handle : THandle;
                    FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
var
  Error : Word;
begin
  asm
    mov   ax, $5C01
    mov   bx,Handle
    mov   cx,FileOffsetHigh
    mov   dx,FileOffsetLow
    mov   si,UnLockCountHigh
    mov   di,UnLockCountLow
    int   $21
    jc    @@001
    xor   ax, ax
  @@001:
    mov   Error, ax
  end;
  Result := Error = 0;
end;

function FlushFileBuffers(Handle : THandle) : Boolean;
var
  Error : Word;
begin
  asm
    mov   ah, $68
    mov   bx, Handle
    int   $21
    jc    @@001
    xor   ax, ax
  @@001:
    mov   Error, ax
  end;
  Result := Error = 0;
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'Kylix'}
{$IFDEF KYLIX}
function GetFileSize(Handle : THandle) : Cardinal;
var
  Save : LongInt;
begin
  Save := FileSeek(Handle, 0, 0);     {save current file position}
  Result := FileSeek(Handle, 0, 2);   {get file size}
  FileSeek(Handle, Save, 0);          {restore previous position}
end;

function LockFile(Handle : THandle;
                  FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
var
   LockVar : TFlock;
begin
  LockVar.l_whence := SEEK_SET;
  LockVar.l_start := FileOffSetHigh;
  LockVar.l_start := (LockVar.l_start shl 16) + FileOffSetLow;
  LockVar.l_len := LockCountHigh;
  LockVar.l_len := (LockVar.l_len shl 16) + LockCountLow;
  LockVar.l_type := F_WRLCK;

  if fcntl(Handle, F_SETLK, LockVar) = 0 then Result := True else Result := False;
end;

function UnlockFile(Handle : THandle;
                    FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
var
   LockVar : TFlock;
begin
  LockVar.l_whence := SEEK_SET;
  LockVar.l_start := FileOffSetHigh;
  LockVar.l_start := (LockVar.l_start shl 16) + FileOffSetLow;
  LockVar.l_len := UnLockCountHigh;
  LockVar.l_len := (LockVar.l_len shl 16) + UnLockCountLow;
  LockVar.l_type := F_UNLCK;

  if fcntl(Handle, F_SETLK, LockVar) = 0 then Result := True else Result := False;
end;

function FlushFileBuffers(Handle : THandle) : Boolean;
begin
  Result := True;
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'FPC'}
{$IFDEF FPC}
{$IFNDEF MSWINDOWS}

const
   F_RDLCK = 0;
   F_WRLCK = 1;
   F_UNLCK = 2;
   F_EXLCK = 4;
   F_SHLCK = 8;

   LOCK_SH = 1;
   LOCK_EX = 2;
   LOCK_NB = 4;
   LOCK_UN = 8;

   LOCK_MAND = 32;
   LOCK_READ = 64;
   LOCK_WRITE = 128;
   LOCK_RW = 192;

   EACCES = ESysEACCES;
   EAGAIN = ESysEAGAIN;

function GetLastError: Integer;
begin
  Result := FpGetErrno;
end;

procedure SetLastError(Value: Integer);
begin
  FpSetErrno(Value);
end;

function GetFileSize(Handle : THandle) : Cardinal;
var
  Save : LongInt;
begin
  Save := FileSeek(Handle, 0, 0);     {save current file position}
  Result := FileSeek(Handle, 0, 2);   {get file size}
  FileSeek(Handle, Save, 0);          {restore previous position}
end;


function LockFile(hFile: THandle; dwFileOffsetLow, dwFileOffsetHigh: DWORD; nNumberOfBytesToLockLow, nNumberOfBytesToLockHigh: DWORD): Boolean;
var
  FLockInfo: {$ifdef FPC}BaseUnix.FLock{$else}TFLock{$endif};
  FLastError: Cardinal;
begin
  Result := false;
  FLockInfo.l_type := F_WRLCK;
  FLockInfo.l_whence := SEEK_SET;
  FLockInfo.l_start := dwFileOffsetLow;
  FLockInfo.l_len := nNumberOfBytesToLockLow;
  FLockInfo.l_pid := {$ifdef FPC}fpgetpid{$else}getpid{$endif}();
  Result := {$ifdef FPC}fpfcntl{$else}fcntl{$endif}(hFile, F_SETLK, FLockInfo) <> -1;
  if not Result then
  begin
    FLastError := GetLastError();
    if (FLastError = EACCES) or (FLastError = EAGAIN) then
      SetLastError(ESysEACCES)
    else
      Result := True; // If errno is ENOLCK or EINVAL
  end;
end;

function UnlockFile(hFile: THandle; dwFileOffsetLow, dwFileOffsetHigh: DWORD; nNumberOfBytesToUnlockLow, nNumberOfBytesToUnlockHigh: DWORD): Boolean;
var
  FLockInfo: {$ifdef FPC}BaseUnix.FLock{$else}TFLock{$endif};
begin
  FLockInfo.l_type := F_UNLCK;
  FLockInfo.l_whence := SEEK_SET;
  FLockInfo.l_start := dwFileOffsetLow;
  FLockInfo.l_len := nNumberOfBytesToUnLockLow;
  FLockInfo.l_pid := {$ifdef FPC}fpgetpid{$else}getpid{$endif}();
  Result := {$ifdef FPC}fpfcntl{$else}fcntl{$endif}(hFile, F_SETLK, FLockInfo) <> -1;
end;

function FlushFileBuffers(Handle : THandle) : Boolean;
begin
  Result := True;
end;

{$ENDIF}
{$ENDIF}
{$ENDREGION}

{$REGION 'OSX'}
{$IFDEF DELPHI}
{$IFDEF MACOS}
function GetFileSize(Handle : THandle) : Cardinal;
var
  stat: _stat;
begin
  if fstat(Handle, stat) = 0 then
    Result := stat.st_size;
end;

function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
var
   LockVar : flock;
begin
  LockVar.l_whence := SEEK_SET;
  LockVar.l_start := FileOffSetHigh;
  LockVar.l_start := (LockVar.l_start shl 16) + FileOffSetLow;
  LockVar.l_len := LockCountHigh;
  LockVar.l_len := (LockVar.l_len shl 16) + LockCountLow;
  LockVar.l_type := F_WRLCK;

  if fcntl(Handle, F_SETLK, LockVar) = 0 then Result := True else Result := False;
end;

function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
var
   LockVar : flock;
begin
  LockVar.l_whence := SEEK_SET;
  LockVar.l_start := FileOffSetHigh;
  LockVar.l_start := (LockVar.l_start shl 16) + FileOffSetLow;
  LockVar.l_len := UnLockCountHigh;
  LockVar.l_len := (LockVar.l_len shl 16) + UnLockCountLow;
  LockVar.l_type := F_UNLCK;

  if fcntl(Handle, F_SETLK, LockVar) = 0 then Result := True else Result := False;
end;

function FlushFileBuffers(Handle : THandle) : Boolean;
begin
  Result := True;
end;


{$ENDIF}
{$ENDIF}
{$ENDREGION}

end.
