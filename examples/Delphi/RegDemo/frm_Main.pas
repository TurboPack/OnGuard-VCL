unit frm_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    btnReadme: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnReadmeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uni_RegCommon, frm_Readme;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ReleaseCodeString: string;
  var SerialNumber : longint;
begin
  GetRegistrationInformation (ReleaseCodeString, SerialNumber);
  if not IsReleaseCodeValid (ReleaseCodeString, SerialNumber) then
    Label1.Caption := 'Unregistered Demo!'
  else
    Label1.Caption := 'Hello World!';
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnReadmeClick(Sender: TObject);
begin
  frmReadme.Show;
end;

end.
