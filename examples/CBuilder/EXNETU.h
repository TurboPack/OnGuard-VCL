//---------------------------------------------------------------------------
#ifndef ExNetUH
#define ExNetUH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\IniFiles.hpp>
#include "OgNetWrk.hpp"
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
	TOgNetCode *OgNetCode1;
	void __fastcall OgNetCode1Checked(TObject *Sender, TCodeStatus Status);
	void __fastcall OgNetCode1GetKey(TObject *Sender, TKey &Key);
	void __fastcall OgNetCode1GetCode(TObject *Sender, TCode &Code);
	void __fastcall CodeBtnClick(TObject *Sender);
	void __fastcall RemoveBtnClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
