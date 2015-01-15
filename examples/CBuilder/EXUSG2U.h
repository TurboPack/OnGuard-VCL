//---------------------------------------------------------------------------
#ifndef ExUsg2UH
#define ExUsg2UH
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\IniFiles.hpp>
#include "OnGuard.hpp"

TKey CKey = { 0xE5,0x8F,0x84,0xD6,0x92,0xC9,0xA4,0xD8,
              0x1A,0xFA,0x6F,0x8D,0xAB,0xFC,0xDF,0xB4 };

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TMemo *Memo1;
	TBitBtn *CloseBtn;
	TOgUsageCode *OgUsageCode2;
	void __fastcall OgUsageCode2GetKey(TObject *Sender, TKey &Key);
	void __fastcall OgUsageCode2GetCode(TObject *Sender, TCode &Code);
	void __fastcall OgUsageCode2Checked(TObject *Sender, TCodeStatus Status);
	void __fastcall OgUsageCode2ChangeCode(TObject *Sender, TCode &Code);
private:	// User declarations
  String TheDir;
  TIniFile* IniFile;
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
