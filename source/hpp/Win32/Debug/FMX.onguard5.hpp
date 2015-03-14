// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.onguard5.pas' rev: 29.00 (Windows)

#ifndef Fmx_Onguard5HPP
#define Fmx_Onguard5HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.onguard.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Onguard5
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOgCodeProperty;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TOgCodeProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TOgCodeProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TOgCodeProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard5 */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_ONGUARD5)
using namespace Fmx::Onguard5;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Onguard5HPP
