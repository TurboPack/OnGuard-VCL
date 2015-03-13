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

unit ogfileFmx;


interface

uses
  {$IFDEF MSWINDOWS} Winapi.Windows, {$ENDIF}
  {$IFDEF MACOS}Posix.Base, Posix.SysStat, Posix.Fcntl, Posix.Stdio, {$ENDIF}
  System.SysUtils,
  OgUtilFmx;


function GetFileSize(Handle : THandle) : Cardinal;

{$IFDEF ANDROID}
function FlushFileBuffers(Handle : THandle) : Boolean;
function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
{$ENDIF}

{$IFDEF MACOS}
function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
function FlushFileBuffers(Handle : THandle) : Boolean;
{$ENDIF}

implementation

uses
  System.Classes;

{$REGION 'MSWINDOWS'}
{$IFDEF MSWINDOWS}
function GetFileSize(Handle : THandle) : Cardinal;
begin
  Result := Winapi.Windows.GetFileSize(Handle, nil);
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'ANDROID'}
{$IFDEF ANDROID}
function GetFileSize(Handle : THandle) : Cardinal;
var
  pStream: THandleStream;
begin
  pStream := THandleStream.Create(Handle);
  try
    Result := pStream.Size;
  finally
    pStream.Free;
  end;
end;

function FlushFileBuffers(Handle : THandle) : Boolean;
begin
  Result := True;
end;

function LockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                  LockCountLow, LockCountHigh : Word) : Boolean;
begin
  //Needs to be implemented
  Result := False;
end;

function UnlockFile(Handle : THandle; FileOffsetLow, FileOffsetHigh,
                    UnLockCountLow, UnLockCountHigh : Word) : Boolean;
begin
  //Needs to be implemented
  Result := False;
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'OSX'}
{$IFDEF MACOS}
function GetFileSize(Handle : THandle) : Cardinal;
var
  stat: _stat;
begin
  Result := 0;
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

  Result := fcntl(Handle, F_SETLK, LockVar) = 0;
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
{$ENDREGION}

end.
