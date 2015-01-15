unit reg_main;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes,Controls, Forms, Dialogs,
  StdCtrls,Buttons,LResources;

type

  { TregMain }

  TregMain = class(TForm)
    Label1: TLabel;
    edtSerial: TEdit;
    Memo1: TMemo;
    Label2: TLabel;
    edtMachine: TEdit;
    Label3: TLabel;
    edtRelease: TEdit;
    btnSave: TButton;
    btnReadme: TButton;
    procedure Memo1Enter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnReadmeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  regMain: TregMain;

implementation

uses
  uni_RegCommon, frm_Readme;



procedure TregMain.FormActivate(Sender: TObject);
begin
  edtMachine.Text := format('%d',[MachineModifier]);
end;

procedure TregMain.Memo1Enter(Sender: TObject);
begin
  edtSerial.SetFocus;
end;

procedure TregMain.btnSaveClick(Sender: TObject);
var
  SerialNum : longint;
begin
  // Validate the serial number
  try
    SerialNum := StrToInt(edtSerial.Text);
  except
    MessageDlg('Invalid Serial Number.  Please check your entry and try again.', mtError, [mbOK], 0);
    edtSerial.SetFocus;
    edtSerial.SelectAll;
    exit;
  end;

  // Validate the release code
  if not IsReleaseCodeValid (edtRelease.Text, SerialNum) then begin
    MessageDlg('Invalid Release Code.  Please check your entry and try again.', mtError, [mbOK], 0);
    edtRelease.SetFocus;
    edtRelease.Text := '';
    exit;
  end else begin
    MessageDlg('Registration complete.', mtInformation, [mbOK], 0);
    SaveRegistrationInformation(edtRelease.Text, SerialNum);
    Close;
  end;
end;

procedure TregMain.btnReadmeClick(Sender: TObject);
begin
  frmReadme.Show;
end;


initialization
{$i reg_main.lrs}


end.
