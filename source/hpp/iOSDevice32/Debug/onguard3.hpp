// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'onguard3.pas' rev: 29.00 (iOS)

#ifndef Onguard3HPP
#define Onguard3HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <ogutil.hpp>
#include <onguard.hpp>
#include <onguard1.hpp>
#include <onguard4.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.IniFiles.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Objects.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Platform.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Header.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Onguard3
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKeyMaintFrm;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TKeyMaintFrm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TGroupBox* ProductsGb;
	Fmx::Listbox::TListBox* ProductsLb;
	Fmx::Stdctrls::TButton* AddBtn;
	Fmx::Stdctrls::TButton* DeleteBtn;
	Fmx::Stdctrls::TButton* EditBtn;
	Fmx::Stdctrls::TButton* OKBtn;
	Fmx::Stdctrls::TButton* CancelBtn;
	Fmx::Stdctrls::TButton* OpenBtn;
	Fmx::Dialogs::TOpenDialog* OpenDialog1;
	Fmx::Stdctrls::TGroupBox* FileNameGb;
	Fmx::Edit::TEdit* FileNameEd;
	Fmx::Stdctrls::TSpeedButton* OpenFileSb;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Edit::TEdit* BlockKeyEd;
	Fmx::Edit::TEdit* BytesKeyEd;
	Fmx::Stdctrls::TSpeedButton* CopyBlockKeySb;
	Fmx::Stdctrls::TSpeedButton* CopyByteKeySb;
	Fmx::Stdctrls::TSpeedButton* KeyPasteSb;
	Fmx::Stdctrls::TSpeedButton* SpeedButton1;
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
	Ogutil::TKey FKey;
	Ogutil::TKeyType FKeyType;
	System::UnicodeString __fastcall GetKeyFileName(void);
	void __fastcall SetKeyFileName(System::UnicodeString Value);
	
public:
	void __fastcall SetKey(const Ogutil::TKey &Value);
	void __fastcall GetKey(Ogutil::TKey &Value);
	__property System::UnicodeString KeyFileName = {read=GetKeyFileName, write=SetKeyFileName};
	__property Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKeyMaintFrm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKeyMaintFrm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKeyMaintFrm(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard3 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ONGUARD3)
using namespace Onguard3;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Onguard3HPP
