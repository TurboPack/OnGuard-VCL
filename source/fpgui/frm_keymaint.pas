unit frm_keymaint;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, fpg_base, fpg_main, fpg_form, fpg_label, fpg_button,
  fpg_listbox, fpg_editbtn, fpg_edit, onguard;

type

  TKeyMaintForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: KeyMaintForm}
    Label1: TfpgLabel;
    edtFilename: TfpgFileNameEdit;
    Label2: TfpgLabel;
    btnAddApp: TfpgButton;
    btnEditApp: TfpgButton;
    btnDelApp: TfpgButton;
    lbProducts: TfpgListBox;
    Label3: TfpgLabel;
    edtBlockKey: TfpgEdit;
    edtBytesBlockKey: TfpgEdit;
    btnOK: TfpgButton;
    btnCancel: TfpgButton;
    btnLoadFile: TfpgButton;
    {@VFD_HEAD_END: KeyMaintForm}
    FKey: TKey;
    FKeyType: TKeyType;
    function    GetKeyFileName: string;
    procedure   SetKeyFileName(const AValue: string);
    procedure   FormCreate(Sender: TObject);
    procedure   InfoChanged(Sender: TObject);
    procedure   btnLoadClicked(Sender: TObject);
    procedure   edtFilenameHasBeenSet(Sender: TObject; const AOldValue, ANewValue: TfpgString);
    procedure   btnAddAppClicked(Sender: TObject);
    procedure   btnEditAppClicked(Sender: TObject);
    procedure   btnDelAppClicked(Sender: TObject);
    procedure   lbProductsClicked(Sender: TObject);
    procedure   lbProductsDblClicked(Sender: TObject; AButton: TMouseButton; AShift: TShiftState; const AMousePos: TPoint);
  public
    constructor Create(AOwner: TComponent); override;
    procedure   AfterCreate; override;
    procedure   SetKey(AValue: TKey);
    procedure   GetKey(var AValue: TKey);
    property    KeyFileName: string read GetKeyFileName write SetKeyFileName;
    property    KeyType: TKeyType read FKeyType write FKeyType;
  end;

{@VFD_NEWFORM_DECL}

implementation

uses
  ogconst,
  ogutil,
  IniFiles,
  fpg_dialogs,
  frm_productmaint
  {$IFDEF GDEBUG}
  ,tiLog
  {$ENDIF}
  ;

{@VFD_NEWFORM_IMPL}

function TKeyMaintForm.GetKeyFileName: string;
begin
  Result := edtFileName.FileName;
end;

procedure TKeyMaintForm.SetKeyFileName(const AValue: string);
begin
  edtFileName.Filename := AValue;
  InfoChanged(Self);
end;

procedure TKeyMaintForm.FormCreate(Sender: TObject);
begin
  KeyFileName := '';
end;

procedure TKeyMaintForm.InfoChanged(Sender: TObject);
var
  I: Integer;
  IniFile: TIniFile;
begin
  try
    {$HINTS OFF}
    FillChar(FKey, SizeOf(FKey), 0);
    {$HINTS ON}
    if Length(KeyFileName) > 0 then begin
      IniFile := TIniFile.Create(KeyFileName);
      try
        I := lbProducts.FocusItem;
        lbProducts.BeginUpdate;
        try
          lbProducts.Items.Clear;
          IniFile.ReadSection(OgKeySection, lbProducts.Items);
          if I < lbProducts.Items.Count then
            lbProducts.FocusItem := I
          else
          begin
            lbProducts.FocusItem := lbProducts.Items.Count-1;
            I := lbProducts.FocusItem;
          end;

          if (I > -1) then
          begin
            //btnEditApp.Enabled := True;
            //btnDelApp.Enabled := True;
            edtBlockKey.Text := IniFile.ReadString(OgKeySection, lbProducts.Items[I], '');
            HexToBuffer(edtBlockKey.Text, FKey, SizeOf(FKey));
            edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
            edtBytesBlockKey.Text := BufferToHexBytes(FKey, SizeOf(FKey));
            if HexStringIsZero(edtBlockKey.Text)then
              edtBlockKey.Text := '';
            if HexStringIsZero(edtBytesBlockKey.Text)then
              edtBytesBlockKey.Text := '';
          end
          else
          begin
            //btnEditApp.Enabled := False;
            //btnDelApp.Enabled := False;
          end;
        finally
          lbProducts.EndUpdate;
        end;
      finally
        IniFile.Free;
      end;
    end
    else
      lbProducts.Items.Clear;

    //btnOK.Enabled := HexToBuffer(edtBlockKey.Text, FKey, SizeOf(FKey));
  except
    on E:Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TKeyMaintForm.btnLoadClicked(Sender: TObject);
