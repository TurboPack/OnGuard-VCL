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
{*                  ONGUARD7.PAS 1.15                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit FMX.onguard7;
  {-File name property editor}

interface

uses
  Fmx.Dialogs, Fmx.Forms, DesignIntf, DesignEditors;


type
  {property editor for ranges}
  TOgFileNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    function GetValue : string;
      override;
    procedure Edit;
      override;
  end;


implementation

uses
  System.UITypes;

{*** TOgFileNameProperty ***}

function TOgFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TOgFileNameProperty.GetValue : string;
begin
  Result := inherited GetValue;
end;

procedure TOgFileNameProperty.Edit;
var
  D : TOpenDialog;
begin
  D := TOpenDialog.Create(Application);
  try
    D.DefaultExt := '*.ini';
    D.Filter := 'Ini Files (*.ini)|*.ini|Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
    D.FilterIndex := 0;
    D.Options := [TOpenOption.ofHideReadOnly];
    D.Title := 'Select File Name';
    D.FileName := Value;
    if D.Execute then
      Value := D.FileName;
  finally
    D.Free;
  end;
end;

end.