unit rcg_Main;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes,Controls, Forms, Dialogs,
  Buttons, StdCtrls,LResources, OnGuard, OgUtil, ExtCtrls;

type

  { TrcgMain }

  TrcgMain = class(TForm)
    OgMakeKeys1: TOgMakeKeys;

    lblAppKey: TLabel;
    edtAppKey: TEdit;

    chkMachMod: TCheckBox;
    edtMachineMod: TEdit;

    edtSerialNumber: TEdit;
    lblSerialNumber: TLabel;

    lblReleaseCode: TLabel;
    edtReleaseCode: TEdit;

    Bevel1: TBevel;
    btnExit: TButton;
    chkExpires: TCheckBox;
    edtExpires: TEdit;
    spdAppKey: TBitBtn;
    spdReleaseCode: TBitBtn;
    btnReadme: TButton;

    procedure spdAppKeyClick(Sender: TObject);
    procedure chkMachModClick(Sender: TObject);
    procedure spdReleaseCodeClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure chkExpiresClick(Sender: TObject);
    procedure edtAppKeyChange(Sender: TObject);
    procedure btnReadmeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ApplicationKey : TKey;
  end;

var
  rcgMain: TrcgMain;

implementation



uses
  frm_Readme;

procedure TrcgMain.spdAppKeyClick(Sender: TObject);
begin
  if OgMakeKeys1.Execute then begin
    OgMakeKeys1.GetKey(ApplicationKey);
    edtAppKey.Text := BufferToHex(ApplicationKey, sizeof(ApplicationKey));
  end;
end;

procedure TrcgMain.chkMachModClick(Sender: TObject);
begin
  edtMachineMod.Enabled := chkMachMod.Checked;
  if edtMachineMod.Enabled then begin
    edtMachineMod.SetFocus;
    edtMachineMod.SelectAll;
  end;
end;

procedure TrcgMain.chkExpiresClick(Sender: TObject);
begin
  edtExpires.Enabled := chkExpires.Checked;
  if edtExpires.Enabled then begin
    edtExpires.SetFocus;
    edtExpires.SelectAll;
  end;
end;

procedure TrcgMain.spdReleaseCodeClick(Sender: TObject);
var
  Key : TKey;
  Modifier : longint;
  SerialNum : longint;
  Expires : TDateTime;
  ReleaseCode : TCode;
  CodeString : string;
begin
  edtReleaseCode.Text := '';

  // Get the key that will be used to generate the ReleaseCode
  Key := ApplicationKey;
  if chkMachMod.Checked then
    try
      Modifier := StrToInt(edtMachineMod.Text);
      ApplyModifierToKeyPrim(Modifier, Key, sizeof(Key));
    except
      MessageDlg('Invalid Machine Modifier.  Please check your entry and try again.', mtError, [mbOK], 0);
      exit;
    end;

  // Get the expiration date
  if chkExpires.Checked then
    try
      Expires := StrToDate(edtExpires.Text);
    except
      MessageDlg('Invalid Expiration Date.  Please check your entry and try again.', mtError, [mbOK], 0);
      exit;
    end
  else
    Expires := 0;

  // Get the serial number
  try
    SerialNum := StrToInt(edtSerialNumber.Text);
  except
    MessageDlg('Invalid Serial Number.  Please check your entry and try again.', mtError, [mbOK], 0);
    exit;
  end;

  // Create the release code for the data givien
  InitSerialNumberCode(Key, SerialNum, Expires, ReleaseCode);
  CodeString := BufferToHex(ReleaseCode, sizeof(ReleaseCode));

  // Insert spaces in the release code string for easier reading
  System.Insert(' ', CodeString, 13);
  System.Insert(' ', CodeString, 09);
  System.Insert(' ', CodeString, 05);
  edtReleaseCode.Text := CodeString;
end;

procedure TrcgMain.edtAppKeyChange(Sender: TObject);
begin
  edtReleaseCode.Text := '';
end;

procedure TrcgMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TrcgMain.btnReadmeClick(Sender: TObject);
begin
  frmReadme.Show;
end;


initialization
{$i rcg_main.lrs}

end.
