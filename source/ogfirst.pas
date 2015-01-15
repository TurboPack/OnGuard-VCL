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
 *                       January 1, 2004                           {AH.01}
 * Boguslaw Brandys      conversion to FPC
 *                       June 14, 2006
 *
 *
 * ***** END LICENSE BLOCK ***** *)
{*********************************************************}
{*                  OGFIRST.PAS 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogfirst;
  {-limit instance routines}

interface

uses
  {$IFDEF Win16} WinTypes, WinProcs, OLE2, {$ENDIF}
  {$IFDEF Win32} Windows, {$ENDIF}
  {$IFDEF KYLIX} Libc, {$ENDIF}
  {$IFDEF FPC}{$IFDEF UNIX} BaseUnix, {$ENDIF} LCLProc, {$ENDIF}
  {$IFDEF UsingCLX} Types, {$IFNDEF CONSOLEAPP} QForms, QDialogs, {$ENDIF} {$ENDIF}
  {$IFDEF DELPHI} Forms, {$ENDIF}
  SysUtils,
  ogutil;

{detect/Activate instance routines}
function IsFirstInstance: Boolean;
procedure ActivateFirstInstance;
{!!.04} {revised Win16 version}


implementation


{$IFDEF MSWINDOWS}
var
  FirstInstance : Boolean;
  InstanceMutex : THandle;
{$ENDIF}

{$IFDEF LINUX}
var
  FirstInstance : Boolean;
  server_name : String;
  server_lock : Integer;
{$ENDIF}

{limit instances routines}
function IsFirstInstance : Boolean;
begin
  Result := True; // true so unsupported platforms should still work
  {$IFDEF Win16} Result := HPrevInst = 0; {$ENDIF}
  {$IFDEF Win32} Result := FirstInstance; {$ENDIF}
  {$IFDEF LINUX} Result := FirstInstance; {$ENDIF}
end;

{$REGION 'ActivateFirstInstance - Win32'}
{$IFDEF Win32}
procedure ActivateFirstInstance;
var
  ClassBuf,
  WindowBuf : array [0..255] of Char;
  Wnd,
  TopWnd    : hWnd;
  ThreadID  : DWord;                                                 {!!.07}
begin
{$IFDEF FPC}try{$ENDIF}
  if IsFirstInstance then begin
    {$IFNDEF FPC}
    if IsIconic(Application.Handle) then
      Application.Restore
	{$ELSE}
    if IsIconic(HWND(Application.MainForm.Handle)) then
      ShowWindow(HWND(Application.MainForm.Handle), SW_RESTORE)
	{$ENDIF}
    else
      Application.BringToFront;
  end else begin
    {$IFNDEF FPC}
    GetClassName(Application.Handle, ClassBuf, Length(ClassBuf));
    GetWindowText(Application.Handle, WindowBuf, Length(WindowBuf));
	{$ELSE}
    GetClassName(HWND(Application.MainForm.Handle), ClassBuf, SizeOf(ClassBuf));
    GetWindowText(HWND(Application.MainForm.Handle), WindowBuf, SizeOf(WindowBuf));
	{$ENDIF}
    Wnd := FindWindow(ClassBuf, WindowBuf);
    if (Wnd <> 0) then begin
      GetWindowThreadProcessId(Wnd, @ThreadID);
      if (ThreadID = GetCurrentProcessId) then begin
        Wnd := FindWindowEx(0, Wnd, ClassBuf, WindowBuf);
        if (Wnd <> 0) then
          if IsIconic(Wnd) then
            ShowWindow(Wnd, SW_RESTORE)
          else begin
            SetForegroundWindow(Wnd);                                {!!.09}
            TopWnd := GetLastActivePopup(Wnd);
            if (TopWnd <> 0) and (TopWnd <> Wnd) and
                IsWindowVisible(TopWnd) and IsWindowEnabled(TopWnd) then
              BringWindowToTop(TopWnd)
            else
              BringWindowToTop(Wnd);
          end;
      end;
    end;
  end;
{$IFDEF FPC}
except on E:Exception do
 DebugLn('ActivateFirstInstance exception : ' + E.Message + '.Move IsFirstInstance after CreateForm for MainForm');
end;
{$ENDIF}
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'ActivateFirstInstance - Win16'}
{$IFDEF Win16}
type
  PHWND = ^hWnd;

function EnumWndFunc(Wnd : hWnd; Target : PHWND) : Boolean; export;    {!!.07}
var
  Buf : array[0..255] of Char;
begin
  Result := True;
  if GetWindowWord(Wnd, GWW_HINSTANCE) = HPrevInst then begin
    GetClassName(Wnd, Buf, Length(Buf)-1);
    {find our application window}
    if StrIComp(Buf, 'TApplication') = 0 then begin
      Target^ := Wnd;
      Result := False;
    end;
  end;
end;

procedure ActivateFirstInstance;
var
  Wnd    : hWnd;
  TopWnd : hWnd;
