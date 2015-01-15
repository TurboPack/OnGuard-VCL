(*
  This example uses the TOgUsageCode component.

  If the program is run the first time, an InputQuery dialog is
  displayed. The user would call you to register. You would give
  them a release code (using, e.g., CODEGEN) for a given number of
  uses and, if desired, "drop date" or some other modifier.
*)

unit Exusg2u;

{$mode objfpc}{$H+}

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
    OgUsageCode2: TOgUsageCode;
    Label1: TLabel;
    procedure OgUsageCode2GetKey(Sender: TObject; var Key: TKey);
    procedure OgUsageCode2GetCode(Sender: TObject; var Code: TCode);
    procedure OgUsageCode2Checked(Sender: TObject; Status: TCodeStatus);
    procedure OgUsageCode2ChangeCode(Sender: TObject; Code: TCode);
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

procedure TForm1.OgUsageCode2GetKey(Sender: TObject; var Key: TKey);
begin
  Key := CKey;
end;

{==========================================================================}

procedure TForm1.OgUsageCode2GetCode(Sender: TObject; var Code: TCode);
var
  S  : string;
  L  : integer;
begin
  TheDir := ExtractFilePath(ParamStr(0));

  if (FileExists(TheDir + 'Usage2.ini')) then begin
    {open Ini File}
    IniFile := TIniFile.Create(TheDir + 'Usage2.ini');
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

procedure TForm1.OgUsageCode2Checked(Sender: TObject; Status: TCodeStatus);
var
  S    : string;
  Code : TCode;
begin
  case Status of
    ogValidCode    : begin
                       Label1.Caption := 'Available Runs: '
                                       + IntToStr(OgUsageCode2.GetValue);
                       Exit;
                     end;

    ogRunCountUsed : S := 'No more runs allowed' + #13
                        + '    Register NOW    ';

    ogInvalidCode  : begin
                       if not (FileExists(TheDir + 'Usage2.ini')) then begin
                         S := '';
                         if (InputQuery('Call Vendor NOW', 'Code', S)) then begin
                           if HexToBuffer(S, Code, SizeOf(Code)) then begin
                             IniFile := TIniFile.Create(TheDir + 'Usage2.ini');
                             try
                               IniFile.WriteString('Codes', 'Uses', S);
                             finally
                               IniFile.Free;
                             end;
                             OgUsageCode2.CheckCode(True);
                             Exit;
                           end else
                             S := 'Invalid Code entered';
                         end else
                           S := 'No Code entered';
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

procedure TForm1.OgUsageCode2ChangeCode(Sender: TObject; Code: TCode);
var
  S : string;
begin
  if not (FileExists(TheDir + 'Usage2.ini')) then
    Exit;

  {open Ini File}
  IniFile := TIniFile.Create(TheDir + 'Usage2.ini');
  try
    {convert code to string}
    S := BufferToHex(Code, SizeOf(Code));
    IniFile.WriteString('Codes', 'Uses', S);
  finally
    IniFile.Free;
  end;
end;


initialization
{$i exusg2u.lrs}


end.

