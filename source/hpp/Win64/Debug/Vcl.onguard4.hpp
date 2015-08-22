// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.onguard4.pas' rev: 30.00 (Windows)

#ifndef Vcl_Onguard4HPP
#define Vcl_Onguard4HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ogutil.hpp>
#include <Vcl.onguard.hpp>
#include <Vcl.onguard1.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Onguard4
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEditProductFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEditProductFrm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OKBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* ProductEd;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* KeyEd;
	Vcl::Buttons::TSpeedButton* GenerateKeySb;
	Vcl::Buttons::TSpeedButton* KeyPasteSb;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall InfoChanged(System::TObject* Sender);
	void __fastcall KeyPasteSbClick(System::TObject* Sender);
	void __fastcall GenerateKeySbClick(System::TObject* Sender);
	
private:
	Vcl::Ogutil::TKey FKey;
	Vcl::Ogutil::TKeyType FKeyType;
	bool __fastcall GetShowHints(void);
	void __fastcall SetShowHints(bool Value);
	
public:
	void __fastcall SetKey(const Vcl::Ogutil::TKey &Value);
	void __fastcall GetKey(Vcl::Ogutil::TKey &Value);
	__property Vcl::Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
	__property bool ShowHints = {read=GetShowHints, write=SetShowHints, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TEditProductFrm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TEditProductFrm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TEditProductFrm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEditProductFrm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard4 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_ONGUARD4)
using namespace Vcl::Onguard4;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Onguard4HPP
