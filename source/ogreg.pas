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
{*                   OGREG.PAS 1.15                      *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogregFmx;

{$R ogreg.r32}

interface

procedure Register;

implementation

uses
  System.Classes, Fmx.Forms, ogabout0Fmx, ogfileFmx, ognetwrkFmx, ogproexeFmx, ogfirstFmx,
  onguardFmx, OnGuard2Fmx, OnGuard3Fmx, OnGuard5Fmx, OnGuard6Fmx, OnGuard7Fmx, ogutilFmx,
  DesignIntf, DesignEditors;

const
  {ini file name used to store application keys}
  OgKeyFile    = 'ONGUARD.INI';

type
  {component editor for TOgCodeBaseFmx components}
  TOgCodeGenEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index : Integer);
      override;
    function GetVerb(Index : Integer) : string;
      override;
    function GetVerbCount : Integer;
      override;
  end;


{*** TOgCodeGenEditor ***}

procedure TOgCodeGenEditor.ExecuteVerb(Index : Integer);
begin
  if Index = 0 then begin
    with TCodeGenerateFrm.Create(Application) do
      try
        KeyFileName := OgKeyFile;
        if Component is TOgDateCodeFmx then
          CodeType := ctDate
        else if Component is TOgDaysCodeFmx then
          CodeType := ctDays
        else if Component is TOgNetCodeFmx then
          CodeType := ctNetwork
        else if Component is TOgRegistrationCodeFmx then
          CodeType := ctRegistration
        else if Component is TOgSerialNumberCodeFmx then
          CodeType := ctSerialNumber
        else if Component is TOgSpecialCodeFmx then
          CodeType := ctSpecial
        else if Component is TOgUsageCodeFmx then
          CodeType := ctUsage;
        ShowModal;
      finally
        Free;
      end;
  end else if Index = 1 then begin
    with TKeyMaintFrm.Create(Application) do
      try
        KeyFileName := 'ONGUARD.INI';
        KeyType := ktRandom;
        ShowModal;
      finally
        Free;
      end;
  end;
end;

function TOgCodeGenEditor.GetVerb(Index : Integer) : string;
begin
  case Index of
    0 : Result := 'Generate Code';
    1 : Result := 'Generate Key';
  else
    Result := '?';
  end;
end;

function TOgCodeGenEditor.GetVerbCount : Integer;
begin
  Result := 2;
end;


{component registration}
procedure Register;
begin
  RegisterComponentEditor(TOgCodeBaseFmx, TOgCodeGenEditor);

  RegisterPropertyEditor(
    TypeInfo(string), TOgMakeKeysFmx, 'KeyFileName', TOgFileNameProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOgMakeCodesFmx, 'KeyFileName', TOgFileNameProperty);
{  RegisterPropertyEditor( }                                          {!!.09}
{    TypeInfo(string), TOgCodeBaseFmx, 'Expires', TOgExpiresProperty);}  {!!.09}
  RegisterPropertyEditor(
    TypeInfo(string), TOgCodeBaseFmx, 'Code', TOgCodeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOgCodeBaseFmx, 'Modifier', TOgModifierProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOgCodeBaseFmx, 'About', TOgAboutProperty);       {!!.08}
  RegisterPropertyEditor(
    TypeInfo(string), TOgProtectExeFmx, 'About', TOgAboutProperty);     {!!.08}
  RegisterPropertyEditor(
    TypeInfo(string), TOgMakeCodesFmx, 'About', TOgAboutProperty);      {!!.08}
  RegisterPropertyEditor(
    TypeInfo(string), TOgMakeKeysFmx, 'About', TOgAboutProperty);       {!!.08}

  RegisterComponents('OnGuardFmx', [
    TOgMakeKeysFmx,
    TOgMakeCodesFmx,
    TOgDateCodeFmx,
    TOgDaysCodeFmx,
    TOgNetCodeFmx,
    TOgRegistrationCodeFmx,
    TOgSerialNumberCodeFmx,
    TOgSpecialCodeFmx,
    TOgUsageCodeFmx,
    TOgProtectExeFmx]);
end;

end.