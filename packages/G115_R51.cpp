// ***** BEGIN LICENSE BLOCK *****
// * Version: MPL 1.1
// *
// * The contents of this file are subject to the Mozilla Public License Version
// * 1.1 (the "License"); you may not use this file except in compliance with
// * the License. You may obtain a copy of the License at
// * http://www.mozilla.org/MPL/
// *
// * Software distributed under the License is distributed on an "AS IS" basis,
// * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
// * for the specific language governing rights and limitations under the
// * License.
// *
// * The Original Code is TurboPower OnGuard
// *
// * The Initial Developer of the Original Code is
// * TurboPower Software
// *
// * Portions created by the Initial Developer are Copyright (C) 1996-2002
// * the Initial Developer. All Rights Reserved.
// *
// * Contributor(s):
// *
// * ***** END LICENSE BLOCK *****
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("G113_R51.res");
USEUNIT("..\source\OgNetWrk.pas");
USEUNIT("..\source\OgUtil.pas");
USEUNIT("..\source\OgConst.pas");
USEUNIT("..\source\onguard.pas");
USEUNIT("..\source\OnGuard1.pas");
USEUNIT("..\source\OnGuard2.pas");
USEUNIT("..\source\OnGuard3.pas");
USEUNIT("..\source\OnGuard4.pas");
USEUNIT("..\source\OgProExe.pas");
USEUNIT("..\source\OgFirst.pas");
USEUNIT("..\source\OgSrmgr.pas");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("vcl50.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------