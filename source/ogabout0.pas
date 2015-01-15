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
{*                  OGABOUT0.PAS 1.15                    *}
{*      Copyright (c) 1997-00 TurboPower Software Co     *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogabout0;

interface

uses
  {$IFDEF Win16} WinTypes, WinProcs, {$ENDIF}
  {$IFDEF Win32} Windows, {$ENDIF}
  {$IFDEF MSWINDOWS}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShellAPI,
  {$ENDIF}
  {$IFDEF UseOgFMX}
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Objects,
  FMX.ExtCtrls, FMX.Platform, Fmx.StdCtrls, FMX.Header, FMX.Graphics,
  {$ENDIF}
  OgUtil,
{$IFDEF DELPHI6UP}                                                      {!!.13}
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
    {$IFNDEF UseOgFMX}
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
    {$ENDIF}
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

{$IFDEF MSWINDOWS}{$R *.DFM}{$ENDIF}
{$IFDEF UseOgFMX}{$R *.fmx}{$ENDIF}


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
  {$IFNDEF UseOgFMX}
  lblVersion.Caption := 'Version ' + OgVersionStr;
  {$ELSE}
  lblVersion.Text := 'Version ' + OgVersionStr;
  {$ENDIF}
end;

{$IFNDEF UseOgFMX}
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
  if ShellExecute(0, 'open', 'http://sourceforge.net/projects/tponguard',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start web browser');
  WebLbl.Font.Color := clNavy;
end;

procedure TOgAboutForm.NewsLblClick(Sender: TObject);
begin
  if ShellExecute(0, 'open', 'https://sourceforge.net/forum/?group_id=71010',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start news reader');
  NewsLbl.Font.Color := clNavy;
end;
{$ENDIF}

end.
