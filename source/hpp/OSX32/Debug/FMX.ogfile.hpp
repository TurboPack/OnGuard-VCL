// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.ogfile.pas' rev: 29.00 (MacOS)

#ifndef Fmx_OgfileHPP
#define Fmx_OgfileHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Posix.Base.hpp>
#include <Posix.SysStat.hpp>
#include <Posix.Fcntl.hpp>
#include <Posix.Stdio.hpp>
#include <System.SysUtils.hpp>
#include <FMX.ogutil.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Ogfile
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE unsigned __fastcall GetFileSize(NativeUInt Handle);
extern DELPHI_PACKAGE bool __fastcall LockFile(NativeUInt Handle, System::Word FileOffsetLow, System::Word FileOffsetHigh, System::Word LockCountLow, System::Word LockCountHigh);
extern DELPHI_PACKAGE bool __fastcall UnlockFile(NativeUInt Handle, System::Word FileOffsetLow, System::Word FileOffsetHigh, System::Word UnLockCountLow, System::Word UnLockCountHigh);
extern DELPHI_PACKAGE bool __fastcall FlushFileBuffers(NativeUInt Handle);
}	/* namespace Ogfile */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_OGFILE)
using namespace Fmx::Ogfile;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_OgfileHPP
