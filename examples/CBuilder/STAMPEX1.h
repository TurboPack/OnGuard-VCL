//---------------------------------------------------------------------------
#ifndef StampEx1H
#define StampEx1H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>
#include <vcl\Dialogs.hpp>
#include "OgProExe.hpp"
//---------------------------------------------------------------------------
class TfrmStamp : public TForm
{
__published:	// IDE-managed Components
	TLabel *StatusLbl;
	TEdit *FileEd;
	TBitBtn *BrowseBtn;
	TBitBtn *StampBtn;
	TBitBtn *CloseBtn;
	TBitBtn *ClearBtn;
	TCheckBox *EraseMarkerCb;
	TOpenDialog *OpenDialog1;
	void __fastcall BrowseBtnClick(TObject *Sender);
	void __fastcall StampBtnClick(TObject *Sender);
	void __fastcall ClearBtnClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FileEdChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TfrmStamp(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TfrmStamp *frmStamp;
//---------------------------------------------------------------------------
#endif
