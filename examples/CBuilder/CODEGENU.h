//---------------------------------------------------------------------------
#ifndef CodeGenUH
#define CodeGenUH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include "OnGuard.hpp"
#include "OgUtil.hpp"
//---------------------------------------------------------------------------
class TCodeGenFrm : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label2;
	TSpeedButton *CopySb;
	TButton *GenerateBtn;
	TEdit *CodeEd;
	TBitBtn *CloseBtn;
	TOgMakeCodes *OgMakeCodes1;
	void __fastcall CopySbClick(TObject *Sender);
	void __fastcall GenerateBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TCodeGenFrm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TCodeGenFrm *CodeGenFrm;
//---------------------------------------------------------------------------
#endif
