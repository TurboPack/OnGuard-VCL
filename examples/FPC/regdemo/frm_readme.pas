unit frm_Readme;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls,LResources;

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



procedure TfrmReadme.FormActivate(Sender: TObject);
begin
  Memo1.WordWrap := True;
end;

initialization
{$i frm_readme.lrs}


end.
