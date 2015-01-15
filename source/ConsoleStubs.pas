(**
   ConsoleStubs.pas

   used when making console based applications with Kylix since
   many useful functions link in X11 or QT and we do not always
   want this to happen.

   Contributions
   -------------
   Jul 12 2002 ??:??  Jeremy Blythe (jeremy@pharos-comms.tele2.co.uk)
                      original release for use in IB Objects port to Kylix

   Jan 07 2004 21:30  Andrew Haines (andrew@haines.name)
                      Added TModalResult values

   Jan 22 2004 09:54  Andrew Haines (andrew@haines.name)
                      added #DEFINE ConsoleUseSysLog for optional usage of syslog
                      altered MessageDlg to dump to syslog.
                      altered Application.ShowException to dump to syslog

**)

{#DEFINE ConsoleUseSysLog}

unit ConsoleStubs;

interface

uses
{$IFDEF ConsoleUseSysLog} Libc, Types, {$ENDIF}
  Classes, SysUtils;

type
  TWindowState = (wsNormal, wsMinimized, wsMaximized);
  TColor = -$7FFFFFFF-1..$7FFFFFFF;
  TMsgDlgType = (mtCustom, mtInformation, mtWarning, mtError, mtConfirmation);
  TMsgDlgBtn = (mbNone, mbOk, mbCancel, mbYes, mbNo, mbAbort, mbRetry, mbIgnore);
  TMsgDlgButtons = set of TMsgDlgBtn;
  TGridOption = (goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving,
    goColMoving, goEditing, goTabs, goRowSelect,
    goAlwaysShowEditor, goThumbTracking);
  TGridOptions = set of TGridOption;
  TPenStyle = (psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear);

  TPen = class(TPersistent)
  public
    Color: TColor;
    Style: TPenStyle;
    Width: Integer;
  end;

  TCanvas = class(TPersistent)
  public
    Pen: TPen;
    procedure LineTo(X, Y: Integer);
    procedure MoveTo(X, Y: Integer);
  end;

  TGraphic = class(TPersistent)
  public
    procedure LoadFromStream(Stream: TStream); virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
  end;

  TBitmap = class(TGraphic);

  TPicture = class(TInterfacedPersistent, IStreamPersist)
  public
    Bitmap: TBitmap;
    Graphic: TGraphic;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
  end;

  TForm = class(TComponent)
  public
    Caption : string;
    Visible : boolean;
    WindowState : TWindowState;
    function ShowModal : integer;
  end;

  TMemo = class(TObject)
  public
    Lines : TStrings;
  end;

  TTabSheet = class(TObject)
  public
    TabVisible : boolean;
  end;

  TPageControl = class(TObject)
  public
    ActivePage : TTabSheet;
  end;

  TdlgError = class(TForm)
  public
    pcError: TPageControl;
    tsErrorMsg: TTabSheet;
    meError: TMemo;
    tsSQLMsg: TTabSheet;
    meSQLMsg: TMemo;
    tsSQL: TTabSheet;
    meSQL: TMemo;
  end;

  TLabel = class(TObject)
    Caption : string;
  end;

  TEdit = class(TObject)
  public
    Text : string;
  end;

  TBitBtn = class(TObject)
  public
    HelpContext : integer;
    Visible : boolean;
  end;

  TComboBox = class(TObject)
  public
    Text : string;
    Items : TStrings;
  end;

  TdlgCancelQuery = class(TForm)
  public
    //CancelBtn: TButton;
    //Bevel1: TBevel;
    //lbFetchingMessage: TLabel;
    lbRowNum: TLabel;
    DatasetToAbort: pointer;
  end;

  TdlgLogin = class( TForm )
  public
    //lbPassword: TLabel;
    edPassword: TEdit;
    //lbDatabase: TLabel;
    //lbUser: TLabel;
    edDatabase: TEdit;
    edUserName: TEdit;
    //Bevel1: TBevel;
    //lbSQLRole: TLabel;
    HelpBtn: TBitBtn;
    //OKBtn: TBitBtn;
    //CancelBtn: TBitBtn;
    cbSQLRole: TComboBox;
    //Image1: TImage;
    DatabaseReadOnly: boolean;
  end;

  TScreen = class(TComponent)
  public
    Cursor : integer;
  end;

  TApplication = class(TComponent)
  {
  private
    FTerminated: Boolean;
    FActive: Boolean;
    FOnException: TExceptionEvent;
    FTitle: WideString;
    FIdleTimer: TComponent;
    FStyle: TApplicationStyle;
    FOnDeactivate: TNotifyEvent;
    FOnActivate: TNotifyEvent;
    FOnEvent: TEventEvent;
    FOnActionExecute: TActionEvent;
    FOnActionUpdate: TActionEvent;
    function ExecuteActionNotification(Action: TBasicAction): Boolean;
    function UpdateActionNotification(Action: TBasicAction): Boolean;
    procedure DoActionIdle;
    procedure DoDeactivate;
    procedure DoActivate;
    procedure StyleChanged(Sender: TObject);
    procedure SetTitle(const Value: WideString);
    function GetStyle: TApplicationStyle;
    procedure SetStyle(const Value: TApplicationStyle);
    procedure Quit;
    function GetExeName: string;
  protected
    procedure Idle(Sender: TObject); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure HandleException(Sender: TObject);
    procedure Initialize;
    function MessageBox(const Text: WideString; const Caption: WideString = '';
      Buttons: TMessageButtons = [smbOK]; Style: TMessageStyle = smsInformation;
      Default: TMessageButton = smbOK; Escape: TMessageButton = smbCancel): TMessageButton;
    procedure ProcessMessages;
    procedure Run;
    procedure ShowException(E: Exception);
    procedure Terminate;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Active: Boolean read FActive;
    property ExeName: string read GetExeName;
    property Style: TApplicationStyle read GetStyle write SetStyle;
    property Terminated: Boolean read FTerminated;
    property Title: WideString read FTitle write SetTitle;
    property OnActionExecute: TActionEvent read FOnActionExecute write FOnActionExecute;
    property OnActionUpdate: TActionEvent read FOnActionUpdate write FOnActionUpdate;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnEvent: TEventEvent read FOnEvent write FOnEvent;
    property OnException: TExceptionEvent read FOnException write FOnException;
    property OnIdle: TIdleEvent read FOnIdle write FOnIdle;
    }
  public
    Terminated : boolean;
    EXEName : string;
    Title : string;
    procedure HandleException(Sender: TObject);
    procedure ProcessMessages;
    procedure ShowException(E: Exception);
  end;

const
  { Raw rgb values }
  clBlack = TColor($000000);
  clMaroon = TColor($000080);
  clGreen = TColor($008000);
  clOlive = TColor($008080);
  clNavy = TColor($800000);
  clPurple = TColor($800080);
  clTeal = TColor($808000);
  clGray = TColor($808080);
  clSilver = TColor($C0C0C0);
  clRed = TColor($0000FF);
  clLime = TColor($00FF00);
  clYellow = TColor($00FFFF);
  clBlue = TColor($FF0000);
  clFuchsia = TColor($FF00FF);
  clAqua = TColor($FFFF00);
  clLtGray = TColor($C0C0C0);
  clDkGray = TColor($808080);
  clWhite = TColor($FFFFFF);
  clNone = TColor($1FFFFFFF);
  clDefault = TColor($20000000);

  { Base, mapped, pseudo, rgb values }
  clForeground = TColor(-1);
  clButton = TColor(-2);
  clLight = TColor(-3);
  clMidlight = TColor(-4);
  clDark = TColor(-5);
  clMid = TColor(-6);
  clText = TColor(-7);
  clBrightText = TColor(-8);
  clButtonText = TColor(-9);
  clBase = TColor(-10);
  clBackground = TColor(-11);
  clShadow = TColor(-12);
  clHighlight = TColor(-13);
  clHighlightedText = TColor(-14);

  { Mapped role offsets }
  cloNormal = 32;
  cloDisabled = 64;
  cloActive = 96;

  { Normal, mapped, pseudo, rgb values }
  clNormalForeground = TColor(clForeground - cloNormal);
  clNormalButton = TColor(clButton - cloNormal);
  clNormalLight = TColor(clLight - cloNormal);
  clNormalMidlight = TColor(clMidlight - cloNormal);
  clNormalDark = TColor(clDark - cloNormal);
  clNormalMid = TColor(clMid - cloNormal);
  clNormalText = TColor(clText - cloNormal);
  clNormalBrightText = TColor(clBrightText - cloNormal);
  clNormalButtonText = TColor(clButtonText - cloNormal);
  clNormalBase = TColor(clBase - cloNormal);
  clNormalBackground = TColor(clBackground - cloNormal);
  clNormalShadow = TColor(clShadow - cloNormal);
  clNormalHighlight = TColor(clHighlight - cloNormal);
  clNormalHighlightedText = TColor(clHighlightedText - cloNormal);

  { Disabled, mapped, pseudo, rgb values }
  clDisabledForeground = TColor(clForeground - cloDisabled);
  clDisabledButton = TColor(clButton - cloDisabled);
  clDisabledLight = TColor(clLight - cloDisabled);
  clDisabledMidlight = TColor(clMidlight - cloDisabled);
  clDisabledDark = TColor(clDark - cloDisabled);
  clDisabledMid = TColor(clMid - cloDisabled);
  clDisabledText = TColor(clText - cloDisabled);
  clDisabledBrightText = TColor(clBrightText - cloDisabled);
  clDisabledButtonText = TColor(clButtonText - cloDisabled);
  clDisabledBase = TColor(clBase - cloDisabled);
  clDisabledBackground = TColor(clBackground - cloDisabled);
  clDisabledShadow = TColor(clShadow - cloDisabled);
  clDisabledHighlight = TColor(clHighlight - cloDisabled);
  clDisabledHighlightedText = TColor(clHighlightedText - cloDisabled);

  { Active, mapped, pseudo, rgb values }
  clActiveForeground = TColor(clForeground - cloActive);
  clActiveButton = TColor(clButton - cloActive);
  clActiveLight = TColor(clLight - cloActive);
  clActiveMidlight = TColor(clMidlight - cloActive);
  clActiveDark = TColor(clDark - cloActive);
  clActiveMid = TColor(clMid - cloActive);
  clActiveText = TColor(clText - cloActive);
  clActiveBrightText = TColor(clBrightText - cloActive);
  clActiveButtonText = TColor(clButtonText - cloActive);
  clActiveBase = TColor(clBase - cloActive);
  clActiveBackground = TColor(clBackground - cloActive);
  clActiveShadow = TColor(clShadow - cloActive);
  clActiveHighlight = TColor(clHighlight - cloActive);
  clActiveHighlightedText = TColor(clHighlightedText - cloActive);

  clFirstSpecialColor = clActiveHighlightedText;

  { Compatiblity colors }
  clScrollBar = clButton;
  clActiveCaption = clActiveHighlightedText;
  clInactiveCaption = clDisabledHighlightedText;
  clMenu = clMid;
  clWindow = clBase;
  clWindowFrame = clHighlight;
  clMenuText = clButtonText;
  clWindowText = clText;
  clCaptionText = clHighlightedText;
  clActiveBorder = clActiveHighlight;
  clInactiveBorder = clDisabledHighlight;
  clAppWorkSpace = clMid;
  clBtnFace = clButton;
  clBtnShadow = clDark;
  clGrayText = clLight;
  clBtnText = clButtonText;
  clInactiveCaptionText = clDisabledHighlightedText;
  clBtnHighlight = clActiveLight;
  cl3DDkShadow = clMid;
  cl3DLight = clMidLight;
  clInfoText = clText;
  clInfoBk = TColor($E1FFFF);
  clHighlightText = clHighlightedText;

{$IFDEF MSWINDOWS}
  clMask = clWhite;
  clDontMask = clBlack;
{$ENDIF}
{$IFDEF LINUX}
  clMask = clBlack;
  clDontMask = clWhite;
{$ENDIF}

  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  mbYesNo = [mbYes, mbNo];
  mbOKCancel = [mbOK, mbCancel];
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];

  { TModalResult values }
  mrNone     = 0;
  mrOk       = mrNone + 1;
  mrCancel   = mrOk + 1;
  mrYes      = mrCancel + 1;
  mrNo       = mrYes + 1;
  mrAbort    = mrNo + 1;
  mrRetry    = mrAbort + 1;
  mrIgnore   = mrRetry + 1;
  mrAll      = mrIgnore + 1;
  mrNoToAll  = mrAll + 1;
  mrYesToAll = mrNoToAll + 1;

