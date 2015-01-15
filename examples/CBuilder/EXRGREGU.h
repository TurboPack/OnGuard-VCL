//---------------------------------------------------------------------------
#ifndef ExRgRegUH
#define ExRgRegUH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\IniFiles.hpp>
#include "OnGuard.hpp"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TLabel *StatusLbl;
	TLabel *Label1;
	TLabel *CodeLbl;
	TButton *CodeBtn;
	TMemo *Memo1;
	TBitBtn *CloseBtn;
	TButton *RemoveBtn;
	TOgRegistrationCode *OgRegistrationCode1;
	void __fastcall OgRegistrationCode1Checked(TObject *Sender, TCodeStatus Status);
	void __fastcall OgRegistrationCode1GetKey(TObject *Sender, TKey &Key);
	void __fastcall OgRegistrationCode1GetCode(TObject *Sender, TCode &Code);
	void __fastcall CodeBtnClick(TObject *Sender);
	void __fastcall RemoveBtnClick(TObject *Sender);
private:	// User declarations
	String RegStr;
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
