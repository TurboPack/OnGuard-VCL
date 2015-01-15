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
{*                  OGCONST.PAS 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogconst;
  {-Resource constants}

{$IFNDEF NoOgSrMgr}
{$IFDEF Win32} {$R ogconst.r32} {$ENDIF}
{$IFDEF Win16} {$R ogconst.r16} {$ENDIF}
{$IFDEF LINUX} {$R ogconst.r32} {$ENDIF}
{$ENDIF}
interface

{$IFDEF NoOgSrMgr}
resourcestring
  SCNoOnCheck = '%s has no OnChecked event handler assigned';
  SCNoOnGetCode = '%s has no OnGetCode event handler assigned';
  SCNoOnGetKey = '%s has no OnGetKey event handler assigned';
  SCNoOnChangeCode = '%s has no OnChangeCode event handler assigned';
  SCDeleteQuery = 'Are you sure you want to delete this item?';
  SCInvalidStartDate = 'Invalid start date';
  SCInvalidEndDate = 'Invalid end date';
  SCInvalidKeyOrModifier = 'Invalid key or modifier';
  SCInvalidExDate = 'Invalid expiration date';
  SCNoOnGetFileName = 'FileName is empty and OnGetFileName is not assigned';
{$ENDIF}

{$I ogkeyini.inc} {get ini file name used to store application keys}

{$IFNDEF NoOgSrMgr}
{$I ogconst.inc}  {constant declarations}
{$ENDIF}

implementation

end.