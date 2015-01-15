unit uMachID;

interface

uses
  SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs,Buttons, StdCtrls,LResources;

type

  { TfrmExMachineID }

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



uses
  onguard, ogutil;

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
  try
  MachineID := CreateMachineID(InfoSet);
  edtMachineID.Text := '$' + BufferToHex(MachineID, SizeOf(MachineID));
  except on E:Exception do
   ShowMessage(E.Message);
  end;
end;

initialization
{$I umachid.lrs}

end.
 
