//---------------------------------------------------------------------------
#ifndef ExDModU2H
#define ExDModU2H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include "OnGuard.hpp"
//---------------------------------------------------------------------------
class TSNEntryDlg : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TEdit *SNText;
	TEdit *CodeText;
	TBitBtn *OKBtn;
	TBitBtn *CancelBtn;
	TEdit *ModString;
	void __fastcall CancelBtnClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TSNEntryDlg(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TSNEntryDlg *SNEntryDlg;
//---------------------------------------------------------------------------
#endif
