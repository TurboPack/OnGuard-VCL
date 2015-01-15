//---------------------------------------------------------------------------
#ifndef ExSelAp1H
#define ExSelAp1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "OnGuard.hpp"
#include <Menus.hpp>

  TKey TheKey = {0xF1,0x46,0x8D,0xE4,0x70,0xAE,0x92,0xDC,
                 0x13,0x1A,0x03,0xC4,0x44,0x25,0x72,0xF5};

 //     Feature masks
  int RequiredMask = 0x00000001;
  int HelpMask     = 0x00000002;
  int ExamplesMask = 0x00000004;
  int DBMask       = 0x00000008;
  int FaxMask      = 0x00000010;
  int GoodiesMask  = 0x00000020;

  // Initial code has 3 uses embedded
  String InitCode         = "13B1A08BD78AFCD3";
  String CodeFile         = "ExSelect.Dat";
  String DemoCaption      = "ExSelApi: Demo runs left = ";
  String RegisteredCap    = "ExSelApi: Registered";
  String NotRegisteredCap = "ExSelApi: Not Registered";

  // Codes
  TCode UsageCode,     // Index = 0
        SpecialCode;   // Index = 1

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TMemo *Memo1;
        TButton *ModifyBtn;
        TMainMenu *MainMenu1;
        TMenuItem *FeaturesMenu;
        TMenuItem *FeaturesRequired;
        TMenuItem *FeaturesHelp;
        TMenuItem *FeaturesExamples;
        TMenuItem *FeaturesDatabase;
        TMenuItem *FeaturesFax;
        TMenuItem *FeaturesGoodies;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall ModifyBtnClick(TObject *Sender);
private:	// User declarations
        bool __fastcall FileGetCode(int Index, TCode &Code);
        void __fastcall FilePutCode(int Index, TCode Code);
        int __fastcall DecodeSpecialCode();
        void __fastcall EnableFeatures(int Features);

public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
