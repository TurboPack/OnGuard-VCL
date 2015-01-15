unit FIXNAF1;

interface

uses
  IniFiles, SysUtils, Forms, Classes, Dialogs,
  StdCtrls, Controls, ExtCtrls,Buttons,LResources,onguard, ognetwrk, ogutil;

type

  { TMainFrm }

  TMainFrm = class(TForm)
    GroupBox1: TGroupBox;
    UpdateBt: TButton;
    CreateBt: TButton;
    ResetBt: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TotalSlotsLb: TLabel;
    LockedSlotsLb: TLabel;
    InvalidSlotsLb: TLabel;
    AccessCodeEd: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    DeleteBt: TButton;
    FileNamePn: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure UpdateBtClick(Sender: TObject);
    procedure CreateBtClick(Sender: TObject);
    procedure ResetBtClick(Sender: TObject);
    procedure AccessCodeEdChange(Sender: TObject);
    procedure DeleteBtClick(Sender: TObject);
  private
    { Private declarations }
    Key : TKey;
  public
    { Public declarations }
    function UpdateInfoLabels(const FileName: string): Boolean;
    function NumberOfSlots(const Str: string): Integer;
  end;

var
  MainFrm: TMainFrm;


implementation




procedure TMainFrm.FormCreate(Sender: TObject);
const
  {change these lines to match your application.}
  {they must be hardcoded, do not use .ini files, or}
  {you'll loose security.}
  CKey : TKey = ($E5,$8F,$84,$D6,$92,$C9,$A4,$D8,$1A,$FA,$6F,$8D,$AB,$FC,$DF,$B4);
begin
  Key := CKey;

  {change the file name to match your application}
  FileNamePn.Caption := 'EXNET.NAF';

  UpdateBt.Enabled := FileExists(FileNamePn.Caption);
  ResetBt.Enabled := FileExists(FileNamePn.Caption);
  DeleteBt.Enabled := FileExists(FileNamePn.Caption);
end;

procedure TMainFrm.AccessCodeEdChange(Sender: TObject);
begin
  CreateBt.Enabled := (NumberOfSlots(AccessCodeEd.Text) <> -1) and (FileNamePn.Caption <> '');
end;

procedure TMainFrm.UpdateBtClick(Sender: TObject);
begin
  if not UpdateInfoLabels(FileNamePn.Caption) then
    MessageDlg('Unable to read network access file.', mtError, [mbOK], 0);
end;

procedure TMainFrm.CreateBtClick(Sender: TObject);
begin
  if (NumberOfSlots(AccessCodeEd.Text) <> -1) then
    if not CreateNetAccessFile(FileNamePn.Caption, Key, NumberOfSlots(AccessCodeEd.Text)) then
      MessageDlg('Unable to create network access file.', mtError, [mbOK], 0)
    else
      begin
        if not UpdateInfoLabels(FileNamePn.Caption) then
          MessageDlg('Unable to read network access file.', mtError, [mbOK], 0);

        UpdateBt.Enabled := FileExists(FileNamePn.Caption);
        ResetBt.Enabled := FileExists(FileNamePn.Caption);
        DeleteBt.Enabled := FileExists(FileNamePn.Caption);
      end;
end;

procedure TMainFrm.ResetBtClick(Sender: TObject);
begin
  if not ResetNetAccessFile(FileNamePn.Caption, Key) then
    MessageDlg('Unable to reset network access file.', mtError, [mbOK], 0)
  else
    if not UpdateInfoLabels(FileNamePn.Caption) then
      MessageDlg('Unable read network access file.', mtError, [mbOK], 0);
end;

procedure TMainFrm.DeleteBtClick(Sender: TObject);
begin
  if (MessageDlg('Are you sure you want to delete this network access file?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      DeleteFile(FileNamePn.Caption);

      TotalSlotsLb.Caption := '0';
      LockedSlotsLb.Caption := '0';
      InvalidSlotsLb.Caption := '0';

      UpdateBt.Enabled := FileExists(FileNamePn.Caption);
      ResetBt.Enabled := FileExists(FileNamePn.Caption);
      DeleteBt.Enabled := FileExists(FileNamePn.Caption);
    end;
end;

function TMainFrm.UpdateInfoLabels(const FileName: string): Boolean;
var
  NetAccessInfo: TNetAccessInfo;
begin
  if GetNetAccessFileInfo(FileName, Key, NetAccessInfo) then begin
    TotalSlotsLb.Caption := IntToStr(NetAccessInfo.Total);
    LockedSlotsLb.Caption := IntToStr(NetAccessInfo.Locked);
    InvalidSlotsLb.Caption := IntToStr(NetAccessInfo.Invalid);
    Result := True;
  end else
    Result := False;
end;

function TMainFrm.NumberOfSlots(const Str: string): Integer;
var
  Code : TCode;
begin
  Result := -1;
  if (Length(Str) = SizeOf(Code) * 2) then begin
    HexToBuffer(Str, Code, SizeOf(Code));
    Result := DecodeNAFCountCode(Key, Code);
  end;
end;


initialization
{$i fixnaf1.lrs}

end.

