unit Exinstu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons;

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

{$R *.DFM}

end.
