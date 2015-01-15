//---------------------------------------------------------------------------
#ifndef ExSnRegUH
#define ExSnRegUH
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
	TOgSerialNumberCode *OgSerialNumberCode1;
	void __fastcall OgSerialNumberCode1Checked(TObject *Sender, TCodeStatus Status);
	void __fastcall OgSerialNumberCode1GetKey(TObject *Sender, TKey &Key);
	void __fastcall OgSerialNumberCode1GetCode(TObject *Sender, TCode &Code);
	void __fastcall CodeBtnClick(TObject *Sender);
	void __fastcall RemoveBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