function ColorToString(Color: TColor): string;
function StringToColor(const S: string): TColor;
procedure GetColorValues(Proc: TGetStrProc);
function ColorToIdent(Color: Longint; var Ident: string): Boolean;
function IdentToColor(const Ident: string; var Color: Longint): Boolean;

function MessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

procedure StartConsoleMode;

var
  Application : TApplication;
  Screen : TScreen;
  HelpFile : string;

implementation

procedure StartConsoleMode;
begin
  Application := TApplication.Create(nil);
  Screen := TScreen.Create(nil);
end;

function MessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  //
  {$IFDEF ConsoleUseSysLog}
  case DlgType of
   mtInformation:
                  begin
                   syslog(LOG_INFO, PChar(Msg));
                  end;
   mtWarning:
                  begin
                   syslog(LOG_WARNING, PChar(Msg));
                  end;
   mtError:
                  begin
                   syslog(LOG_ERR, PChar(Msg));
                  end;
  end;
  {$ENDIF}
  Result := mrOK;
end;

{ TApplication }

procedure TApplication.HandleException(Sender: TObject);
begin
  //
end;

procedure TApplication.ProcessMessages;
begin
  //
end;

procedure TApplication.ShowException(E: Exception);
begin
  //
  {$IFDEF ConsoleUseSysLog}
  syslog(LOG_ERR, PChar(E.Message));
  {$ENDIF}
