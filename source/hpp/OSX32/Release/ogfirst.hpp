// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ogfirst.pas' rev: 29.00 (MacOS)

#ifndef OgfirstHPP
#define OgfirstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Ogfirst
{
//-- forward type declarations -----------------------------------------------
struct TogFirst;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TogFirst
{
public:
	static bool __fastcall IsFirstInstance();
	static void __fastcall ActivateFirstInstance();
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ogfirst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_OGFIRST)
using namespace Ogfirst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// OgfirstHPP
