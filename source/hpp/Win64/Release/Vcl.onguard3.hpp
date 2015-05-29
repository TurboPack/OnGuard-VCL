// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.onguard3.pas' rev: 29.00 (Windows)

#ifndef Vcl_Onguard3HPP
#define Vcl_Onguard3HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <System.IniFiles.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ogutil.hpp>
#include <Vcl.onguard.hpp>
#include <Vcl.onguard1.hpp>
#include <Vcl.onguard4.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Onguard3
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKeyMaintFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKeyMaintFrm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* ProductsGb;
	Vcl::Stdctrls::TListBox* ProductsLb;
	Vcl::Stdctrls::TButton* AddBtn;
	Vcl::Stdctrls::TButton* DeleteBtn;
	Vcl::Stdctrls::TButton* EditBtn;
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Buttons::TBitBtn* OpenBtn;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Stdctrls::TGroupBox* FileNameGb;
	Vcl::Stdctrls::TEdit* FileNameEd;
	Vcl::Buttons::TSpeedButton* OpenFileSb;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TEdit* BlockKeyEd;
	Vcl::Stdctrls::TEdit* BytesKeyEd;
	Vcl::Buttons::TSpeedButton* CopyBlockKeySb;
	Vcl::Buttons::TSpeedButton* CopyByteKeySb;
	Vcl::Buttons::TSpeedButton* KeyPasteSb;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall EditBtnClick(System::TObject* Sender);
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall InfoChanged(System::TObject* Sender);
	void __fastcall KeyCopySbClick(System::TObject* Sender);
	void __fastcall OpenFileSbClick(System::TObject* Sender);
	void __fastcall OpenBtnClick(System::TObject* Sender);
	void __fastcall ProductsLbDblClick(System::TObject* Sender);
	void __fastcall CopyByteKeySbClick(System::TObject* Sender);
	void __fastcall KeyPasteSbClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	int __fastcall GetListBoxItemIndex(void);
	
private:
	Vcl::Ogutil::TKey FKey;
	Vcl::Ogutil::TKeyType FKeyType;
	System::UnicodeString __fastcall GetKeyFileName(void);
	void __fastcall SetKeyFileName(System::UnicodeString Value);
	
public:
	void __fastcall SetKey(const Vcl::Ogutil::TKey &Value);
	void __fastcall GetKey(Vcl::Ogutil::TKey &Value);
	__property System::UnicodeString KeyFileName = {read=GetKeyFileName, write=SetKeyFileName};
	__property Vcl::Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKeyMaintFrm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKeyMaintFrm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKeyMaintFrm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKeyMaintFrm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard3 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_ONGUARD3)
using namespace Vcl::Onguard3;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Onguard3HPP
