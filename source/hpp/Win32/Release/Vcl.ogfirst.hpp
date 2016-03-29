// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.ogfirst.pas' rev: 31.00 (Windows)

#ifndef Vcl_OgfirstHPP
#define Vcl_OgfirstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ogutil.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Ogfirst
{
//-- forward type declarations -----------------------------------------------
struct TogFirst;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TogFirst
{
private:
	static bool FFirstInstance;
	static NativeUInt FInstanceMutex;
	static System::UnicodeString __fastcall GetMutexName();
	
public:
	static bool __fastcall IsFirstInstance();
	static void __fastcall ActivateFirstInstance();
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ogfirst */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_OGFIRST)
using namespace Vcl::Ogfirst;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_OgfirstHPP