begin
  KeyFileName := edtFilename.FileName;
  InfoChanged(self);
end;

procedure TKeyMaintForm.edtFilenameHasBeenSet(Sender: TObject; const AOldValue, ANewValue: TfpgString);
begin
  KeyFileName := ANewValue;
end;

procedure TKeyMaintForm.btnAddAppClicked(Sender: TObject);
var
  F: TProductMaintForm;
  IniFile: TIniFile;
begin
  {$IFDEF GDEBUG}
  Log('>> TKeyMaintForm.btnAddAppClicked', lsDebug);
  {$ENDIF}
  F := TProductMaintForm.Create(nil);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.ShowHint := ShowHint;
    if F.ShowModal = mrOK then
    begin
      IniFile := TIniFile.Create(KeyFileName);
      try
        IniFile.WriteString(OgKeySection, F.Product, F.KeyText);
      finally
        IniFile.Free;
      end;
      F.GetKey(FKey);
      FKeyType := F.KeyType;
    end;
  finally
    F.Free;
  end;

  InfoChanged(Self);
  {$IFDEF GDEBUG}
  Log('<< TKeyMaintForm.btnAddAppClicked', lsDebug);
  {$ENDIF}
end;

procedure TKeyMaintForm.btnEditAppClicked(Sender: TObject);
var
  F: TProductMaintForm;
  IniFile: TIniFile;
  I: Integer;
begin
  {$IFDEF GDEBUG}
  Log('>> TKeyMaintForm.btnEditAppClicked', lsDebug);
  {$ENDIF}
  I := lbProducts.FocusItem;
  if (I = -1) then
    Exit;

  F := TProductMaintForm.Create(nil);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
//    F.ShowHint := ShowHint;
    IniFile := TIniFile.Create(KeyFileName);
    try
      F.Product := lbProducts.Items[lbProducts.FocusItem];
      F.KeyText := BufferToHex(FKey, SizeOf(FKey));
      if F.ShowModal = mrOK then
        IniFile.WriteString(OgKeySection, F.Product, F.KeyText);
    finally
      IniFile.Free;
    end;
  finally
    F.Free;
  end;

  InfoChanged(Self);
  {$IFDEF GDEBUG}
  Log('<< TKeyMaintForm.btnEditAppClicked', lsDebug);
  {$ENDIF}
end;

procedure TKeyMaintForm.btnDelAppClicked(Sender: TObject);
var
  IniFile: TIniFile;
  I: Integer;
begin
  I := lbProducts.FocusItem;
  if (I > -1) then
  begin
    if TfpgMessageDialog.Question('', SCDeleteQuery) = mbYes then
    begin
      IniFile := TIniFile.Create(KeyFileName);
      try
        IniFile.DeleteKey(OgKeySection, lbProducts.Items[I]);
      finally
        IniFile.Free;
      end;
      edtBlockKey.Text := '';
      edtBytesBlockKey.Text := '';

      InfoChanged(Self);
    end;
  end;
end;

procedure TKeyMaintForm.lbProductsClicked(Sender: TObject);
var
  I : Integer;
  IniFile : TIniFile;
begin
  I := lbProducts.FocusItem;
  if I < 0 then
    Exit;
  IniFile := TIniFile.Create(KeyFileName);
  try
    edtBlockKey.Text := IniFile.ReadString(OgKeySection, lbProducts.Items[I], '');
    HexToBuffer(edtBlockKey.Text, FKey, SizeOf(FKey));
    edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
    edtBytesBlockKey.Text := BufferToHexBytes(FKey, SizeOf(FKey));
  finally
    IniFile.Free;
  end;
end;

procedure TKeyMaintForm.lbProductsDblClicked(Sender: TObject; AButton: TMouseButton;
    AShift: TShiftState; const AMousePos: TPoint);
begin
  ModalResult := mrOK;
end;

constructor TKeyMaintForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnCreate := @FormCreate;
end;

