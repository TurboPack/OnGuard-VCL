unit frm_Readme;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmReadme = class(TForm)
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReadme: TfrmReadme;

implementation

{$R *.DFM}

procedure TfrmReadme.FormActivate(Sender: TObject);
begin
  Memo1.WordWrap := True;
end;

end.
