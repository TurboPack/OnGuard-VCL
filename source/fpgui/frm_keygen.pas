unit frm_keygen;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, fpg_base, fpg_main, fpg_form, fpg_label, fpg_button,
  fpg_memo, fpg_combobox, fpg_edit, ogutil, onguard;

type

  TKeyGenerateForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: KeyGenerateForm}
    Label1: TfpgLabel;
    cbKeyType: TfpgComboBox;
    btnOK: TfpgButton;
    btnCancel: TfpgButton;
    btnGenerateKey: TfpgButton;
    Label2: TfpgLabel;
    memKeyPhrase: TfpgMemo;
    Label3: TfpgLabel;
    edtBlockKey: TfpgEdit;
    edtByteBlockKey: TfpgEdit;
    {@VFD_HEAD_END: KeyGenerateForm}
    FKey: TKey;
    FKeyType: TKeyType;
    procedure   SetKeyType(AValue: TKeyType);
    procedure   FormCreate(Sender: TObject);
    procedure   FormShow(Sender: TObject);
    procedure   cbKeyTypeChanged(Sender: TObject);
    procedure   meKeyPhraseChanged(Sender: TObject);
    procedure   btnGenerateKeyClicked(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure   AfterCreate; override;
    procedure   SetKey(AValue: TKey);
    procedure   GetKey(var AValue: TKey);
    property    KeyType: TKeyType read FKeyType write SetKeyType;
  end;

{@VFD_NEWFORM_DECL}

implementation

{@VFD_NEWFORM_IMPL}

procedure TKeyGenerateForm.SetKeyType(AValue: TKeyType);
begin
  if AValue <> FKeyType then
  begin
    FKeyType := AValue;
    cbKeyType.FocusItem := Ord(FKeyType);
  end;
end;

procedure TKeyGenerateForm.FormCreate(Sender: TObject);
begin
  cbKeyType.FocusItem := Ord(FKeyType);
end;

procedure TKeyGenerateForm.FormShow(Sender: TObject);
begin
  cbKeyTypeChanged(Sender);
end;

procedure TKeyGenerateForm.cbKeyTypeChanged(Sender: TObject);
begin
  edtBlockKey.Text := '';
  edtByteBlockKey.Text := '';

  {set state of memo and generate button}
  //memKeyPhrase.Enabled := (cbKeyType.FocusItem <> 0);
  //case KeyStringMe.Enabled of
  //  True  : KeyStringMe.Color := clWindow;
  //  False : KeyStringMe.Color := clBtnFace;
  //end;
  btnGenerateKey.Enabled := (cbKeyType.FocusItem = 0) or (memKeyPhrase.Lines.Count > 0);

  if cbKeyType.FocusItem > -1 then
    FKeyType := TKeyType(cbKeyType.FocusItem);
end;

procedure TKeyGenerateForm.meKeyPhraseChanged(Sender: TObject);
begin
  edtBlockKey.Text := '';
  edtByteBlockKey.Text := '';

  {set state of generate button}
  btnGenerateKey.Enabled := (cbKeyType.FocusItem = 0) or (memKeyPhrase.Lines.Count > 0);
end;

procedure TKeyGenerateForm.btnGenerateKeyClicked(Sender: TObject);
begin
  case cbKeyType.FocusItem of
    0:
      begin
        GenerateRandomKeyPrim(FKey, SizeOf(FKey));
        edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
        edtByteBlockKey.Text := BufferToHexBytes(FKey, SizeOf(FKey));
      end;
    1:
      begin
        GenerateTMDKeyPrim(FKey, SizeOf(FKey), AnsiUpperCase(memKeyPhrase.Text));
        edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
        edtByteBlockKey.Text := BufferToHexBytes(FKey, SizeOf(FKey));
      end;
    2:
      begin
        GenerateTMDKeyPrim(FKey, SizeOf(FKey), memKeyPhrase.Text);
        edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
        edtByteBlockKey.Text := BufferToHexBytes(FKey, SizeOf(FKey));
      end;
  end;
end;

constructor TKeyGenerateForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnCreate  := @FormCreate;
  OnShow    := @FormShow;
end;

procedure TKeyGenerateForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: KeyGenerateForm}
  Name := 'KeyGenerateForm';
  SetPosition(655, 180, 425, 235);
  WindowTitle := 'KeyGenerateForm';
  Hint := '';
  MinHeight := 235;
  MinWidth := 400;

  Label1 := TfpgLabel.Create(self);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(8, 8, 80, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Key Type:';
  end;

  cbKeyType := TfpgComboBox.Create(self);
  with cbKeyType do
  begin
    Name := 'cbKeyType';
    SetPosition(92, 4, 120, 24);
    ExtraHint := '';
    FontDesc := '#List';
    Hint := '';
    Items.Add('Random');
    Items.Add('Standard text');
    Items.Add('Case-sensitive text');
    FocusItem := 0;
    TabOrder := 2;
    OnChange  := @cbKeyTypeChanged;
  end;

  btnOK := TfpgButton.Create(self);
  with btnOK do
  begin
    Name := 'btnOK';
    SetPosition(253, 204, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'OK';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrOK;
    TabOrder := 3;
  end;

  btnCancel := TfpgButton.Create(self);
  with btnCancel do
  begin
    Name := 'btnCancel';
    SetPosition(337, 204, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'Cancel';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrCancel;
    TabOrder := 4;
  end;

  btnGenerateKey := TfpgButton.Create(self);
  with btnGenerateKey do
  begin
    Name := 'btnGenerateKey';
    SetPosition(313, 4, 104, 24);
    Anchors := [anRight,anTop];
    Text := 'Generate Key';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 5;
    OnClick := @btnGenerateKeyClicked;
  end;

  Label2 := TfpgLabel.Create(self);
  with Label2 do
  begin
    Name := 'Label2';
    SetPosition(8, 36, 180, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Key Phrase:';
  end;

  memKeyPhrase := TfpgMemo.Create(self);
  with memKeyPhrase do
  begin
    Name := 'memKeyPhrase';
    SetPosition(8, 52, 408, 56);
    Anchors := [anLeft,anRight,anTop];
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 7;
    OnChange  := @meKeyPhraseChanged;
  end;

  Label3 := TfpgLabel.Create(self);
  with Label3 do
  begin
    Name := 'Label3';
    SetPosition(8, 116, 80, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Key:';
  end;

  edtBlockKey := TfpgEdit.Create(self);
  with edtBlockKey do
  begin
    Name := 'edtBlockKey';
    SetPosition(8, 132, 408, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 9;
    Text := '';
  end;

  edtByteBlockKey := TfpgEdit.Create(self);
  with edtByteBlockKey do
  begin
    Name := 'edtByteBlockKey';
    SetPosition(8, 160, 408, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 10;
    Text := '';
  end;

  {@VFD_BODY_END: KeyGenerateForm}
  {%endregion}
end;

procedure TKeyGenerateForm.SetKey(AValue: TKey);
begin
  FKey := AValue;
end;

procedure TKeyGenerateForm.GetKey(var AValue: TKey);
begin
  AValue := FKey;
end;


end.
