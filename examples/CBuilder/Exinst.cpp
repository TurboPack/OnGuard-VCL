//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

//---------------------------------------------------------------------------
USEFORM("ExInstU.cpp", FirstInstFrm);
USERES("ExInst.res");
#pragma link "OgFirst"

#include "OgFirst.hpp"
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
	try
	{
 	if (IsFirstInstance()) {
		Application->Initialize();
		Application->CreateForm(__classid(TFirstInstFrm), &FirstInstFrm);
		Application->Run();
  }
  else
    ActivateFirstInstance();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	return 0;
}
//---------------------------------------------------------------------------
