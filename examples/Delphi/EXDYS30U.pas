(*
  This program uses the TOgDaysCode component. The first time the
  program is run, the necessary information is created and stored
  in an INI file. In addition, the program is given a "drop dead"
  date, i.e., regardless of how many days the program has been used,
  it cannont be used after that date (1999 December 31).
*)
unit Exdys30u;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, OnGuard, StdCtrls, Buttons,

  OgUtil,
  IniFiles;

const
  CKey : TKey = ($E5,$8F,$84,$D6,$92,$C9,$A4,$D8,
                 $1A,$FA,$6F,$8D,$AB,$FC,$DF,$B4);

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    CloseBtn: TBitBtn;
    OgDaysCode1: TOgDaysCode;
    Label1: TLabel;
    procedure OgDaysCode1GetKey(Sender: TObject; var Key: TKey);
    procedure OgDaysCode1GetCode(Sender: TObject; var Code: TCode);
    procedure OgDaysCode1ChangeCode(Sender: TObject; Code: TCode);
    procedure OgDaysCode1Checked(Sender: TObject; Status: TCodeStatus);
  private
    { Private declarations }
  public
    { Public declarations }
    TheDir  : string;
    IniFile : TIniFile;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{==========================================================================}

procedure TForm1.OgDaysCode1GetKey(Sender: TObject; var Key: TKey);
begin
  Key := CKey;
end;

{==========================================================================}

procedure TForm1.OgDaysCode1GetCode(Sender: TObject; var Code: TCode);
var
  S       : string;
  Expires : TDateTime;
  L       : integer;
begin
  {force the INI file to be in the same directory as the application}
  TheDir := ExtractFilePath(ParamStr(0));
  L := Length(TheDir);
  if (L > 3) and (TheDir[L] <> '\') then
    TheDir := TheDir + '\';

  {open Ini File}
  IniFile := TIniFile.Create(TheDir + 'Days30.INI');
  try
    {try to read release code}
    S := IniFile.ReadString('Codes', 'DaysCode', 'NoCode');

    {If default string returned, create code on the fly}
    if (S = 'NoCode') then begin
      {force absolute ("drop dead") expiration date of 1999 Dec. 31}
      Expires := EncodeDate(1999, 12, 31);
      InitDaysCode(CKey, 30, Expires, Code);

      {save string representation of release code to Ini File}
      S := BufferToHex(Code, SizeOf(Code));
      IniFile.WriteString('Codes', 'DaysCode', S);
    end else
      {convert retrieved string to a code}
      HexToBuffer(S, Code, SizeOf(Code));
  finally
    IniFile.Free;
  end;
end;

{==========================================================================}

procedure TForm1.OgDaysCode1ChangeCode(Sender: TObject; Code: TCode);
var
  S       : string;
begin
  IniFile := TIniFile.Create(TheDir + 'Days30.INI');
  try
    {convert Code to string for writing to INI file}
    S := BufferToHex(Code, SizeOf(Code));
    IniFile.WriteString('Codes', 'DaysCode', S);
  finally
    IniFile.Free;
  end;
end;

{==========================================================================}

procedure TForm1.OgDaysCode1Checked(Sender: TObject; Status: TCodeStatus);
var
  S : string;
begin
  case Status of
    ogValidCode    : begin
                       Label1.Caption := 'Days Remaining: '
                                       + IntToStr(OgDaysCode1.GetValue);
                       Exit;
                     end;

    ogInvalidCode  : S := 'Invalid Code';

    ogDayCountUsed : S := 'Program used more than 30 days' + #13 +
                          'Please register NOW';

    ogCodeExpired  : S := 'Evaluation period expired' + #13 +
                          'Please register NOW';
  end;
  ShowMessage(S);
  Application.Terminate;
end;

end.
