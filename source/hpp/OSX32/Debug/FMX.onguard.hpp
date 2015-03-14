// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.onguard.pas' rev: 29.00 (MacOS)

#ifndef Fmx_OnguardHPP
#define Fmx_OnguardHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <FMX.ogutil.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Onguard
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOgCodeBase;
class DELPHICLASS TOgMakeCodes;
class DELPHICLASS TOgMakeKeys;
class DELPHICLASS TOgDateCode;
class DELPHICLASS TOgDaysCode;
class DELPHICLASS TOgRegistrationCode;
class DELPHICLASS TOgSerialNumberCode;
class DELPHICLASS TOgSpecialCode;
class DELPHICLASS TOgUsageCode;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TChangeCodeEvent)(System::TObject* Sender, const Fmx::Ogutil::TCode &Code);

typedef void __fastcall (__closure *TCheckedCodeEvent)(System::TObject* Sender, Fmx::Ogutil::TCodeStatus Status);

typedef void __fastcall (__closure *TGetCodeEvent)(System::TObject* Sender, Fmx::Ogutil::TCode &Code);

typedef void __fastcall (__closure *TGetKeyEvent)(System::TObject* Sender, Fmx::Ogutil::TKey &Key);

typedef void __fastcall (__closure *TGetModifierEvent)(System::TObject* Sender, int &Value);

typedef void __fastcall (__closure *TGetRegStringEvent)(System::TObject* Sender, System::UnicodeString &Value);

class PASCALIMPLEMENTATION TOgCodeBase : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	bool FAutoCheck;
	Fmx::Ogutil::TCode FCode;
	int FModifier;
	bool FStoreCode;
	bool FStoreModifier;
	TCheckedCodeEvent FOnChecked;
	TGetCodeEvent FOnGetCode;
	TGetKeyEvent FOnGetKey;
	TGetModifierEvent FOnGetModifier;
	System::UnicodeString __fastcall GetCode(void);
	System::UnicodeString __fastcall GetModifier(void);
	System::UnicodeString __fastcall GetAbout(void);
	void __fastcall SetCode(const System::UnicodeString Value);
	void __fastcall SetModifier(const System::UnicodeString Value);
	void __fastcall SetAbout(const System::UnicodeString Value);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoOnChecked(Fmx::Ogutil::TCodeStatus Value);
	DYNAMIC Fmx::Ogutil::TCode __fastcall DoOnGetCode(void);
	DYNAMIC void __fastcall DoOnGetKey(Fmx::Ogutil::TKey &Key);
	DYNAMIC int __fastcall DoOnGetModifier(void);
	__property System::UnicodeString Code = {read=GetCode, write=SetCode};
	__property bool StoreCode = {read=FStoreCode, write=FStoreCode, nodefault};
	
public:
	__fastcall virtual TOgCodeBase(System::Classes::TComponent* AOwner);
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report) = 0 ;
	bool __fastcall IsCodeValid(void);
	
__published:
	__property bool AutoCheck = {read=FAutoCheck, write=FAutoCheck, default=1};
	__property System::UnicodeString Modifier = {read=GetModifier, write=SetModifier, stored=FStoreModifier};
	__property bool StoreModifier = {read=FStoreModifier, write=FStoreModifier, default=0};
	__property System::UnicodeString About = {read=GetAbout, write=SetAbout, stored=false};
	__property TCheckedCodeEvent OnChecked = {read=FOnChecked, write=FOnChecked};
	__property TGetKeyEvent OnGetKey = {read=FOnGetKey, write=FOnGetKey};
	__property TGetCodeEvent OnGetCode = {read=FOnGetCode, write=FOnGetCode};
	__property TGetModifierEvent OnGetModifier = {read=FOnGetModifier, write=FOnGetModifier};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgCodeBase(void) { }
	
};


class PASCALIMPLEMENTATION TOgMakeCodes : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	Fmx::Ogutil::TCode FCode;
	Fmx::Ogutil::TCodeType FCodeType;
	Fmx::Ogutil::TKey FKey;
	System::UnicodeString FKeyFileName;
	Fmx::Ogutil::TKeyType FKeyType;
	bool FShowHints;
	System::UnicodeString __fastcall GetAbout(void);
	void __fastcall SetAbout(const System::UnicodeString Value);
	
public:
	__fastcall virtual TOgMakeCodes(System::Classes::TComponent* AOwner);
	bool __fastcall Execute(void);
	void __fastcall GetCode(Fmx::Ogutil::TCode &Value);
	void __fastcall SetCode(const Fmx::Ogutil::TCode &Value);
	void __fastcall GetKey(Fmx::Ogutil::TKey &Value);
	void __fastcall SetKey(const Fmx::Ogutil::TKey &Value);
	__property Fmx::Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, nodefault};
	
__published:
	__property Fmx::Ogutil::TCodeType CodeType = {read=FCodeType, write=FCodeType, default=0};
	__property System::UnicodeString KeyFileName = {read=FKeyFileName, write=FKeyFileName};
	__property bool ShowHints = {read=FShowHints, write=FShowHints, default=0};
	__property System::UnicodeString About = {read=GetAbout, write=SetAbout, stored=false};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgMakeCodes(void) { }
	
};


class PASCALIMPLEMENTATION TOgMakeKeys : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	System::UnicodeString FKeyFileName;
	Fmx::Ogutil::TKey FKey;
	Fmx::Ogutil::TKeyType FKeyType;
	bool FShowHints;
	System::UnicodeString __fastcall GetAbout(void);
	void __fastcall SetAbout(const System::UnicodeString Value);
	
