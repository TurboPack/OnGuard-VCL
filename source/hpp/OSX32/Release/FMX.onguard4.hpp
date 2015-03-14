// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.onguard4.pas' rev: 29.00 (MacOS)

#ifndef Fmx_Onguard4HPP
#define Fmx_Onguard4HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.ogutil.hpp>
#include <FMX.onguard.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Objects.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Platform.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Header.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Controls.Presentation.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Onguard4
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEditProductFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEditProductFrm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* OKBtn;
	Fmx::Stdctrls::TButton* CancelBtn;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Edit::TEdit* ProductEd;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Edit::TEdit* KeyEd;
	Fmx::Stdctrls::TSpeedButton* GenerateKeySb;
	Fmx::Stdctrls::TSpeedButton* KeyPasteSb;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall InfoChanged(System::TObject* Sender);
	void __fastcall KeyPasteSbClick(System::TObject* Sender);
	void __fastcall GenerateKeySbClick(System::TObject* Sender);
	
private:
	Fmx::Ogutil::TKey FKey;
	Fmx::Ogutil::TKeyType FKeyType;
	bool __fastcall GetShowHints(void);
	void __fastcall SetShowHints(bool Value);
	
public:
	void __fastcall SetKey(const Fmx::Ogutil::TKey &Value);
	void __fastcall GetKey(Fmx::Ogutil::TKey &Value);
	__property Fmx::Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
	__property bool ShowHints = {read=GetShowHints, write=SetShowHints, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TEditProductFrm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TEditProductFrm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TEditProductFrm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard4 */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_ONGUARD4)
using namespace Fmx::Onguard4;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_Onguard4HPP
