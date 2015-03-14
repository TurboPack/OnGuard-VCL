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
 *                       January 1, 2004                           {AH.01}
 * Boguslaw Brandys      conversion to FPC
 *                       June 14, 2006
 *
 *
 * ***** END LICENSE BLOCK ***** *)
{*********************************************************}
{*                  OGFIRST.PAS 1.15                     *}
{*     Copyright (c) 1996-02 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I onguard.inc}

unit ogfirst;
  {-limit instance routines}

interface

{detect/Activate instance routines}
type
  TogFirst = record
  public
    class function IsFirstInstance: Boolean; static;
    class procedure ActivateFirstInstance; static;
  end;


implementation

{ TogFirst }

class function TogFirst.IsFirstInstance : Boolean;
begin
  Result := True;
end;

class procedure TogFirst.ActivateFirstInstance;
begin
end;

end.

