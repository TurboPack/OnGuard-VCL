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

unit FMX.ogabout0;

interface

uses
  FMX.ogutil, DesignIntf, DesignEditors, FMX.Objects, FMX.Types, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Classes, FMX.Controls, FMX.Forms;


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
      Y: Single);
    procedure NewsLblMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure WebLblClick(Sender: TObject);
    procedure NewsLblClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
  end;

  TOgAboutProperty = class(TStringProperty)                          {!!.08}
  public
    function GetAttributes: TPropertyAttributes;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.fmx}

uses
  System.UITypes, Winapi.Windows, Winapi.ShellAPI, Fmx.Dialogs;

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
  lblVersion.Text := 'Version ' + OgVersionStr;
end;

procedure TOgAboutForm.WebLblMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  WebLbl.FontColor := TColorRec.Red;
end;

procedure TOgAboutForm.NewsLblMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  NewsLbl.FontColor := TColorRec.Red;
end;

procedure TOgAboutForm.Panel2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  NewsLbl.FontColor := TColorRec.Navy;
end;

procedure TOgAboutForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  WebLbl.FontColor := TColorRec.Navy;
  NewsLbl.FontColor := TColorRec.Navy;
end;

procedure TOgAboutForm.WebLblClick(Sender: TObject);
begin
  if ShellExecute(0, 'open', 'https://github.com/TurboPack/OnGuard-FMX',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start web browser');
  WebLbl.FontColor := TColorRec.Navy;
end;

procedure TOgAboutForm.NewsLblClick(Sender: TObject);
begin
  if ShellExecute(0, 'open', 'https://github.com/TurboPack/OnGuard',
                  '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage('Unable to start news reader');
  NewsLbl.FontColor := TColorRec.Navy;
end;

end.