public:
	__fastcall virtual TOgMakeKeys(System::Classes::TComponent* AOwner);
	bool __fastcall Execute(void);
	void __fastcall ApplyModifierToKey(int Modifier, void *Key, unsigned KeySize);
	int __fastcall GenerateDateModifier(System::TDateTime D);
	int __fastcall GenerateMachineModifier(void);
	void __fastcall GenerateMDKey(void *Key, unsigned KeySize, const System::UnicodeString Str);
	void __fastcall GenerateRandomKey(void *Key, unsigned KeySize);
	int __fastcall GenerateStringModifier(const System::UnicodeString S);
	int __fastcall GenerateUniqueModifier(void);
	void __fastcall SetKey(const Fmx::Ogutil::TKey &Value);
	void __fastcall GetKey(Fmx::Ogutil::TKey &Value);
	
__published:
	__property System::UnicodeString About = {read=GetAbout, write=SetAbout, stored=false};
	__property System::UnicodeString KeyFileName = {read=FKeyFileName, write=FKeyFileName};
	__property Fmx::Ogutil::TKeyType KeyType = {read=FKeyType, write=FKeyType, default=0};
	__property bool ShowHints = {read=FShowHints, write=FShowHints, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgMakeKeys(void) { }
	
};


class PASCALIMPLEMENTATION TOgDateCode : public TOgCodeBase
{
	typedef TOgCodeBase inherited;
	
public:
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report);
	System::TDateTime __fastcall GetValue(void);
	
__published:
	__property Code = {stored=FStoreCode, default=0};
	__property StoreCode = {default=0};
public:
	/* TOgCodeBase.Create */ inline __fastcall virtual TOgDateCode(System::Classes::TComponent* AOwner) : TOgCodeBase(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgDateCode(void) { }
	
};


class PASCALIMPLEMENTATION TOgDaysCode : public TOgCodeBase
{
	typedef TOgCodeBase inherited;
	
protected:
	bool FAutoDecrease;
	TChangeCodeEvent FOnChangeCode;
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoOnChangeCode(const Fmx::Ogutil::TCode &Value);
	
public:
	__fastcall virtual TOgDaysCode(System::Classes::TComponent* AOwner);
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report);
	void __fastcall Decrease(void);
	int __fastcall GetValue(void);
	
__published:
	__property bool AutoDecrease = {read=FAutoDecrease, write=FAutoDecrease, default=1};
	__property TChangeCodeEvent OnChangeCode = {read=FOnChangeCode, write=FOnChangeCode};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgDaysCode(void) { }
	
};


class PASCALIMPLEMENTATION TOgRegistrationCode : public TOgCodeBase
{
	typedef TOgCodeBase inherited;
	
protected:
	System::UnicodeString FRegString;
	bool FStoreRegString;
	TGetRegStringEvent FOnGetRegString;
	DYNAMIC System::UnicodeString __fastcall DoOnGetRegString(void);
	
public:
	__fastcall virtual TOgRegistrationCode(System::Classes::TComponent* AOwner);
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report);
	
__published:
	__property Code = {stored=FStoreCode, default=0};
	__property StoreCode = {default=0};
	__property System::UnicodeString RegString = {read=FRegString, write=FRegString, stored=FStoreRegString};
	__property bool StoreRegString = {read=FStoreRegString, write=FStoreRegString, default=0};
	__property TGetRegStringEvent OnGetRegString = {read=FOnGetRegString, write=FOnGetRegString};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgRegistrationCode(void) { }
	
};


class PASCALIMPLEMENTATION TOgSerialNumberCode : public TOgCodeBase
{
	typedef TOgCodeBase inherited;
	
public:
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report);
	int __fastcall GetValue(void);
	
__published:
	__property Code = {stored=FStoreCode, default=0};
	__property StoreCode = {default=0};
public:
	/* TOgCodeBase.Create */ inline __fastcall virtual TOgSerialNumberCode(System::Classes::TComponent* AOwner) : TOgCodeBase(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgSerialNumberCode(void) { }
	
};


class PASCALIMPLEMENTATION TOgSpecialCode : public TOgCodeBase
{
	typedef TOgCodeBase inherited;
	
__published:
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report);
	int __fastcall GetValue(void);
	__property Code = {stored=FStoreCode, default=0};
	__property StoreCode = {default=0};
public:
	/* TOgCodeBase.Create */ inline __fastcall virtual TOgSpecialCode(System::Classes::TComponent* AOwner) : TOgCodeBase(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgSpecialCode(void) { }
	
};


class PASCALIMPLEMENTATION TOgUsageCode : public TOgCodeBase
{
	typedef TOgCodeBase inherited;
	
protected:
	bool FAutoDecrease;
	TChangeCodeEvent FOnChangeCode;
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoOnChangeCode(const Fmx::Ogutil::TCode &Value);
	
public:
	__fastcall virtual TOgUsageCode(System::Classes::TComponent* AOwner);
	virtual Fmx::Ogutil::TCodeStatus __fastcall CheckCode(bool Report);
	void __fastcall Decrease(void);
	int __fastcall GetValue(void);
	
__published:
	__property bool AutoDecrease = {read=FAutoDecrease, write=FAutoDecrease, default=1};
	__property TChangeCodeEvent OnChangeCode = {read=FOnChangeCode, write=FOnChangeCode};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgUsageCode(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Onguard */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_ONGUARD)
using namespace Fmx::Onguard;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_OnguardHPP
