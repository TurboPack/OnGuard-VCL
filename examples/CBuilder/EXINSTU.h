//---------------------------------------------------------------------------
#ifndef ExInstUH
#define ExInstUH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
//---------------------------------------------------------------------------
class TFirstInstFrm : public TForm
{
__published:	// IDE-managed Components
	TMemo *Memo1;
	TBitBtn *BitBtn2;
private:	// User declarations
public:		// User declarations
	__fastcall TFirstInstFrm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TFirstInstFrm *FirstInstFrm;
//---------------------------------------------------------------------------
#endif
