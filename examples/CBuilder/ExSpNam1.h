//---------------------------------------------------------------------------
#ifndef ExSpNam1H
#define ExSpNam1H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TGroupBox *GroupBox1;
	TLabel *Label1;
	TEdit *edtUserName1;
	TButton *btnGenCode;
	TEdit *edtCode1;
	TGroupBox *GroupBox2;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *lblCheckResult;
	TEdit *edtUserName2;
	TEdit *edtCode2;
	TButton *btnCheckCode;
	void __fastcall btnGenCodeClick(TObject *Sender);
	void __fastcall btnCheckCodeClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
