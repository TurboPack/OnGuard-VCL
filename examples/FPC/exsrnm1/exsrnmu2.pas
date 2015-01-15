{form used for Serial Number/ReleaseCode input}
unit Exsrnmu2;

interface

uses
  SysUtils,Classes,Controls,
  Forms, Dialogs, StdCtrls, Buttons,LResources;

type
  TSNEntryDlg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SNText: TEdit;
    CodeText: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label3: TLabel;
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SNEntryDlg: TSNEntryDlg;

implementation



procedure TSNEntryDlg.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

initialization
{$i exsrnmu2.lrs}

end.
