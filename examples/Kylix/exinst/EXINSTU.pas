unit EXINSTU;

interface

uses
  SysUtils, Classes, QGraphics,
  QForms, QDialogs, QStdCtrls, QButtons, QControls;

type
  TFirstInstFrm = class(TForm)
    Memo1: TMemo;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FirstInstFrm: TFirstInstFrm;

implementation

{$R *.xfm}

end.
