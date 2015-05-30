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

unit Vcl.ogabout0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Winapi.ShellAPI,
  Vcl.OgUtil, DesignIntf, DesignEditors;


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
  end;

  TOgAboutProperty = class(TStringProperty)                          {!!.08}
  public
    function GetAttributes: TPropertyAttributes;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.dfm}

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
  if ShellExecute(0, 'open', 'https://github.com/TurboPack/OnGuard-VCL',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start web browser');
  WebLbl.Font.Color := clNavy;
end;

procedure TOgAboutForm.NewsLblClick(Sender: TObject);
begin
  if ShellExecute(0, 'open', 'https://github.com/TurboPack/OnGuard-VCL',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start news reader');
  NewsLbl.Font.Color := clNavy;
end;

end.
