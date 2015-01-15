(*
  This example uses the TOgDateCode component. The beginning of the
  allowed date range is automatically set to the date the program
  is first run and the expiration date 21 days thereafter
*)
unit Exdtp21u;

interface

uses
  SysUtils,Classes,Controls,
  Forms, Dialogs, StdCtrls, Buttons,LResources, OnGuard,
  OgUtil,
  IniFiles;

const
  CKey : TKey = ($E5,$8F,$84,$D6,$92,$C9,$A4,$D8,
                 $1A,$FA,$6F,$8D,$AB,$FC,$DF,$B4);

type

  { TForm1 }

  TForm1 = class(TForm)
    Memo1: TMemo;
    CloseBtn: TBitBtn;
    OgDateCode1: TOgDateCode;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure OgDateCode1GetKey(Sender: TObject; var Key: TKey);
    procedure OgDateCode1GetCode(Sender: TObject; var Code: TCode);
    procedure OgDateCode1Checked(Sender: TObject; Status: TCodeStatus);
  private
    FExpired : Boolean;
  public
    TheDir : string;
  end;

var
  Form1: TForm1;

implementation



{==========================================================================}

procedure TForm1.OgDateCode1GetKey(Sender: TObject; var Key: TKey);
begin
  Key := CKey;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if FExpired then Application.Terminate;
end;

procedure TForm1.Memo1DblClick(Sender: TObject);
begin
      ShowMessage(Inttostr(OgDateCode1.GetInvalidCount));
end;

{==========================================================================}

procedure TForm1.OgDateCode1GetCode(Sender: TObject; var Code: TCode);
var
  IniFile : TIniFile;
  S       : string;
  SD,
  ED      : TDateTime;
  L       : integer;
begin
  {force the INI file to be in the same directory as the application}
  TheDir := ExtractFilePath(ParamStr(0));

  {open Ini File}
  IniFile := TIniFile.Create(TheDir + 'datep21.ini');
  try
    {try to read release code}
    S := IniFile.ReadString('Codes', 'DateCode', '');

    {If default string returned, create code on the fly}
    if (S = '') then begin
      SD := Date;
      ED := SD + 21.0;
      InitDateCode(CKey, SD, ED, Code,1);

      {save string representation of release code to Ini File}
      S := BufferToHex(Code, SizeOf(Code));
      IniFile.WriteString('Codes', 'DateCode', S);
    end else
      {convert retrieved string to a code}
      HexToBuffer(S, Code, SizeOf(Code))
  finally
    IniFile.Free;
  end;
end;

{==========================================================================}

procedure TForm1.OgDateCode1Checked(Sender: TObject; Status: TCodeStatus);
var
  S  : string;
begin
  FExpired := false;
  ShortDateFormat := 'yyy-mm-dd';
  case Status of
    ogValidCode   : begin
                      Label1.Caption := 'Expires: '
                                      + DateToStr(OgDateCode1.GetValue);
                      Exit;
                    end;

    ogPastEndDate : S := 'Past 21 days - please register';

    ogInvalidCode : S := 'Invalid Code';
  end;
  ShowMessage(S);
  FExpired := true;
end;

initialization
{$i exdtp21u.lrs}

end.
