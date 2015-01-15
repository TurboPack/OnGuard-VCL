unit Exsnregu;
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes,Controls, Forms, Dialogs,
  StdCtrls, Buttons,LResources, OnGuard, IniFiles, OgUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    CodeBtn: TButton;
    Memo1: TMemo;
    CloseBtn: TBitBtn;
    StatusLbl: TLabel;
    Label1: TLabel;
    CodeLbl: TLabel;
    RemoveBtn: TButton;
    OgSerialNumberCode1: TOgSerialNumberCode;
    procedure CodeChecked(Sender: TObject; Status: TCodeStatus);
    procedure GetKey(Sender: TObject; var Key: TKey);
    procedure GetCode(Sender: TObject; var Code: TCode);
    procedure CodeBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



procedure TForm1.CodeChecked(Sender: TObject; Status: TCodeStatus);
var
  S : string;
begin
  case Status of
    ogValidCode    : S := 'Valid Code - SerialNumber: ' + IntToStr(OgSerialNumberCode1.GetValue);
    ogInvalidCode  : S := 'Invalid release code';
    ogPastEndDate  : S := 'Date has expired';
    ogDayCountUsed : S := 'Zero days of use remaining';
    ogRunCountUsed : S := 'Usage count has expired';
    ogNetCountUsed : S := 'Net usage count exceeded';
    ogCodeExpired  : S := 'Code has expired';
  else
    S := 'Unknown error';
  end;
  StatusLbl.Caption := S;
end;

procedure TForm1.GetKey(Sender: TObject; var Key: TKey);
const
  {this applications' key}
  CKey : TKey = ($E5,$8F,$84,$D6,$92,$C9,$A4,$D8,$1A,$FA,$6F,$8D,$AB,$FC,$DF,$B4);
begin
  Key := CKey;
end;

procedure TForm1.GetCode(Sender: TObject; var Code: TCode);
var
  Ini : TIniFile;
  S   : string;
begin
  Ini := TIniFile.Create('ONGUARD.INI');
  try
    {get the code from the ini file}
    S := Ini.ReadString('Codes', 'SerialNumberCode', '');
    {convert to proper form}
    HexToBuffer(S, Code, SizeOf(Code));
    {set code label caption}
    CodeLbl.Caption := S;
  finally
    Ini.Free;
  end;
end;

procedure TForm1.CodeBtnClick(Sender: TObject);
var
  Ini  : TIniFile;
  Work : TCode;
  S    : string;
begin
  S := '';
  {ask for string and code}
  if InputQuery('Serial Number Code Entry', 'Enter the code', S) then begin
    Ini := TIniFile.Create('ONGUARD.INI');
    try
      {store the code in the ini file if it looks OK}
      if HexToBuffer(S, Work, SizeOf(Work)) then begin
        {save the value}
        Ini.WriteString('Codes', 'SerialNumberCode', S);
        CodeLbl.Caption := S;

        {tell the code component to test the new code, reporting the results}
        OgSerialNumberCode1.CheckCode(True);
      end;
    finally
      Ini.Free;
    end;
  end;
end;

procedure TForm1.RemoveBtnClick(Sender: TObject);
var
  IniFile : TIniFile;
begin
  IniFile := TIniFile.Create('ONGUARD.INI');
  try
    IniFile.DeleteKey('Codes', 'SerialNumberCode');
  finally
    IniFile.Free;
  end;

  {tell the code component to test the new code, reporting the results}
  OgSerialNumberCode1.CheckCode(True);
end;


initialization
{$i exsnregu.lrs}

end.
