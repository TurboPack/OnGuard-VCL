//---------------------------------------------------------------------------
#ifndef FixNaf1H
#define FixNaf1H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ExtCtrls.hpp>
#include "OgNetWrk.hpp"
#include "OgUtil.hpp"
#include "OnGuard.hpp"

//---------------------------------------------------------------------------
class TMainFrm : public TForm
{
__published:	// IDE-managed Components
	TGroupBox *GroupBox1;
	TLabel *Label4;
	TLabel *Label5;
	TEdit *AccessCodeEd;
	TPanel *FileNamePn;
	TButton *UpdateBt;
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
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall AccessCodeEdChange(TObject *Sender);
	void __fastcall UpdateBtClick(TObject *Sender);
	void __fastcall CreateBtClick(TObject *Sender);
	void __fastcall ResetBtClick(TObject *Sender);
	void __fastcall DeleteBtClick(TObject *Sender);
private:	// User declarations
	TKey Key;
  bool UpdateInfoLabels(const String FileName);
  int NumberOfSlots(const String Str);
public:		// User declarations
	__fastcall TMainFrm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TMainFrm *MainFrm;
//---------------------------------------------------------------------------
#endif
 