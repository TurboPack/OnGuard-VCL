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
{*                  ONGUARD5.PAS 1.15                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit onguard5;

interface

uses
  Fmx.Controls, Fmx.Forms, onguard, DesignIntf, DesignEditors;

type
  {property editor for ranges}
  TOgCodeProperty = class(TStringProperty)
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
  System.UITypes, ogutil, onguard2;

const
  {ini file name used to store application keys}
  OgKeyFile    = 'ONGUARD.INI';

{*** TOgCodeProperty ***}

function TOgCodeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TOgCodeProperty.GetValue : string;
begin
  Result := inherited GetValue;
end;

procedure TOgCodeProperty.Edit;
var
  Work : TCode;
begin
  with TCodeGenerateFrm.Create(Application) do
    try
      KeyFileName := OgKeyFile;
      if ShowModal = mrOK then begin
        Work := Code;
        Value := BufferToHex(Work, SizeOf(Work));
      end;
    finally
      Free;
    end;
end;


end.