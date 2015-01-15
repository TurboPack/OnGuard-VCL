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
{*                  ONGUARD5.PAS 1.13                    *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}


unit qonguard5;                                                     {AH.01}

interface

uses
  Controls,                                                       {AH.01}
  Forms,                                                          {AH.01}
  onguard,                                                         {AH.01}
  ComponentEditors,
  PropEdits,
  LazarusPackageIntf,
  LResources;


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
  ogconst,                                                         {AH.01}
  ogutil,                                                          {AH.01}
  qonguard2;                                                       {AH.01}

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
      ShowHint := True;
      KeyFileName := OgKeyFile;
      if ShowModal = mrOK then begin
        Work := Code;
        SetValue(BufferToHex(Work, SizeOf(Work)));
      end;
    finally
      Free;
    end;
end;


end.
