unit Exrgstru;
{$H+}

interface

uses
  SysUtils,Classes,Controls,
  Forms, Dialogs, OnGuard, StdCtrls, Buttons,LResources,

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
    OgRegistrationCode1: TOgRegistrationCode;
    Label1: TLabel;
    procedure OgRegistrationCode1GetKey(Sender: TObject; var Key: TKey);
    procedure OgRegistrationCode1GetCode(Sender: TObject; var Code: TCode);
    procedure OgRegistrationCode1Checked(Sender: TObject;
      Status: TCodeStatus);
  private
    { Private declarations }
  public
    { Public declarations }
    TheDir,
    CodeStr,
    ARegStr    : string;
    IniFile    : TIniFile;
    ED         : TDateTime;
  end;

var
  Form1: TForm1;

implementation



{=======================================================================}

procedure TForm1.OgRegistrationCode1GetKey(Sender: TObject; var Key: TKey);
begin
  Key := CKey;
end;

{=======================================================================}

procedure TForm1.OgRegistrationCode1GetCode(Sender: TObject; var Code: TCode);
var
  L : integer;
begin
  TheDir := ExtractFilePath(ParamStr(0));
{
  L := Length(TheDir);
  if (L > 3) and (TheDir[L] <> '\') then
    TheDir := TheDir + '\';
    }

  if FileExists(TheDir + 'RegCode.ini') then begin
    IniFile := TIniFile.Create(TheDir + 'RegCode.ini');
    try
      CodeStr := IniFile.ReadString('Codes', 'RegCode', '');
      HexToBuffer(CodeStr, Code, SizeOf(Code));

      ARegStr := IniFile.ReadString('Codes', 'RegStr', '');
    finally
      IniFile.Free;
    end;
  end;
end;

{=======================================================================}

procedure TForm1.OgRegistrationCode1Checked(Sender: TObject; Status: TCodeStatus);
var
  S,
  C1 : string;
  TC : TCode;
begin
  {forced cutoff date }
  ED := EncodeDate(2009, 12, 31);

  case Status of
    ogValidCode   : begin
                      InitRegCode(CKey, ARegStr, ED, TC);
                      C1 := BufferToHex(TC, SizeOf(TC));

                      if (CompareText(C1, CodeStr) <> 0) then begin
                        ShowMessage('The Registration Name has been changed');
                        Application.Terminate;
                      end else
                        Label1.Caption := 'Registered to: ' + ARegStr;
                    end;

    ogInvalidCode : begin
                      if not FileExists(TheDir + 'RegCode.ini') then begin
                        if (InputQuery('Codes', 'Reg String', ARegStr)) then begin
                          if (ARegStr = '') then begin
                            S := 'Empty string not allowed';
                            Application.Terminate;
                          end else begin
                            IniFile := TIniFile.Create(TheDir + 'RegCode.ini');
                            try
                              IniFile.WriteString('Codes', 'RegStr', ARegStr);

                              InitRegCode(CKey, ARegStr, ED, TC);

                              {save string representation of release code to Ini File}
                              CodeStr := BufferToHex(TC, SizeOf(TC));
                              IniFile.WriteString('Codes', 'RegCode', CodeStr);
                            finally
                              IniFile.Free;
                            end;
                            OgRegistrationCode1.CheckCode(True);
                            Exit;
                          end;
                        end else
                          Application.Terminate;
                      end else
                        S := 'Invalid Code';
                    end;

    ogCodeExpired : S := 'Evaluation period expired';
  end;

  if (Status <> ogValidCode) then begin
    ShowMessage(S);
    Application.Terminate;
  end;
end;


initialization
{$i exrgstru.lrs}

end.
