// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.onguard2.pas' rev: 29.00 (Windows)

#ifndef Vcl_Onguard2HPP
#define Vcl_Onguard2HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
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
#include <Vcl.ognetwrk.hpp>
#include <Vcl.ogutil.hpp>
#include <Vcl.onguard.hpp>
#include <Vcl.onguard3.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Onguard2
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCodeGenerateFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCodeGenerateFrm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TGroupBox* GenerateGb;
	Vcl::Buttons::TSpeedButton* RegCodeCopySb;
	Vcl::Buttons::TSpeedButton* RegStrCopySb;
	Vcl::Buttons::TSpeedButton* GenerateKeySb;
	Vcl::Stdctrls::TButton* GenerateBtn;
	Vcl::Stdctrls::TButton* RegRandomBtn;
	Vcl::Stdctrls::TButton* SerRandomBtn;
	Vcl::Stdctrls::TCheckBox* StringModifierCb;
	Vcl::Stdctrls::TCheckBox* UniqueModifierCb;
	Vcl::Stdctrls::TCheckBox* MachineModifierCb;
	Vcl::Stdctrls::TCheckBox* DateModifierCb;
	Vcl::Stdctrls::TCheckBox* NoModifierCb;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Tabnotbk::TTabbedNotebook* CodesNbk;
	Vcl::Buttons::TBitBtn* OKBtn;
	Vcl::Buttons::TBitBtn* CancelBtn;
	Vcl::Stdctrls::TEdit* UsageExpiresEd;
	Vcl::Stdctrls::TEdit* SpecialExpiresEd;
	Vcl::Stdctrls::TEdit* SerialExpiresEd;
	Vcl::Stdctrls::TEdit* RegExpiresEd;
	Vcl::Stdctrls::TEdit* DaysExpiresEd;
	Vcl::Stdctrls::TEdit* ModDateEd;
	Vcl::Stdctrls::TEdit* StartDateEd;
	Vcl::Stdctrls::TEdit* EndDateEd;
	Vcl::Stdctrls::TEdit* DaysCountEd;
	Vcl::Stdctrls::TEdit* SerialNumberEd;
	Vcl::Stdctrls::TEdit* UsageCountEd;
	Vcl::Stdctrls::TEdit* NetworkSlotsEd;
	Vcl::Stdctrls::TEdit* SpecialDataEd;
	Vcl::Stdctrls::TEdit* RegCodeEd;
	Vcl::Stdctrls::TEdit* RegStrEd;
	Vcl::Stdctrls::TEdit* ModifierEd;
	Vcl::Stdctrls::TEdit* BlockKeyEd;
	Vcl::Stdctrls::TEdit* ModStringEd;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ModifierClick(System::TObject* Sender);
	void __fastcall RegRandomBtnClick(System::TObject* Sender);
	void __fastcall GenerateBtnClick(System::TObject* Sender);
	void __fastcall SerRandomBtnClick(System::TObject* Sender);
	void __fastcall ParametersChanged(System::TObject* Sender);
	void __fastcall ModifierEdKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall RegStrCopySbClick(System::TObject* Sender);
	void __fastcall RegCodeCopySbClick(System::TObject* Sender);
	void __fastcall DateEdKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall NumberEdKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall TabbedNotebook1Change(System::TObject* Sender, int NewTab, bool &AllowChange);
	void __fastcall GenerateKeySbClick(System::TObject* Sender);
	void __fastcall InfoChanged(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	bool FBusy;
	Vcl::Ogutil::TCode FCode;
	Vcl::Ogutil::TCodeType FCodeType;
	Vcl::Ogutil::TKey FKey;
	Vcl::Ogutil::TKeyType FKeyType;
	System::UnicodeString FKeyFileName;
	MESSAGE void __fastcall OGMCheck(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall OGMQuit(Winapi::Messages::TMessage &Msg);
	void __fastcall SetCodeType(Vcl::Ogutil::TCodeType Value);
	
public:
	void __fastcall SetKey(const Vcl::Ogutil::TKey &Value);
	void __fastcall GetKey(Vcl::Ogutil::TKey &Value);
	__property Vcl::Ogutil::TCode Code = {read=FCode};
	__property Vcl::Ogutil::TCodeType CodeType = {read=FCodeType, write=SetCodeType, nodefault};
	__property System::UnicodeString KeyFileName = {read=FKeyFileName, write=FKeyFileName};
	__property Vcl::Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCodeGenerateFrm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCodeGenerateFrm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCodeGenerateFrm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCodeGenerateFrm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word OGM_CHECK = System::Word(0x464);
static const System::Word OGM_QUIT = System::Word(0x465);
}	/* namespace Onguard2 */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_ONGUARD2)
using namespace Vcl::Onguard2;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_Onguard2HPP
