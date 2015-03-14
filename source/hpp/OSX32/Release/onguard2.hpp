// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'onguard2.pas' rev: 29.00 (MacOS)

#ifndef Onguard2HPP
#define Onguard2HPP

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
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Objects.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Platform.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Header.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.DateTimeCtrls.hpp>
#include <FMX.CalendarEdit.hpp>
#include <FMX.NumberBox.hpp>
#include <onguard.hpp>
#include <onguard3.hpp>
#include <FMX.EditBox.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <ogutil.hpp>

//-- user supplied -----------------------------------------------------------

namespace Onguard2
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCodeGenerateFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCodeGenerateFrm : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TGroupBox* GenerateGb;
	Fmx::Stdctrls::TSpeedButton* RegCodeCopySb;
	Fmx::Stdctrls::TSpeedButton* RegStrCopySb;
	Fmx::Stdctrls::TSpeedButton* GenerateKeySb;
	Fmx::Stdctrls::TButton* GenerateBtn;
	Fmx::Stdctrls::TButton* RegRandomBtn;
	Fmx::Stdctrls::TButton* SerRandomBtn;
	Fmx::Stdctrls::TCheckBox* StringModifierCb;
	Fmx::Stdctrls::TCheckBox* UniqueModifierCb;
	Fmx::Stdctrls::TCheckBox* MachineModifierCb;
	Fmx::Stdctrls::TCheckBox* DateModifierCb;
	Fmx::Stdctrls::TCheckBox* NoModifierCb;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Stdctrls::TLabel* Label11;
	Fmx::Stdctrls::TLabel* Label12;
	Fmx::Stdctrls::TLabel* Label13;
	Fmx::Stdctrls::TLabel* Label14;
	Fmx::Stdctrls::TLabel* Label15;
	Fmx::Stdctrls::TLabel* Label17;
	Fmx::Stdctrls::TLabel* Label19;
	Fmx::Edit::TEdit* RegCodeEd;
	Fmx::Edit::TEdit* RegStrEd;
	Fmx::Edit::TEdit* ModifierEd;
	Fmx::Edit::TEdit* BlockKeyEd;
	Fmx::Edit::TEdit* ModStringEd;
	Fmx::Stdctrls::TButton* OKBtn;
	Fmx::Stdctrls::TButton* CancelBtn;
	Fmx::Tabcontrol::TTabControl* CodesTC;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Tabcontrol::TTabItem* TabItem3;
	Fmx::Tabcontrol::TTabItem* TabItem4;
	Fmx::Tabcontrol::TTabItem* TabItem5;
	Fmx::Tabcontrol::TTabItem* TabItem6;
	Fmx::Tabcontrol::TTabItem* TabItem7;
	Fmx::Datetimectrls::TDateEdit* StartDateCalendarEdit;
	Fmx::Datetimectrls::TDateEdit* EndDateCalendarEdit;
	Fmx::Spinbox::TSpinBox* DaysCountSpinBox;
	Fmx::Datetimectrls::TDateEdit* DaysExpiresCalendarEdit;
	Fmx::Datetimectrls::TDateEdit* RegExpiresCalendarEdit;
	Fmx::Numberbox::TNumberBox* SerialNumberNumberBox;
	Fmx::Datetimectrls::TDateEdit* SerialExpiresCalendarEdit;
	Fmx::Numberbox::TNumberBox* UsageCountNumberBox;
	Fmx::Datetimectrls::TDateEdit* UsageExpiresCalendarEdit;
	Fmx::Numberbox::TNumberBox* NetworkSlotsNumberBox;
	Fmx::Numberbox::TNumberBox* SpecialDataNumberBox;
	Fmx::Datetimectrls::TDateEdit* SpecialExpiresCalendarEdit;
	Fmx::Datetimectrls::TDateEdit* ModDateCalendarEdit;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ModifierClick(System::TObject* Sender);
	void __fastcall RegRandomBtnClick(System::TObject* Sender);
	void __fastcall GenerateBtnClick(System::TObject* Sender);
	void __fastcall SerRandomBtnClick(System::TObject* Sender);
	void __fastcall ParametersChanged(System::TObject* Sender);
	void __fastcall ModifierEdKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall RegStrCopySbClick(System::TObject* Sender);
	void __fastcall RegCodeCopySbClick(System::TObject* Sender);
	void __fastcall GenerateKeySbClick(System::TObject* Sender);
	void __fastcall InfoChanged(System::TObject* Sender);
	
private:
	bool FBusy;
	Ogutil::TCode FCode;
	Ogutil::TCodeType FCodeType;
	Ogutil::TKey FKey;
	Ogutil::TKeyType FKeyType;
	System::UnicodeString FKeyFileName;
	void __fastcall SetCodeType(Ogutil::TCodeType Value);
	
public:
	void __fastcall SetKey(const Ogutil::TKey &Value);
	void __fastcall GetKey(Ogutil::TKey &Value);
	__property Ogutil::TCode Code = {read=FCode};
	__property Ogutil::TCodeType CodeType = {read=FCodeType, write=SetCodeType, nodefault};
	__property System::UnicodeString KeyFileName = {read=FKeyFileName, write=FKeyFileName};
	__property Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCodeGenerateFrm(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCodeGenerateFrm(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCodeGenerateFrm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard2 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ONGUARD2)
using namespace Onguard2;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Onguard2HPP
