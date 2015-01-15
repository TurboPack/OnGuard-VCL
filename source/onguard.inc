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


{----------------------------------------------------------------------------}
{ Compiler and OS version defines:
{
{ exact compiler versions:
{
{ BP7             Borland Pascal 7.0
{ DELPHI1         Delphi 1.0 (any Delphi)
{ DELPHI2         Delphi 2.0
{ DELPHI3         Delphi 3.0
{ DELPHI4         Delphi 4.0
{ DELPHI5         Delphi 5.0
{ DELPHI6         Delphi 6.0
{ DELPHI7         Delphi 7.0
{ DELPHI8         Delphi 8.0
{ DELPHI9         Delphi 2005
{ DELPHI10        Delphi 2006
{ DELPHI11        Delphi 2007
{ DELPHI12        Delphi 2009
{ DELPHI14        Delphi 2010
{ DELPHI15        Delphi XE
{ DELPHI16        Delphi XE2
{ DELPHI17        Delphi XE3
{ DELPHI18        Delphi XE4
{ DELPHI19        Delphi XE5
{ KYLIX1          Kylix 1.0
{ KYLIX2          Kylix 2.0
{ KYLIX3          Kylix 3.0
{ CBUILDER1       C++Builder 1.0
{ CBUILDER3       C++Builder 3.0
{ CBUILDER4       C++Builder 4.0
{ CBUILDER5       C++Builder 5.0
{
{
{ minimum compiler versions:
{
{ DELPHI1UP       Delphi 1.0 and above (any Delphi)
{ DELPHI2UP       Delphi 2.0 and above
{ DELPHI3UP       Delphi 3.0 and above
{ DELPHI4UP       Delphi 4.0 and above
{ DELPHI5UP       Delphi 5.0 and above
{ DELPHI6UP       Delphi 6.0 and above
{ DELPHI7UP       Delphi 7.0 and above
{ DELPHI8UP       Delphi 8.0 and above
{ DELPHI9UP       Delphi 2005 and above
{ DELPHI10UP      Delphi 2006 and above
{ DELPHI11UP      Delphi 2007 and above
{ DELPHI12UP      Delphi 2009 and above
{ DELPHI14UP      Delphi 2010 and above
{ DELPHI15UP      Delphi XE and above
{ DELPHI16UP      Delphi XE2 and above
{ DELPHI17UP      Delphi XE3 and above
{ DELPHI18UP      Delphi XE4 and above
{ DELPHI19UP      Delphi XE5 and above
{ KYLIX1UP        Kylix 1.0 and above (any Kylix)
{ KYLIX2UP        Kylix 2.0 and above (any Kylix)
{ KYLIX3UP        Kylix 3.0 and above (any Kylix)
{ CBUILDER1UP     C++Builder 1.0 and above or Delphi 2 and above (any C++Builder)
{ CBUILDER3UP     C++Builder 3.0 and above or Delphi 3.0 and above
{ CBUILDER4UP     C++Builder 4.0 and above or Delphi 4.0 and above
{ CBUILDER5UP     C++Builder 5.0 and above or Delphi 5.0 and above
{
{
{ compiler types:
{
{ BP              Borland Pascal (not Delphi or C++Builder)
{ DELPHI          any Delphi version (but not C++Builder or Kylix)
{ KYLIX           any Kylix version
{ CBUILDER        any C++Builder (Pascal)
{ FPC             any Free Pascal version
{
{
{ target platforms compiler types:
{
{ DELPHI_16BIT    16bit Delphi (but not C++Builder!)
{ DELPHI_32BIT    32bit Delphi (but not C++Builder)
{ CBUILDER_32BIT  32bit C++Builer's Pascal (but not Delphi)
{
{
{ target platforms
{
{ DOS             any DOS (plain and DPMI)
{ REALMODE        16bit realmode DOS
{ PROTECTEDMODE   16bit DPMI DOS
{ CONSOLE         console application
{
{ MSWINDOWS       any Windows platform
{ WIN16           16bit Windows
{ WIN32           32bit Windows
{ WIN64           64bit Windows
{
{ LINUX           any Linix platform
{ LINUX32         32bit Linux
{ FREEBSD         any FreeBSD platform
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
{ NoOgSrMgr             use of TurboPower String Resource Manager
{ UseOgJCL              use of JclSysInfo routines for CPU identification
{ NoOnGuardExceptions   disable the use of exceptions.
{ NoMakeKeysSupport     prevent the TOgMakeKeys Form being compiled into the exe.
{ NoMakeCodesSupport    prevent the TOgMakeCodes Form being compiled into the exe.
{ UseOgFMX              use Firemonkey
{
{
{ OgPUREPASCAL_ROLX     RolX function
{ OgPUREPASCAL_XorMem   XorMem function
{ OgPUREPASCAL_Min      Min function
{ OgPUREPASCAL_Max      Max function
{
{----------------------------------------------------------------------------}

{Conditional defines that affect compilation}


{$IFDEF VER120}      // Delphi 4.0
  {$DEFINE DELPHI}
  {$DEFINE DELPHI4}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
{$ENDIF}

{$IFDEF VER125}      // Borland C++ Builder 4.0
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE CBUILDER}
  {$DEFINE CBUILDER4}
  {$DEFINE CBUILDER1UP}
  {$DEFINE CBUILDER3UP}
  {$DEFINE CBUILDER4UP}
  {$ObjExportAll On}
  {$DEFINE BCB}
{$ENDIF}


{$IFDEF VER130}      // Delphi 5.0
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$IFNDEF BCB}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI5}
  {$ELSE}
    {$DEFINE CBUILDER}
    {$DEFINE CBUILDER5}
    {$DEFINE CBUILDER1UP}
    {$DEFINE CBUILDER3UP}
    {$DEFINE CBUILDER4UP}
    {$DEFINE CBUILDER5UP}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER140}      // Delphi 6.0
  {$DEFINE DELPHI}
  {$DEFINE DELPHI6}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$IFDEF BCB}
    {$DEFINE CBUILDER}
    {$DEFINE CBUILDER6}
    {$DEFINE CBUILDER1UP}
    {$DEFINE CBUILDER3UP}
    {$DEFINE CBUILDER4UP}
    {$DEFINE CBUILDER5UP}
    {$DEFINE CBUILDER6UP}
    {$ObjExportAll On}
  {$ENDIF}
  {$IFDEF LINUX}
    {$DEFINE KYLIX}
    {$DEFINE KYLIX2}
    {$DEFINE KYLIX1UP}
    {$DEFINE KYLIX2UP}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER145}
  {$IFDEF LINUX}
    {$DEFINE KYLIX}
    {$DEFINE KYLIX3}
    {$DEFINE KYLIX1UP}
    {$DEFINE KYLIX2UP}
    {$DEFINE KYLIX3UP}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER150}      // Delphi 7.0
  {$DEFINE DELPHI}
  {$DEFINE DELPHI7}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$ENDIF}

{$IFDEF VER170}      // Delphi 9.0  2005
  {$DEFINE DELPHI}
  {$DEFINE DELPHI9}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER180}      // Delphi 10.0  2006
  {$DEFINE DELPHI}
  {$DEFINE DELPHI10}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$IF CompilerVersion >= 11}
    {$DEFINE DELPHI11}
    {$DEFINE DELPHI11UP}
    {$UNDEFINE DELPHI10}
  {$ENDIF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER185}      // Delphi 11.0  2007
  {$DEFINE DELPHI}
  {$DEFINE DELPHI11}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER190}      // Delphi 11.0 2007.NET
  {$DEFINE DELPHI}
  {$DEFINE DELPHI11}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER200}      // Delphi 12.0  2009
  {$DEFINE DELPHI}
  {$DEFINE DELPHI12}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER210} // Rad Studio 13.0  2010
  {$DEFINE DELPHI}
  {$DEFINE DELPHI14}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$DEFINE DELPHI14UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER220} // Rad Studio XE
  {$DEFINE DELPHI}
  {$DEFINE DELPHI15}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$DEFINE DELPHI14UP}
  {$DEFINE DELPHI15UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}


{$IFDEF VER230} // Rad Studio XE 2
  {$DEFINE DELPHI}
  {$DEFINE DELPHI16}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$DEFINE DELPHI14UP}
  {$DEFINE DELPHI15UP}
  {$DEFINE DELPHI16UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER240} // Rad Studio XE 3
  {$DEFINE DELPHI}
  {$DEFINE DELPHI17}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$DEFINE DELPHI14UP}
  {$DEFINE DELPHI15UP}
  {$DEFINE DELPHI16UP}
  {$DEFINE DELPHI17UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER250} // Rad Studio XE 4
  {$DEFINE DELPHI}
  {$DEFINE DELPHI18}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$DEFINE DELPHI14UP}
  {$DEFINE DELPHI15UP}
  {$DEFINE DELPHI16UP}
  {$DEFINE DELPHI17UP}
  {$DEFINE DELPHI18UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER260} // Rad Studio XE 5
  {$DEFINE DELPHI}
  {$DEFINE DELPHI19}
  {$DEFINE DELPHI1UP}
  {$DEFINE DELPHI2UP}
  {$DEFINE DELPHI3UP}
  {$DEFINE DELPHI4UP}
  {$DEFINE DELPHI5UP}
  {$DEFINE DELPHI6UP}
  {$DEFINE DELPHI7UP}
  {$DEFINE DELPHI8UP}
  {$DEFINE DELPHI9UP}
  {$DEFINE DELPHI10UP}
  {$DEFINE DELPHI11UP}
  {$DEFINE DELPHI12UP}
  {$DEFINE DELPHI14UP}
  {$DEFINE DELPHI15UP}
  {$DEFINE DELPHI16UP}
  {$DEFINE DELPHI17UP}
  {$DEFINE DELPHI18UP}
  {$DEFINE DELPHI19UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST OFF}
  {$WARN EXPLICIT_STRING_CAST_LOSS OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNIT_DEPRECATED OFF}
{$ENDIF}


{General define indicating use under FPC / Lazarus}
{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
  {$ASMMODE INTEL}
  {$UNDEF UsingCLX}
  {$UNDEF BCB}
  {$UNDEF CBUILDER}
  {$B-} {Complete Boolean Evaluation}
  {$I+} {Input/Output-Checking}
  {$P+} {Open Parameters}
  {$T-} {Typed @ Operator}
  {$DEFINE NoOgSrMgr}
  {$DEFINE OgPUREPASCAL_XorMem}
  {$IFNDEF Win32}
    {$DEFINE OgPUREPASCAL_Min}
    {$DEFINE OgPUREPASCAL_Max}
  {$ENDIF}
{$ENDIF}

{$IFDEF KYLIX}
  {$Q-} {Overflow Checking}
  {$R-} {Range-Checking}
  {$S-} {Stack-Overflow Checking}
  {$V-} {Var-String Checking}             //to be removed

  {$DEFINE UsingCLX}
{$ENDIF}


{$IFDEF CBuilder)
  {$A+} {Word Align Data}
{$ELSE}
  {$IFDEF DELPHI}
    {$IFNDEF DELPHI6UP}
      {$IFDEF Win32} {$A+} {Word Align Data} {$ENDIF}
      {$IFDEF Win16} {$A-} {Byte Align Data} {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF DELPHI}
  {$Q-} {Overflow Checking}
  {$R-} {Range-Checking}
  {$S-} {Stack-Overflow Checking}
  {$V-} {Var-String Checking}                 //to be removed
  {$B-} {Complete Boolean Evaluation}         //okay
  {$I+} {Input/Output-Checking}               //okay
  {$P+} {Open Parameters}                     //to be removed
  {$T-} {Typed @ Operator}                    //okay
  {$W-} {Windows Stack Frame}                 //to be removed
  {$X+} {Extended Syntax}                     //to be removed

  {$IFDEF Win16}
    {$F-} {Force Far Calls}
    {$K-} {Smart Callbacks}
  {$ENDIF}

  {$IFDEF Win16}
    {$G+} {286 Instructions}
    {$N+} {Numeric Coprocessor}
    {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
  {$ELSE}
    {$J+} {Assignable Typed Constants}                                   {!!.11}
  {$ENDIF}

  {$IFNDEF Win32}
    {$DEFINE OgPUREPASCAL_Min}
    {$DEFINE OgPUREPASCAL_Max}
  {$ENDIF}

  {$IFDEF MACOS}
    {$DEFINE OgPUREPASCAL_Min}
    {$DEFINE OgPUREPASCAL_Max}
    {$DEFINE OgPUREPASCAL_XorMem}
    {$DEFINE OgPUREPASCAL_ROLX}
    {$DEFINE NoOgSrMgr}
    {.$DEFINE NoMakeCodesSupport}  //temporary
    {.$DEFINE NoMakeKeysSupport}   //temporary
    {$IFNDEF CONSOLE}{$DEFINE UseOgFMX}{$ENDIF}
  {$ENDIF}

{$ENDIF}


{$IFDEF DELPHI12UP}
  // do not use the String Resource Manager
  {$DEFINE NoOgSrMgr}
{$ENDIF}

{$IFDEF CPUARM}
  {$DEFINE NoOgSrMgr}
  {$DEFINE OgPUREPASCAL_Min}
  {$DEFINE OgPUREPASCAL_Max}
  {$DEFINE OgPUREPASCAL_XorMem}
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
{Activate the following define to enable the borrowed JclSysInfo routines}
{.$DEFINE UseOgJCL}

{!!.15}
{Activate the following define to enable an Unlimited Usage code}
{.$DEFINE OgUsageUnlimited}

