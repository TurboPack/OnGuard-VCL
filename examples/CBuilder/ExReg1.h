//---------------------------------------------------------------------------
#ifndef ExReg1H
#define ExReg1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmExReg : public TForm
{
__published:	// IDE-managed Components
    TGroupBox *GroupBox1;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TSpeedButton *btnGenerate;
    TEdit *edtUserName1;
    TDateTimePicker *pickExpirationDate;
    TEdit *edtRegCode1;
    TGroupBox *GroupBox2;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TSpeedButton *btnVerify;
    TEdit *edtUserName2;
    TEdit *edtRegCode2;
    TEdit *edtStatus;
    void __fastcall btnGenerateClick(TObject *Sender);
    void __fastcall btnVerifyClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TfrmExReg(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmExReg *frmExReg;
//---------------------------------------------------------------------------
#endif
