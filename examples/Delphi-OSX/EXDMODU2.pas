unit Exdmodu2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.IniFiles,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.Menus,
  FMX.Grid, FMX.ExtCtrls, FMX.ListBox, FMX.TreeView, FMX.Memo, FMX.TabControl,
  FMX.Layouts, FMX.Edit, FMX.Platform, Fmx.StdCtrls, FMX.Header, FMX.Graphics;


type
  TSNEntryDlg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SNText: TEdit;
    CodeText: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label3: TLabel;
    Label4: TLabel;
    ModString: TEdit;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SNEntryDlg: TSNEntryDlg;

implementation

{$R *.FMX}

uses
  OnGuard,
  OgUtil;


procedure TSNEntryDlg.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSNEntryDlg.FormCreate(Sender: TObject);
var
  LI : longint;
begin
  LI := GenerateMachineModifierPrim;
  ModString.Text := BufferToHex(LI, SizeOf(longint));
end;

end.
