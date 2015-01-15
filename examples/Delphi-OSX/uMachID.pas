unit uMachID;

interface


uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Menus,
  FMX.Grid,
  FMX.ExtCtrls,
  FMX.ListBox,
  FMX.TreeView,
  FMX.Memo,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Edit,
  FMX.Platform,
  Fmx.StdCtrls,
  FMX.Header,
  FMX.Graphics;

type
  TfrmExMachineID = class(TForm)
    GroupBox1: TGroupBox;
    chkUser: TCheckBox;
    chkSystem: TCheckBox;
    chkNetwork: TCheckBox;
    chkDrives: TCheckBox;
    btnGenerate: TButton;
    edtMachineID: TEdit;
    ChkCPU: TCheckBox;
    ChkBIOS: TCheckBox;
    ChkWinProd: TCheckBox;
    ChkCryptoID: TCheckBox;
    ChkNetMAC: TCheckBox;
    ChkDomain: TCheckBox;
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExMachineID: TfrmExMachineID;

implementation

{$R *.FMX}

uses
  OnGuard, OgUtil;

procedure TfrmExMachineID.btnGenerateClick(Sender: TObject);
var
  InfoSet : TEsMachineInfoSet;
  MachineID : Longint;
begin
  { initialize the machine information set }
  InfoSet := [];
  if chkUser.IsChecked then
    InfoSet := InfoSet + [midUser];
  if chkSystem.IsChecked then
    InfoSet := InfoSet + [midSystem];
  if chkNetwork.IsChecked then
    InfoSet := InfoSet + [midNetwork];
  if chkDrives.IsChecked then
    InfoSet := InfoSet + [midDrives];

  if chkCPU.IsChecked then
    InfoSet := InfoSet + [midCPUID];
  if chkBIOS.IsChecked then
    InfoSet := InfoSet + [midBIOS];
  if chkWinProd.IsChecked then
    InfoSet := InfoSet + [midWinProd];
  if chkCryptoID.IsChecked then
    InfoSet := InfoSet + [midCryptoID];
  if chkNetMAC.IsChecked then
    InfoSet := InfoSet + [midNetMAC];
  if chkDomain.IsChecked then
    InfoSet := InfoSet + [midDomain];

  { create the machine ID and display in hex }
  MachineID := CreateMachineID(InfoSet);
  edtMachineID.Text := '$' + BufferToHex(MachineID, SizeOf(MachineID));
end;

end.
 
