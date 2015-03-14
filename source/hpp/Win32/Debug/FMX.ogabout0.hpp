// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.ogabout0.pas' rev: 29.00 (Windows)

#ifndef Fmx_Ogabout0HPP
#define Fmx_Ogabout0HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.ogutil.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Ogabout0
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOgAboutForm;
class DELPHICLASS TOgAboutProperty;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOgAboutForm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Objects::TImage* Image1;
	Fmx::Stdctrls::TLabel* lblVersion;
	Fmx::Stdctrls::TButton* btnOK;
	Fmx::Stdctrls::TLabel* WebLbl;
	Fmx::Stdctrls::TLabel* NewsLbl;
	void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall WebLblMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall NewsLblMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall Panel2MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall WebLblClick(System::TObject* Sender);
	void __fastcall NewsLblClick(System::TObject* Sender);
	void __fastcall FormMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TOgAboutForm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TOgAboutForm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TOgAboutForm(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TOgAboutProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TOgAboutProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TOgAboutProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ogabout0 */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_OGABOUT0)
using namespace Fmx::Ogabout0;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Ogabout0HPP
