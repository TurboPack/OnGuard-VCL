unit frm_productmaint;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, fpg_base, fpg_main, fpg_form, fpg_label, fpg_edit,
  fpg_button, onguard, ogutil;

type

  TProductMaintForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: ProductMaintForm}
    Label1: TfpgLabel;
    edtProduct: TfpgEdit;
    Label2: TfpgLabel;
    edtKey: TfpgEdit;
    btnOK: TfpgButton;
    btnCancel: TfpgButton;
    btnGenerateKey: TfpgButton;
    {@VFD_HEAD_END: ProductMaintForm}
    FKey: TKey;
    FKeyType: TKeyType;
    procedure   InfoChanged(Sender: TObject);
    procedure   FormShow(Sender: TObject);
    procedure   btnGenerateKeyClicked(Sender: TObject);
    function    GetProduct: TfpgString;
    function    GetKeyText: TfpgString;
    procedure   SetProduct(const AValue: TfpgString);
    procedure   SetKeyText(const AValue: TfpgString);
  public
    constructor Create(AOwner: TComponent); override;
    procedure   AfterCreate; override;
    procedure   SetKey(AValue: TKey);
    procedure   GetKey(var AValue: TKey);
    property    KeyType: TKeyType read FKeyType write FKeyType;
    property    Product: TfpgString read GetProduct write SetProduct;
    property    KeyText: TfpgString read GetKeyText write SetKeyText;
  end;

{@VFD_NEWFORM_DECL}

implementation

uses
  frm_keygen
  {$IFDEF GDEBUG}
  ,tiLog
  {$ENDIF}
  ;

{@VFD_NEWFORM_IMPL}

procedure TProductMaintForm.InfoChanged(Sender: TObject);
var
  Work: TKey;
begin
  {$IFDEF GDEBUG} Log('>> TProductMaintForm.InfoChanged', lsDebug); {$ENDIF}
  {$HINTS OFF}
  FillChar(Work, SizeOf(Work), 0); // Fill array with zeros
  {$HINTS ON}

//  btnOK.Enabled := (Length(edtProduct.Text) > 0) and (Length(edtKey.Text) > 0);
  btnOK.Enabled := (Length(edtProduct.Text) > 0) and (HexToBuffer(edtKey.Text, Work, SizeOf(Work)));
  {$IFDEF GDEBUG} Log('<< TProductMaintForm.InfoChanged', lsDebug); {$ENDIF}
end;

procedure TProductMaintForm.FormShow(Sender: TObject);
begin
  {$IFDEF GDEBUG} Log('>> TProductMaintForm.FormShow', lsDebug); {$ENDIF}
  InfoChanged(self);
  {$IFDEF GDEBUG} Log('<< TProductMaintForm.FormShow', lsDebug); {$ENDIF}
end;

procedure TProductMaintForm.btnGenerateKeyClicked(Sender: TObject);
var
  F: TKeyGenerateForm;
begin
  F := TKeyGenerateForm.Create(nil);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
//    F.ShowHint := ShowHints;
    if F.ShowModal = mrOK then
    begin
      F.GetKey(FKey);
      FKeyType := F.KeyType;
      edtKey.Text := BufferToHex(FKey, SizeOf(FKey));
      if HexStringIsZero(edtKey.Text) then
      begin
        edtKey.Text := '';
        {$HINTS OFF}
        FillChar(FKey, SizeOf(FKey), 0);
        {$HINTS ON}
      end;
      InfoChanged(Sender);
    end;
  finally
    F.Free;
  end;
end;

function TProductMaintForm.GetProduct: TfpgString;
begin
  Result := edtProduct.Text;
end;

function TProductMaintForm.GetKeyText: TfpgString;
begin
  Result := edtKey.Text;
end;

procedure TProductMaintForm.SetProduct(const AValue: TfpgString);
begin
  edtProduct.Text := AValue;
end;

procedure TProductMaintForm.SetKeyText(const AValue: TfpgString);
begin
  edtKey.Text := AValue;
end;

constructor TProductMaintForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnShow := @FormShow;
end;

procedure TProductMaintForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: ProductMaintForm}
  Name := 'ProductMaintForm';
  SetPosition(660, 201, 375, 141);
  WindowTitle := 'Product Maintenance';
  Hint := '';
  ShowHint := True;
  MinHeight := 140;
  MinWidth := 350;

  Label1 := TfpgLabel.Create(self);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(8, 8, 212, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Product Name';
  end;

  edtProduct := TfpgEdit.Create(self);
  with edtProduct do
  begin
    Name := 'edtProduct';
    SetPosition(8, 24, 331, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 2;
    Text := '';
  end;

  Label2 := TfpgLabel.Create(self);
  with Label2 do
  begin
    Name := 'Label2';
    SetPosition(8, 52, 188, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Key';
  end;

  edtKey := TfpgEdit.Create(self);
  with edtKey do
  begin
    Name := 'edtKey';
    SetPosition(8, 68, 331, 24);
    Anchors := [anLeft,anRight,anTop];
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 4;
    Text := '';
  end;

  btnOK := TfpgButton.Create(self);
  with btnOK do
  begin
    Name := 'btnOK';
    SetPosition(198, 107, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'OK';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrOK;
    TabOrder := 5;
  end;

  btnCancel := TfpgButton.Create(self);
  with btnCancel do
  begin
    Name := 'btnCancel';
    SetPosition(286, 107, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'Cancel';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    ModalResult := mrCancel;
    TabOrder := 6;
  end;

  btnGenerateKey := TfpgButton.Create(self);
  with btnGenerateKey do
  begin
    Name := 'btnGenerateKey';
    SetPosition(343, 68, 24, 24);
    Anchors := [anRight,anTop];
    Text := 'K';
    Flat := True;
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 7;
    OnClick := @btnGenerateKeyClicked;
  end;

  {@VFD_BODY_END: ProductMaintForm}
  {%endregion}
end;

procedure TProductMaintForm.SetKey(AValue: TKey);
begin
  FKey := AValue;
end;

procedure TProductMaintForm.GetKey(var AValue: TKey);
begin
  AValue := FKey;
end;


end.
