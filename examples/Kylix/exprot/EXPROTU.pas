unit EXPROTU;

interface

uses
  {$IFDEF MSWINDOWS} Windows, Messages, {$ENDIF}
  {$IFDEF LINUX} Libc, {$ENDIF}
  {$IFDEF UsingCLX} Types, {$ENDIF}
  SysUtils, Classes,
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons,
  onguard, ogutil, ogproexe;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    CloseBtn: TBitBtn;
    StatusLbl: TLabel;
    OgProtectExe1: TOgProtectExe;
    procedure OgProtectExe1Checked(Sender: TObject; Status: TExeStatus);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.OgProtectExe1Checked(Sender: TObject; Status: TExeStatus);
var
  S : string;
begin
  case Status of
    exeSuccess         : S := 'EXE file is OK';
    exeSizeError       : S := 'EXE file size has changed';
    exeIntegrityError  : S := 'EXE Integrity Error';
    exeNotStamped      : S := 'EXE file is not stamped';
  else
    S := 'Unknown error';
  end;
  StatusLbl.Caption := S;
end;

end.