end;

{ TPicture }

procedure TPicture.LoadFromStream(Stream: TStream);
begin
  //
end;

procedure TPicture.SaveToStream(Stream: TStream);
begin
  //
end;

{ TForm }

function TForm.ShowModal: integer;
begin
  //
end;

{ TCanvas }

procedure TCanvas.LineTo(X, Y: Integer);
begin
  //
end;

procedure TCanvas.MoveTo(X, Y: Integer);
begin
  //
end;

const
  Colors: array[0..96] of TIdentMapEntry = (
    (Value: clBlack; Name: 'clBlack'),
    (Value: clMaroon; Name: 'clMaroon'),
    (Value: clGreen; Name: 'clGreen'),
    (Value: clOlive; Name: 'clOlive'),
    (Value: clNavy; Name: 'clNavy'),
    (Value: clPurple; Name: 'clPurple'),
    (Value: clTeal; Name: 'clTeal'),
    (Value: clGray; Name: 'clGray'),
    (Value: clSilver; Name: 'clSilver'),
    (Value: clRed; Name: 'clRed'),
    (Value: clLime; Name: 'clLime'),
    (Value: clYellow; Name: 'clYellow'),
    (Value: clBlue; Name: 'clBlue'),
    (Value: clFuchsia; Name: 'clFuchsia'),
    (Value: clAqua; Name: 'clAqua'),
    (Value: clWhite; Name: 'clWhite'),
    (Value: clNone; Name: 'clNone'),
    (Value: clDefault; Name: 'clDefault'),    
    (Value: clBackground; Name: 'clBackground'),
    (Value: clHighlight; Name: 'clHighlight'),
    (Value: clHighlightText; Name: 'clHighlightText'),
    (Value: clForeground; Name: 'clForeground'),
    (Value: clButton; Name: 'clButton'),
    (Value: clLight; Name: 'clLight'),
    (Value: clMidlight; Name: 'clMidlight'),
    (Value: clDark; Name: 'clDark'),
    (Value: clMid; Name: 'clMid'),
    (Value: clText; Name: 'clText'),
    (Value: clBrightText; Name: 'clBrightText'),
    (Value: clButtonText; Name: 'clButtonText'),
    (Value: clBase; Name: 'clBase'),
    (Value: clShadow; Name: 'clShadow'),
    (Value: clNormalForeground; Name: 'clNormalForeground'),
    (Value: clNormalButton; Name: 'clNormalButton'),
    (Value: clNormalLight; Name: 'clNormalLight'),
    (Value: clNormalMidlight; Name: 'clNormalMidlight'),
    (Value: clNormalDark; Name: 'clNormalDark'),
    (Value: clNormalMid; Name: 'clNormalMid'),
    (Value: clNormalText; Name: 'clNormalText'),
    (Value: clNormalBrightText; Name: 'clNormalBrightText'),
    (Value: clNormalButtonText; Name: 'clNormalButtonText'),
    (Value: clNormalBase; Name: 'clNormalBase'),
    (Value: clNormalBackground; Name: 'clNormalBackground'),
    (Value: clNormalShadow; Name: 'clNormalShadow'),
    (Value: clNormalHighlight; Name: 'clNormalHighlight'),
    (Value: clNormalHighlightedText; Name: 'clNormalHighlightedText'),
    (Value: clDisabledForeground; Name: 'clDisabledForeground'),
    (Value: clDisabledButton; Name: 'clDisabledButton'),
    (Value: clDisabledLight; Name: 'clDisabledLight'),
    (Value: clDisabledMidlight; Name: 'clDisabledMidlight'),
    (Value: clDisabledDark; Name: 'clDisabledDark'),
    (Value: clDisabledMid; Name: 'clDisabledMid'),
    (Value: clDisabledText; Name: 'clDisabledText'),
    (Value: clDisabledBrightText; Name: 'clDisabledBrightText'),
    (Value: clDisabledButtonText; Name: 'clDisabledButtonText'),
    (Value: clDisabledBase; Name: 'clDisabledBase'),
    (Value: clDisabledBackground; Name: 'clDisabledBackground'),
    (Value: clDisabledShadow; Name: 'clDisabledShadow'),
    (Value: clDisabledHighlight; Name: 'clDisabledHighlight'),
    (Value: clDisabledHighlightedText; Name: 'clDisabledHighlightedText'),
    (Value: clActiveForeground; Name: 'clActiveForeground'),
    (Value: clActiveButton; Name: 'clActiveButton'),
    (Value: clActiveLight; Name: 'clActiveLight'),
    (Value: clActiveMidlight; Name: 'clActiveMidlight'),
    (Value: clActiveDark; Name: 'clActiveDark'),
    (Value: clActiveMid; Name: 'clActiveMid'),
    (Value: clActiveText; Name: 'clActiveText'),
    (Value: clActiveBrightText; Name: 'clActiveBrightText'),
    (Value: clActiveButtonText; Name: 'clActiveButtonText'),
    (Value: clActiveBase; Name: 'clActiveBase'),
    (Value: clActiveBackground; Name: 'clActiveBackground'),
    (Value: clActiveShadow; Name: 'clActiveShadow'),
    (Value: clActiveHighlight; Name: 'clActiveHighlight'),
    (Value: clActiveHighlightedText; Name: 'clActiveHighlightedText'),
    { compatibility values not shown in Object Inspector }
    (Value: clScrollBar; Name: 'clScrollBar'),
    (Value: clActiveCaption; Name: 'clActiveCaption'),
    (Value: clInactiveCaption; Name: 'clInactiveCaption'),
    (Value: clMenu; Name: 'clMenu'),
    (Value: clWindow; Name: 'clWindow'),
    (Value: clWindowFrame; Name: 'clWindowFrame'),
    (Value: clMenuText; Name: 'clMenuText'),
    (Value: clWindowText; Name: 'clWindowText'),
    (Value: clCaptionText; Name: 'clCaptionText'),
    (Value: clActiveBorder; Name: 'clActiveBorder'),
    (Value: clInactiveBorder; Name: 'clInactiveBorder'),
    (Value: clAppWorkSpace; Name: 'clAppWorkSpace'),
    (Value: clBtnFace; Name: 'clBtnFace'),
    (Value: clBtnShadow; Name: 'clBtnShadow'),
    (Value: clGrayText; Name: 'clGrayText'),
    (Value: clBtnText; Name: 'clBtnText'),
    (Value: clInactiveCaptionText; Name: 'clInactiveCaptionText'),
    (Value: clBtnHighlight; Name: 'clBtnHighlight'),
    (Value: cl3DDkShadow; Name: 'cl3DDkShadow'),
    (Value: cl3DLight; Name: 'cl3DLight'),
    (Value: clInfoText; Name: 'clInfoText'),
    (Value: clInfoBk; Name: 'clInfoBk'),
    (Value: clHighlightedText; Name: 'clHighlightedText'));

procedure GetColorValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(Colors) to 74 do Proc(Colors[I].Name);
end;

function ColorToIdent(Color: Longint; var Ident: string): Boolean;
begin
  Result := IntToIdent(Color, Ident, Colors);
end;

function IdentToColor(const Ident: string; var Color: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Color, Colors);
end;

function ColorToString(Color: TColor): string;
begin
  if not ColorToIdent(Color, Result) then
    FmtStr(Result, '%s%.8x', [HexDisplayPrefix, Color]);
end;

function StringToColor(const S: string): TColor;
begin
  if not IdentToColor(S, Longint(Result)) then
    Result := TColor(StrToInt(S));
end;


initialization
  RegisterIntegerConsts(TypeInfo(TColor), IdentToColor, ColorToIdent);

end.
