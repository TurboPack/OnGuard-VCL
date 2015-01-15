//---------------------------------------------------------------------------
#ifndef ExSelCod1H
#define ExSelCod1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "OnGuard.hpp"

  TKey TheKey = {0xF1,0x46,0x8D,0xE4,0x70,0xAE,0x92,0xDC,
                 0x13,0x1A,0x03,0xC4,0x44,0x25,0x72,0xF5};

 //     Feature masks
  int RequiredMask = 0x00000001;
  int HelpMask     = 0x00000002;
  int ExamplesMask = 0x00000004;
  int DBMask       = 0x00000008;
  int FaxMask      = 0x00000010;
  int GoodiesMask  = 0x00000020;

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *GenBtn;
        TEdit *MachineID;
        TGroupBox *GroupBox1;
        TCheckBox *ReqFeat;
        TCheckBox *HelpFeat;
        TCheckBox *ExamplesFeat;
        TCheckBox *DBFeat;
        TCheckBox *FaxFeat;
        TCheckBox *GoodiesFeat;
        TEdit *CodeDisplay;
        void __fastcall GenBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
