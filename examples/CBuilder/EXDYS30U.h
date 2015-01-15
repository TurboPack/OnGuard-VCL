//---------------------------------------------------------------------------
#ifndef ExDys30UH
#define ExDys30UH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\IniFiles.hpp>
#include "OnGuard.hpp"

const TKey CKey = { 0xE5,0x8F,0x84,0xD6,0x92,0xC9,0xA4,0xD8,
                    0x1A,0xFA,0x6F,0x8D,0xAB,0xFC,0xDF,0xB4 };

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TMemo *Memo1;
	TBitBtn *CloseBtn;
	TOgDaysCode *OgDaysCode1;
	void __fastcall OgDaysCode1GetKey(TObject *Sender, TKey &Key);
	void __fastcall OgDaysCode1GetCode(TObject *Sender, TCode &Code);
	void __fastcall OgDaysCode1ChangeCode(TObject *Sender, TCode &Code);
	void __fastcall OgDaysCode1Checked(TObject *Sender, TCodeStatus Status);
private:	// User declarations
	String TheDir;
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
