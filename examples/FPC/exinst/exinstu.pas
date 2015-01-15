unit EXINSTU;

interface

uses
  SysUtils, Classes, Graphics,
  Forms, Dialogs, StdCtrls, Buttons, Controls,LResources;

type

  { TFirstInstFrm }

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

initialization
{$I exinstu.lrs}

end.
