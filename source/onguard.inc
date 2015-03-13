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
{*                  ONGUARD.INC 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


{ target platforms
{
{ MSWINDOWS       any Windows platform
{ WIN32           32bit Windows
{ WIN64           64bit Windows
{
{ ANDROID         any Android platform
{ MACOS           any Mac OS platform
{ IOS             any iOS platform
{ POSIX           any POSIX compliant platform
{
{ processor targets
{
{ CPUX86          Intel x86 processor or compatible
{ CPUX64          Intel x64 processor or compatible (not IA64)
{ CPUARM          Arm v7 processor or compatible
{
{----------------------------------------------------------------------------}
{
{ library specific defines
{
{ NoOnGuardExceptions   disable the use of exceptions.
{ NoMakeKeysSupport     prevent the TOgMakeKeys Form being compiled into the exe.
{ NoMakeCodesSupport    prevent the TOgMakeCodes Form being compiled into the exe.
{ UseOgFMX              use Firemonkey
{----------------------------------------------------------------------------}

{$IFDEF MACOS}
  {.$DEFINE NoMakeCodesSupport}  //temporary
  {.$DEFINE NoMakeKeysSupport}   //temporary
  {$IFNDEF CONSOLE}{$DEFINE UseOgFMX}{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
  {.$DEFINE NoMakeCodesSupport}  //temporary
  {.$DEFINE NoMakeKeysSupport}   //temporary
  {$IFNDEF CONSOLE}{$DEFINE UseOgFMX}{$ENDIF}
{$ENDIF}

{====General defines=================================================}

{!!.10}
{Activate the following define to prevent the TOgMakeCodes Form being
 compiled into the exe. }

{.$DEFINE NoMakeCodesSupport}


{!!.10}
{Activate the following define to prevent the TOgMakeKeys Form being
 compiled into the exe. }

{.$DEFINE NoMakeKeysSupport}

{!!.15}
{Activate the following define to disable the use of exceptions. }

{$DEFINE NoOnGuardExceptions}

{!!.15}
{Activate the following define to enable an Unlimited Usage code}
{.$DEFINE OgUsageUnlimited}

