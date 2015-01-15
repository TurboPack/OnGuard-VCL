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
{*                  OGABOUT0.PAS 1.13                    *}
{*      Copyright (c) 1997-00 TurboPower Software Co     *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
  {$G+} {286 Instructions}
  {$N+} {Numeric Coprocessor}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit qogabout0;                                                     {AH.01}

interface

uses
  {$IFDEF MSWINDOWS} Windows, {$ENDIF}                             {AH.01}
  {$IFDEF LINUX} Libc, {$ENDIF}                                    {AH.01}
  {$IFDEF UsingCLX} Types, {$ENDIF}                                {AH.01}
  {$IFDEF MSWINDOWS} Messages, {$ENDIF}                            {AH.01}
  SysUtils, Classes,
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  ogutil,
  {$IFDEF MSWINDOWS} ShellAPI, {$ENDIF}                            {AH.01}
{$IFDEF VERSION6}                                                      {!!.13}
  DesignIntf,
  DesignEditors;
{$ELSE}
  dsgnintf;
{$ENDIF}


type
  TOgAboutForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    lblVersion: TLabel;
    btnOK: TButton;
    WebLbl: TLabel;
    NewsLbl: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebLblMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure NewsLblMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WebLblClick(Sender: TObject);
    procedure NewsLblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TOgAboutProperty = class(TStringProperty)                          {!!.08}
  public
    function GetAttributes: TPropertyAttributes;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.xfm}


{*** TOgVersionProperty ***}

function TOgAboutProperty.GetAttributes: TPropertyAttributes;        {!!.08}
begin
  Result := [paDialog, paReadOnly];
end;

procedure TOgAboutProperty.Edit;                                     {!!.08}
begin
  with TOgAboutForm.Create(Application) do begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;


{*** TEsAboutForm ***}

procedure TOgAboutForm.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TOgAboutForm.FormCreate(Sender: TObject);
begin
  Top := (Screen.Height - Height) div 3;
  Left := (Screen.Width - Width) div 2;
  lblVersion.Caption := 'Version ' + OgVersionStr;
end;

procedure TOgAboutForm.WebLblMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  WebLbl.Font.Color := clRed;
end;

procedure TOgAboutForm.NewsLblMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  NewsLbl.Font.Color := clRed;
end;

procedure TOgAboutForm.Panel2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  NewsLbl.Font.Color := clNavy;
end;

procedure TOgAboutForm.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  WebLbl.Font.Color := clNavy;
  NewsLbl.Font.Color := clNavy;
end;

procedure TOgAboutForm.WebLblClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  if ShellExecute(0, 'open', 'http://sourceforge.net/projects/tponguard',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start web browser');
{$ELSE}
  ShowMessage('Unable to start web browser');
{$ENDIF}
  WebLbl.Font.Color := clNavy;
end;

procedure TOgAboutForm.NewsLblClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  if ShellExecute(0, 'open', 'https://sourceforge.net/forum/?group_id=71010',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start news reader');
{$ELSE}
  ShowMessage('Unable to start news reader');
{$ENDIF}
  NewsLbl.Font.Color := clNavy;
end;

end.
