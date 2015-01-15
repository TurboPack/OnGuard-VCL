unit ExReg1;

interface

uses
  SysUtils, Classes,Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons,LResources, EditBtn;

type

  { TfrmExRegCode }

  TfrmExRegCode = class(TForm)
    edDate: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtUserName1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtRegCode1: TEdit;
    GroupBox2: TGroupBox;
    edtUserName2: TEdit;
    Label4: TLabel;
    edtRegCode2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtStatus: TEdit;
    btnGenerate: TSpeedButton;
    btnVerify: TSpeedButton;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExRegCode: TfrmExRegCode;

implementation



uses
  OnGuard, OgUtil;

const
  EncryptionKey : TKey = ($E5, $8F, $84, $D6, $92, $C9, $A4, $D8,
                          $1A, $FA, $6F, $8D, $AB, $FC, $DF, $B4);


procedure TfrmExRegCode.btnGenerateClick(Sender: TObject);
var
  Key : TKey;
  Code : TCode;
  Modifier : Longint;
  D : TDateTime;
begin
  D := StrToDate(edDate.Text);
  Key := EncryptionKey;
  Modifier := StringHashELF(edtUserName1.Text);
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  InitRegCode(Key, '', D, Code);
  edtRegCode1.Text := BufferToHex(Code, SizeOf(Code));
end;

procedure TfrmExRegCode.btnVerifyClick(Sender: TObject);
var
  Key : TKey;
  Code : TCode;
  Modifier : Longint;
  d : TDateTime;
begin
  Key := EncryptionKey;
  Modifier := StringHashELF(edtUserName2.Text);
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  HexToBuffer(edtRegCode2.Text, Code, SizeOf(Code));
  if IsRegCodeValid(Key, Code) then begin
    if IsRegCodeExpired(Key, Code) then
      edtStatus.Text := 'Expired'
    else
      edtStatus.Text := 'Valid';
  end else
    edtStatus.Text := 'Not Valid';
end;

procedure TfrmExRegCode.FormCreate(Sender: TObject);
begin
  ShortDateFormat := 'yyyy-mm-dd';
  edDate.Text := DateToStr(Now);
end;

initialization
{$i exreg1.lrs}

end.
