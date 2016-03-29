// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.onguard6.pas' rev: 31.00 (Windows)

#ifndef Vcl_Onguard6HPP
#define Vcl_Onguard6HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Mask.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.TabNotBk.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.ogutil.hpp>
#include <Vcl.onguard.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Onguard6
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TModifierFrm;
class DELPHICLASS TOgModifierProperty;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TModifierFrm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* UniqueModifierCb;
	Vcl::Stdctrls::TCheckBox* MachineModifierCb;
	Vcl::Stdctrls::TCheckBox* DateModifierCb;
	Vcl::Stdctrls::TCheckBox* NoModifierCb;
	Vcl::Stdctrls::TEdit* ModifierEd;
	Vcl::Stdctrls::TEdit* ModDateEd;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ModifierClick(System::TObject* Sender);
	void __fastcall ModifierEdKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall DateEdKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall InfoChanged(System::TObject* Sender);
	
private:
	bool FBusy;
	
public:
	int Modifier;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TModifierFrm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TModifierFrm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TModifierFrm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TModifierFrm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TOgModifierProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TOgModifierProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TOgModifierProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard6 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_ONGUARD6)
using namespace Vcl::Onguard6;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Onguard6HPP
