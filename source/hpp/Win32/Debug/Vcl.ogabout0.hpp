// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.ogabout0.pas' rev: 30.00 (Windows)

#ifndef Vcl_Ogabout0HPP
#define Vcl_Ogabout0HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.ogutil.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Ogabout0
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOgAboutForm;
class DELPHICLASS TOgAboutProperty;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOgAboutForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TLabel* lblVersion;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TLabel* WebLbl;
	Vcl::Stdctrls::TLabel* NewsLbl;
	void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall WebLblMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall NewsLblMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Panel2MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall WebLblClick(System::TObject* Sender);
	void __fastcall NewsLblClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TOgAboutForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TOgAboutForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TOgAboutForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TOgAboutForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
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
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_OGABOUT0)
using namespace Vcl::Ogabout0;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Ogabout0HPP
