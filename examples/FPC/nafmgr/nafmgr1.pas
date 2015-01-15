unit NAFMGR1;

interface

uses
  IniFiles, SysUtils, Dialogs, StdCtrls, Controls, Classes, Forms,
  Buttons,LResources,onguard, ognetwrk, ogutil;

type

  { TNafFrm }

  TNafFrm = class(TForm)
    GroupBox1: TGroupBox;
    FileNameEd: TEdit;
    BrowseBt: TButton;
    UpdateBt: TButton;
    CreateBt: TButton;
    ResetBt: TButton;
    OpenDg: TOpenDialog;
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
    OgMakeCodes1: TOgMakeCodes;
    GenerateCodeSb: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure UpdateBtClick(Sender: TObject);
    procedure CreateBtClick(Sender: TObject);
    procedure ResetBtClick(Sender: TObject);
    procedure BrowseBtClick(Sender: TObject);
    procedure AccessCodeEdChange(Sender: TObject);
    procedure FileNameEdChange(Sender: TObject);
    procedure DeleteBtClick(Sender: TObject);
    procedure GenerateCodeSbClick(Sender: TObject);
  private
    { Private declarations }
    Key : TKey;
  public
    { Public declarations }
    function UpdateInfoLabels(const FileName: string): Boolean;
    function NumberOfSlots(const Str: string): Integer;
  end;

var
  NafFrm : TNafFrm;

implementation



const
  {this applications' key}
  CKey : TKey = ($E5,$8F,$84,$D6,$92,$C9,$A4,$D8,$1A,$FA,$6F,$8D,$AB,$FC,$DF,$B4);

procedure TNafFrm.FormCreate(Sender: TObject);
begin
  Key := CKey;
end;

procedure TNafFrm.BrowseBtClick(Sender: TObject);
begin
  if OpenDg.Execute then
    FileNameEd.Text := OpenDg.FileName;
end;

procedure TNafFrm.AccessCodeEdChange(Sender: TObject);
begin
  CreateBt.Enabled := (NumberOfSlots(AccessCodeEd.Text) <> -1) and (FileNameEd.Text <> '');
end;

procedure TNafFrm.FileNameEdChange(Sender: TObject);
begin
  UpdateBt.Enabled := FileExists(FileNameEd.Text);
  CreateBt.Enabled := (NumberOfSlots(AccessCodeEd.Text) <> -1) and (FileNameEd.Text <> '');
  ResetBt.Enabled := FileExists(FileNameEd.Text);
  DeleteBt.Enabled := FileExists(FileNameEd.Text);
end;

procedure TNafFrm.UpdateBtClick(Sender: TObject);
begin
  if not UpdateInfoLabels(FileNameEd.Text) then
    MessageDlg('Unable to read network access file.', mtError, [mbOK], 0);
end;

procedure TNafFrm.CreateBtClick(Sender: TObject);
begin
  if (NumberOfSlots(AccessCodeEd.Text) <> -1) then
    if not CreateNetAccessFile(FileNameEd.Text, Key, NumberOfSlots(AccessCodeEd.Text)) then
      MessageDlg('Unable to create network access file.', mtError, [mbOK], 0)
    else begin
      if not UpdateInfoLabels(FileNameEd.Text) then
        MessageDlg('Unable to read network access file.', mtError, [mbOK], 0);

      UpdateBt.Enabled := FileExists(FileNameEd.Text);
      ResetBt.Enabled := FileExists(FileNameEd.Text);
      DeleteBt.Enabled := FileExists(FileNameEd.Text);
    end;
end;

procedure TNafFrm.ResetBtClick(Sender: TObject);
begin
  if not ResetNetAccessFile(FileNameEd.Text, Key) then
    MessageDlg('Unable to reset network access file.', mtError, [mbOK], 0)
  else
    if not UpdateInfoLabels(FileNameEd.Text) then
      MessageDlg('Unable read network access file.', mtError, [mbOK], 0);
end;

procedure TNafFrm.DeleteBtClick(Sender: TObject);
begin
  if (MessageDlg('Are you sure you want to delete this network access file?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    DeleteFile(FileNameEd.Text);

    TotalSlotsLb.Caption := '0';
    LockedSlotsLb.Caption := '0';
    InvalidSlotsLb.Caption := '0';

    UpdateBt.Enabled := FileExists(FileNameEd.Text);
    ResetBt.Enabled := FileExists(FileNameEd.Text);
    DeleteBt.Enabled := FileExists(FileNameEd.Text);
  end;
end;

function TNafFrm.UpdateInfoLabels(const FileName: string): Boolean;
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

function TNafFrm.NumberOfSlots(const Str: string): Integer;
var
  Code : TCode;
begin
  Result := -1;
  if (Length(Str) = SizeOf(Code) * 2) then begin
    HexToBuffer(Str, Code, SizeOf(Code));
    Result := DecodeNAFCountCode(Key, Code);
  end;
end;

procedure TNafFrm.GenerateCodeSbClick(Sender: TObject);
var
  Work : TCode;
begin
  OgMakeCodes1.SetKey(CKey);
  OgMakeCodes1.CodeType := ctNetWork;
  if OgMakeCodes1.Execute then begin
    OgMakeCodes1.GetCode(Work);
    AccessCodeEd.Text := BufferToHex(Work, SizeOf(Work));
  end;
end;

initialization
{$i nafmgr1.lrs}

end.