procedure TKeyMaintForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: KeyMaintForm}
  Name := 'KeyMaintForm';
  SetPosition(673, 170, 495, 402);
  WindowTitle := 'Key Maintenance';
  Hint := '';
  ShowHint := True;
  MinWidth := 470;
  MinHeight := 400;

  Label1 := TfpgLabel.Create(self);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(8, 8, 256, 16);
    FontDesc := '#Label2';
    Hint := '';
    Text := 'Key file';
  end;

  edtFilename := TfpgFileNameEdit.Create(self);
  with edtFilename do
  begin
    Name := 'edtFilename';
    SetPosition(24, 28, 377, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FileName := 'onguard.ini';
    Filter := 'Key File (*.ini)|*.ini';
    InitialDir := '';
    TabOrder := 2;
    OnFilenameSet  := @edtFilenameHasBeenSet;
  end;

  Label2 := TfpgLabel.Create(self);
  with Label2 do
  begin
    Name := 'Label2';
    SetPosition(8, 60, 272, 16);
    FontDesc := '#Label2';
    Hint := '';
    Text := 'Products';
  end;

  btnAddApp := TfpgButton.Create(self);
  with btnAddApp do
  begin
    Name := 'btnAddApp';
    SetPosition(24, 80, 24, 24);
    Text := '';
    Flat := True;
    FontDesc := '#Label1';
    Hint := 'Add';
    ImageMargin := 0;
    ImageName := 'stdimg.add';
    TabOrder := 4;
    OnClick := @btnAddAppClicked;
  end;

  btnEditApp := TfpgButton.Create(self);
  with btnEditApp do
  begin
    Name := 'btnEditApp';
    SetPosition(49, 80, 24, 24);
    Text := '';
    Flat := True;
    FontDesc := '#Label1';
    Hint := 'Edit';
    ImageMargin := 0;
    ImageName := 'stdimg.edit';
    TabOrder := 5;
    OnClick := @btnEditAppClicked;
  end;

  btnDelApp := TfpgButton.Create(self);
  with btnDelApp do
  begin
    Name := 'btnDelApp';
    SetPosition(74, 80, 24, 24);
    Text := '';
    Flat := True;
    FontDesc := '#Label1';
    Hint := 'Delete';
    ImageMargin := 0;
    ImageName := 'stdimg.delete';
    TabOrder := 6;
    OnClick := @btnDelAppClicked;
  end;

  lbProducts := TfpgListBox.Create(self);
  with lbProducts do
  begin
    Name := 'lbProducts';
    SetPosition(24, 104, 461, 156);
    Anchors := [anLeft,anRight,anTop];
    FontDesc := '#List';
    Hint := '';
    TabOrder := 7;
    OnClick  := @lbProductsClicked;
    OnDoubleClick  := @lbProductsDblClicked;
  end;

  Label3 := TfpgLabel.Create(self);
  with Label3 do
  begin
    Name := 'Label3';
    SetPosition(8, 272, 220, 16);
    FontDesc := '#Label2';
    Hint := '';
    Text := 'Key';
  end;

  edtBlockKey := TfpgEdit.Create(self);
  with edtBlockKey do
  begin
    Name := 'edtBlockKey';
    SetPosition(24, 292, 461, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 9;
    Text := '';
  end;

  edtBytesBlockKey := TfpgEdit.Create(self);
  with edtBytesBlockKey do
  begin
    Name := 'edtBytesBlockKey';
    SetPosition(24, 320, 461, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 10;
    Text := '';
  end;

  btnOK := TfpgButton.Create(self);
  with btnOK do
  begin
    Name := 'btnOK';
    SetPosition(321, 368, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'OK';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrOK;
    TabOrder := 11;
  end;

  btnCancel := TfpgButton.Create(self);
  with btnCancel do
  begin
    Name := 'btnCancel';
    SetPosition(405, 368, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'Cancel';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrCancel;
    TabOrder := 12;
  end;

  btnLoadFile := TfpgButton.Create(self);
  with btnLoadFile do
  begin
    Name := 'btnLoadFile';
    SetPosition(405, 28, 80, 24);
    Anchors := [anRight,anTop];
    Text := 'Load';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 13;
    OnClick := @btnLoadClicked;
  end;

  {@VFD_BODY_END: KeyMaintForm}
  {%endregion}
end;

procedure TKeyMaintForm.SetKey(AValue: TKey);
begin
  FKey := AValue;
end;

procedure TKeyMaintForm.GetKey(var AValue: TKey);
begin
  AValue := FKey;
end;


end.
