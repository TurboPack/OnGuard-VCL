//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("ExReg.res");
USEFORM("ExReg1.cpp", frmExReg);
USEUNIT("..\..\ONGUARD.PAS");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmExReg), &frmExReg);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
