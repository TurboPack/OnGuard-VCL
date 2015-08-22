// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcl.ogproexe.pas' rev: 30.00 (Windows)

#ifndef Vcl_OgproexeHPP
#define Vcl_OgproexeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.MMSystem.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ogutil.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Ogproexe
{
//-- forward type declarations -----------------------------------------------
struct TSignatureRec;
class DELPHICLASS TOgProtectExe;
//-- type declarations -------------------------------------------------------
typedef TSignatureRec *PSignatureRec;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TSignatureRec
{
public:
	unsigned Sig1;
	unsigned Sig2;
	unsigned Sig3;
	unsigned Offset;
	unsigned Size;
	unsigned CRC;
	unsigned Sig4;
	unsigned Sig5;
	unsigned Sig6;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TExeStatus : unsigned char { exeSuccess, exeSizeError, exeIntegrityError, exeNotStamped, exeAccessDenied };

typedef void __fastcall (__closure *TCheckedExeEvent)(System::TObject* Sender, TExeStatus Status);

class PASCALIMPLEMENTATION TOgProtectExe : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	bool FAutoCheck;
	bool FCheckSize;
	TCheckedExeEvent FOnChecked;
	System::UnicodeString __fastcall GetAbout(void);
	void __fastcall SetAbout(const System::UnicodeString AValue);
	DYNAMIC void __fastcall DoOnChecked(TExeStatus Status);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TOgProtectExe(System::Classes::TComponent* AOwner);
	TExeStatus __fastcall CheckExe(bool Report);
	bool __fastcall StampExe(const System::UnicodeString FileName, bool EraseMarker);
	bool __fastcall UnStampExe(const System::UnicodeString FileName);
	
__published:
	__property bool AutoCheck = {read=FAutoCheck, write=FAutoCheck, default=1};
	__property bool CheckSize = {read=FCheckSize, write=FCheckSize, default=1};
	__property System::UnicodeString About = {read=GetAbout, write=SetAbout, stored=false};
	__property TCheckedExeEvent OnChecked = {read=FOnChecked, write=FOnChecked};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOgProtectExe(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TExeStatus __fastcall IsExeTampered(bool CheckSize);
extern DELPHI_PACKAGE bool __fastcall ProtectExe(const System::UnicodeString FileName, bool EraseMarker);
extern DELPHI_PACKAGE bool __fastcall UnprotectExe(const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall UpdateChecksum(int &Sum, const void *Buf, int BufSize);
extern DELPHI_PACKAGE unsigned __fastcall FileCRC32(const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall UpdateCRC32(unsigned &CRC, const void *Buf, int BufSize);
}	/* namespace Ogproexe */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_OGPROEXE)
using namespace Vcl::Ogproexe;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_OgproexeHPP
