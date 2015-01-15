unit uMachID;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmExMachineID = class(TForm)
    GroupBox1: TGroupBox;
    chkUser: TCheckBox;
    chkSystem: TCheckBox;
    chkNetwork: TCheckBox;
    chkDrives: TCheckBox;
    btnGenerate: TButton;
    edtMachineID: TEdit;
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExMachineID: TfrmExMachineID;

implementation

{$R *.DFM}

uses
  OnGuard, OgUtil;

procedure TfrmExMachineID.btnGenerateClick(Sender: TObject);
var
  InfoSet : TEsMachineInfoSet;
  MachineID : Longint;
begin
  { initialize the machine information set }
  InfoSet := [];
  if chkUser.Checked then
    InfoSet := InfoSet + [midUser];
  if chkSystem.Checked then
    InfoSet := InfoSet + [midSystem];
  if chkNetwork.Checked then
    InfoSet := InfoSet + [midNetwork];
  if chkDrives.Checked then
    InfoSet := InfoSet + [midDrives];

  { create the machine ID and display in hex }
  MachineID := CreateMachineID(InfoSet);
  edtMachineID.Text := '$' + BufferToHex(MachineID, SizeOf(MachineID));
end;

end.
 