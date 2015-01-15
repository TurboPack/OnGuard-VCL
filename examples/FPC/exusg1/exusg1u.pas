(*
  This example uses the TOgUsageCode component. This is the most basic
  example in that on first run, the INI file entries and component
  properties are set to allow 5 runs of the program with a "drop dead"
  date
*)

unit Exusg1u;

interface

uses
  SysUtils,Classes,Controls,
  Forms, Dialogs, StdCtrls, Buttons, OnGuard,
  LResources,
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
    OgUsageCode1: TOgUsageCode;
    Label1: TLabel;
    procedure OgUsageCode1GetKey(Sender: TObject; var Key: TKey);
    procedure OgUsageCode1GetCode(Sender: TObject; var Code: TCode);
    procedure OgUsageCode1Checked(Sender: TObject; Status: TCodeStatus);
    procedure OgUsageCode1ChangeCode(Sender: TObject; Code: TCode);
  private
    { Private declarations }
  public
    { Public declarations }
    TheDir   : string;
    IniFile     : TIniFile;
  end;

var
  Form1: TForm1;

implementation



{==========================================================================}

procedure TForm1.OgUsageCode1GetKey(Sender: TObject; var Key: TKey);
begin
  Key := CKey;
end;

{==========================================================================}

procedure TForm1.OgUsageCode1GetCode(Sender: TObject; var Code: TCode);
var
  S       : string;
  L       : integer;
begin
  TheDir := ExtractFilePath(ParamStr(0));


  if (FileExists(TheDir + 'Usage1.ini')) then begin
    {open Ini File}
    IniFile := TIniFile.Create(TheDir + 'Usage1.ini');
    try
      {try to read release code}
      S := IniFile.ReadString('Codes', 'Uses', '');

      {convert retrieved string to a code}
      HexToBuffer(S, Code, SizeOf(Code));
    finally
      IniFile.Free;
    end;
  end;
end;

{==========================================================================}

procedure TForm1.OgUsageCode1Checked(Sender: TObject; Status: TCodeStatus);
var
  S    : string;
  Code : TCode;
begin
  case Status of
    ogValidCode    : begin
                       Label1.Caption := 'Available Runs: '
                                       + IntToStr(OgUsageCode1.GetValue);
                       Exit;
                     end;

    ogRunCountUsed : S := 'No more runs allowed' + #13
                        + '    Register NOW    ';

    ogInvalidCode  : begin
                       if not (FileExists(TheDir + 'Usage1.ini')) then begin
                         IniFile := TIniFile.Create(TheDir + 'Usage1.ini');
                         try
                           {hard coded release code for 5 users}
                           {and drop dead date of 2009 Dec. 31}
                           S := 'AECCA5B793AD56155D13';
                           HexToBuffer(S, Code, SizeOf(Code));
                           IniFile.WriteString('Codes', 'Uses', S);
                         finally
                           IniFile.Free;
                         end;
                         OgUsageCode1.CheckCode(True);
                         Exit;
                       end else
                         S := 'Invalid Code';
                     end;

    ogCodeExpired  : S := 'Trial Run period expired' + #13
                        + '      Register NOW      ';
  end;
  ShowMessage(S);
  Application.Terminate;
end;

{==========================================================================}

procedure TForm1.OgUsageCode1ChangeCode(Sender: TObject; Code: TCode);
var
  S : string;
begin
  {open Ini File}
  IniFile := TIniFile.Create(TheDir + 'Usage1.ini');
  try
    {convert code to string}
    S := BufferToHex(Code, SizeOf(Code));
    IniFile.WriteString('Codes', 'Uses', S);
  finally
    IniFile.Free;
  end;
end;


initialization
{$i exusg1u.lrs}

end.