begin
  if IsFirstInstance then begin
    if IsIconic(Application.Handle) then
      Application.Restore
    else
      Application.BringToFront;
  end else begin
    Wnd := 0;
    EnumWindows(@EnumWndFunc, LongInt(@Wnd));
    if Wnd <> 0 then begin
      if IsIconic(Wnd) then
        ShowWindow(Wnd, SW_RESTORE)
      else begin
        TopWnd := GetLastActivePopup(Wnd);
        if (TopWnd <> 0) and (TopWnd <> Wnd) and IsWindowVisible(TopWnd) and IsWindowEnabled(TopWnd) then begin
          ShowWindow(TopWnd, SW_SHOWNORMAL);
          SetFocus(TopWnd);
        end else begin
          ShowWindow(Wnd, SW_SHOWNORMAL);
          BringWindowToTop(Wnd);
          ShowOwnedPopups(Wnd, True);
          SetFocus(Wnd);
        end;
      end;
    end;
  end;
end;
{$ENDIF}
{$ENDREGION}


{$REGION 'ActivateFirstInstance - Other Platforms'}

{$REGION 'ActivateFirstInstance - Win64'}
{$IFDEF Win64}
procedure ActivateFirstInstance;
begin
 //[to do] Find and Activate the first instance of the application

 //look at the owner of the socket
 //look at the running processes
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'ActivateFirstInstance - LINUX'}
{$IFDEF KYLIX}
procedure ActivateFirstInstance;
begin
 //[to do] Find and Activate the first instance of the application

 //look at the owner of the socket
 //look at the running processes
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'ActivateFirstInstance - MACOS'}
{$IFDEF MACOS}
procedure ActivateFirstInstance;
begin
 //[to do] Find and Activate the first instance of the application

 //look at the owner of the socket
 //look at the running processes
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'ActivateFirstInstance - iOS'}
{$IFDEF IOS}
procedure ActivateFirstInstance;
begin
 //[to do] Find and Activate the first instance of the application

 //look at the owner of the socket
 //look at the running processes
end;
{$ENDIF}
{$ENDREGION}

{$REGION 'ActivateFirstInstance - Android'}
{$IFDEF ANDROID}
procedure ActivateFirstInstance;
begin
 //[to do] Find and Activate the first instance of the application

 //look at the owner of the socket
 //look at the running processes
end;
{$ENDIF}
{$ENDREGION}

{$ENDREGION}


{$REGION 'Initialization/Finalization blocks'}

{$REGION 'Windows'}
{$IFDEF MSWINDOWS}
{$IFNDEF Win16}
function GetMutexName : string;
var
  WindowBuf : array [0..512] of Char;
begin
{$IFNDEF FPC}
  GetWindowText(Application.Handle, WindowBuf, Length(WindowBuf));
  Result := 'PREVINST:' + WindowBuf;
{$ELSE}
try
  {GetWindowText(HWND(Application.MainForm.Handle), WindowBuf, SizeOf(WindowBuf));}
  Result := 'PREVINST:' + ExtractFileName(ParamStr(0)) + MAGIC;
except on E:Exception do
 DebugLn('GetMutexName exception : '  + E.Message);
end;
{$ENDIF}
end;

initialization
  InstanceMutex := CreateMutex(nil, True, PChar(GetMutexName));
  if (InstanceMutex <> 0) and (GetLastError = 0) then
    FirstInstance := True
  else
    FirstInstance := False;

finalization
  if (InstanceMutex <> 0) then
    CloseHandle(InstanceMutex);
{$ENDIF}
{$ENDIF}
{$ENDREGION}

{$REGION 'Kylix'}
{$IFDEF KYLIX}
initialization
  //server_lock := -1;
  server_name := '/var/run/' + ExtractFileName(Application.ExeName) + '.lock';
  server_lock := open(PChar(server_name), O_RDWR or O_CREAT or O_TRUNC or O_NOFOLLOW or O_EXCL, S_IRWXU);
  if (server_lock = -1) then
  begin
    FirstInstance := False;
    ShowMessage('Failed to create lock file. (' + IntToHex(errno,4) + ')' + #10 + server_name);
  end
  else
  begin
    FirstInstance := True;
  end;

finalization
  if (server_lock > -1) then
  begin
    FileClose(server_lock);
    unlink(PChar(server_name));
  end;
{$ENDIF}
{$ENDREGION}

{$REGION 'FPC-UNIX'}
{$IFDEF FPC}
{$IFDEF UNIX}
initialization

 server_name := ExtractFilePath(ParamStr(0)) +  ExtractFileName(ParamStr(0)) + '.lck';
 server_lock := fpopen(PChar(server_name), O_RDWR or O_CREAT or O_TRUNC or O_NOFOLLOW or O_EXCL, S_IRWXU);
 if (server_lock = -1) then
 begin
  FirstInstance := False;
  DebugLn('Failed to create lock file. (' + IntToHex(errno,4) + ')' + #10 + server_name);
 end
 else
 begin
  FirstInstance := True;
 end;

finalization
 if (server_lock > -1) then
 begin
  FileClose(server_lock);
  unlink(PChar(server_name));
 end;
{$ENDIF}
{$ENDIF}
{$ENDREGION}

{$ENDREGION}
end.
