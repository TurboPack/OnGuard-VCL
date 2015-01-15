unit ExSpNamu;

interface

uses
  SysUtils, Classes,Controls, Forms, Dialogs,
  StdCtrls,Buttons,LResources;

type

  { TForm1 }

  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtUserName1: TEdit;
    btnGenCode: TButton;
    edtCode1: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    edtUserName2: TEdit;
    edtCode2: TEdit;
    Label3: TLabel;
    btnCheckCode: TButton;
    lblCheckResult: TLabel;
    procedure btnGenCodeClick(Sender: TObject);
    procedure btnCheckCodeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



uses
  OnGuard, OgUtil;

const
  Key : TKey = ($E8,$B5,$DF,$7F,$F7,$01,$C6,$4A,
                $24,$08,$02,$DC,$B0,$78,$CC,$43);


{ generate unlocking code based on user name }
procedure TForm1.btnGenCodeClick(Sender: TObject);
var
  HashValue : Longint;
  Code : TCode;
begin
  HashValue := StringHashElf(edtUserName1.Text);
  InitSpecialCode(Key, HashValue, Now + 30, Code);
  edtCode1.Text := BufferToHex(Code, SizeOf(Code));
end;

{ check unlocking code against a user name }
procedure TForm1.btnCheckCodeClick(Sender: TObject);
var
  HashValue : Longint;
  Code : TCode;
begin
  HexToBuffer(edtCode2.Text, Code, SizeOf(Code));
  if not IsSpecialCodeValid(Key, Code) then begin
    lblCheckResult.Caption := 'Code Invalid';
    Exit;
  end;
  if IsSpecialCodeExpired(Key, Code) then begin
    lblCheckResult.Caption := 'Code Expired';
    Exit;
  end;
  if GetSpecialCodeValue(Key, Code) <> StringHashElf(edtUserName2.Text) then
    lblCheckResult.Caption := 'User name doesn''t match'
  else
    lblCheckResult.Caption := 'OK';
end;

initialization
{$i exspnamu.lrs}

end.
