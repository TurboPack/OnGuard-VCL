//---------------------------------------------------------------------------

#include <System.hpp>
#pragma hdrstop
USEFORMNS("..\..\source\onguard1.pas", Onguard1, KeyGenerateFrm);
USEFORMNS("..\..\source\onguard2.pas", Onguard2, CodeGenerateFrm);
USEFORMNS("..\..\source\onguard3.pas", Onguard3, KeyMaintFrm);
USEFORMNS("..\..\source\onguard4.pas", Onguard4, EditProductFrm);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package-Quelltext.
//---------------------------------------------------------------------------


#pragma argsused
extern "C" int _libmain(unsigned long reason)
{
	return 1;
}
//---------------------------------------------------------------------------
