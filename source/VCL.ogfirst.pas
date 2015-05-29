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

unit Vcl.ogfirst;
  {-limit instance routines}

interface

uses
  System.SysUtils, Winapi.Windows, Vcl.ogutil;

{detect/Activate instance routines}
type
  TogFirst = record
  private class var
    FFirstInstance : Boolean;
    FInstanceMutex : THandle;
  private
    class function GetMutexName: string; static;
  public
    class function IsFirstInstance: Boolean; static;
    class procedure ActivateFirstInstance; static;
  end;


implementation

uses
  Vcl.Forms;

{ TogFirst }

class function TogFirst.IsFirstInstance : Boolean;
begin
  Result := FFirstInstance;
end;

class procedure TogFirst.ActivateFirstInstance;
var
  ClassBuf,
  WindowBuf : array [0..255] of Char;
  Wnd,
  TopWnd    : hWnd;
  ThreadID  : DWord;                                                 {!!.07}
begin
  if IsFirstInstance then begin
    if IsIconic(Application.Handle) then
      Application.Restore
    else
      Application.BringToFront;
  end else begin
    GetClassName(Application.Handle, ClassBuf, Length(ClassBuf));
    GetWindowText(Application.Handle, WindowBuf, Length(WindowBuf));
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
end;

class function TogFirst.GetMutexName: string;
var
  WindowBuf: array [0..512] of Char;
begin
  GetWindowText(Application.Handle, WindowBuf, Length(WindowBuf));
  Result := 'PREVINST:' + WindowBuf;
end;

initialization
  TogFirst.FInstanceMutex := CreateMutex(nil, True, PChar(TogFirst.GetMutexName));
  TogFirst.FFirstInstance := (TogFirst.FInstanceMutex <> 0) and (GetLastError = 0);

finalization
  if TogFirst.FInstanceMutex <> 0 then
    CloseHandle(TogFirst.FInstanceMutex);


end.
