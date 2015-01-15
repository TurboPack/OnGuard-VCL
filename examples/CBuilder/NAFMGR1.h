//---------------------------------------------------------------------------
#ifndef NafMgr1H
#define NafMgr1H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\Dialogs.hpp>
#include "OgNetWrk.hpp"
#include "OgUtil.hpp"
#include "OnGuard.hpp"

// this application's key
TKey CKey = { 0xE5,0x8F,0x84,0xD6,0x92,0xC9,0xA4,0xD8,
					    0x1A, 0xFA,0x6F,0x8D,0xAB,0xFC,0xDF,0xB4 };

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TGroupBox *GroupBox1;
	TLabel *Label4;
	TLabel *Label5;
	TSpeedButton *GenerateCodeSb;
	TEdit *FileNameEd;
	TButton *BrowseBt;
	TEdit *AccessCodeEd;
	TButton *CreateBt;
	TButton *ResetBt;
	TGroupBox *GroupBox2;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *TotalSlotsLb;
	TLabel *LockedSlotsLb;
	TLabel *InvalidSlotsLb;
	TButton *DeleteBt;
	TOpenDialog *OpenDg;
	TOgMakeCodes *OgMakeCodes1;
	TButton *UpdateBt;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall BrowseBtClick(TObject *Sender);
	void __fastcall AccessCodeEdChange(TObject *Sender);
	void __fastcall FileNameEdChange(TObject *Sender);
	void __fastcall UpdateBtClick(TObject *Sender);
	void __fastcall CreateBtClick(TObject *Sender);
	void __fastcall ResetBtClick(TObject *Sender);
	void __fastcall DeleteBtClick(TObject *Sender);
	void __fastcall GenerateCodeSbClick(TObject *Sender);
private:	// User declarations
	TKey Key;
  bool UpdateInfoLabels(const String FileName);
  int NumberOfSlots(const String Str);
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
