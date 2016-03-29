// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.onguard1.pas' rev: 31.00 (Windows)

#ifndef Vcl_Onguard1HPP
#define Vcl_Onguard1HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ogutil.hpp>
#include <Vcl.onguard.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Onguard1
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKeyGenerateFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKeyGenerateFrm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Buttons::TSpeedButton* CopyBlockSb;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Buttons::TSpeedButton* CopyByteKeySb;
	Vcl::Stdctrls::TMemo* KeyStringMe;
	Vcl::Stdctrls::TEdit* BlockKeyEd;
	Vcl::Stdctrls::TButton* GenerateBtn;
	Vcl::Stdctrls::TComboBox* KeyTypeCb;
	Vcl::Stdctrls::TEdit* ByteKeyEd;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Buttons::TBitBtn* OKBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall KeyStringMeChange(System::TObject* Sender);
	void __fastcall KeyTypeCbChange(System::TObject* Sender);
	void __fastcall BlockKeyEdChange(System::TObject* Sender);
	void __fastcall CopyBlockSbClick(System::TObject* Sender);
	void __fastcall ByteKeyEdChange(System::TObject* Sender);
	void __fastcall CopyByteKeySbClick(System::TObject* Sender);
	void __fastcall GenerateBtnClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Vcl::Ogutil::TKey FKey;
	Vcl::Ogutil::TKeyType FKeyType;
	void __fastcall SetKeyType(Vcl::Ogutil::TKeyType Value);
	
public:
	void __fastcall SetKey(const Vcl::Ogutil::TKey &Value);
	void __fastcall GetKey(Vcl::Ogutil::TKey &Value);
	__property Vcl::Ogutil::TKeyType KeyType = {read=FKeyType, write=SetKeyType, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKeyGenerateFrm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKeyGenerateFrm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKeyGenerateFrm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKeyGenerateFrm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard1 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_ONGUARD1)
using namespace Vcl::Onguard1;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Onguard1HPP
