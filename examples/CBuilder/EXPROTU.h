//---------------------------------------------------------------------------
#ifndef ExProtUH
#define ExProtUH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include "OgProExe.hpp"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TLabel *StatusLbl;
	TMemo *Memo1;
	TBitBtn *CloseBtn;
	TOgProtectExe *OgProtectExe1;
	void __fastcall OgProtectExe1Checked(TObject *Sender, TExeStatus Status);
private:	// User declarations
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
