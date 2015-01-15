unit frm_codegen;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, fpg_base, fpg_main, fpg_form, fpg_button, fpg_label,
  fpg_tab, fpg_popupcalendar, fpg_checkbox, fpg_panel, fpg_edit, onguard;

type

  TCodeGenerationForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: CodeGenerationForm}
    btnOK: TfpgButton;
    btnCancel: TfpgButton;
    pgCodes: TfpgPageControl;
    tsDate: TfpgTabSheet;
    tsDays: TfpgTabSheet;
    tsReg: TfpgTabSheet;
    tsSerialNo: TfpgTabSheet;
    tsUsage: TfpgTabSheet;
    tsNetwork: TfpgTabSheet;
    tsSpecial: TfpgTabSheet;
    lblDateStart: TfpgLabel;
    calDateStart: TfpgCalendarCombo;
    lblDateEnd: TfpgLabel;
    calDateEnd: TfpgCalendarCombo;
    lblDaysCount: TfpgLabel;
    EditInteger1: TfpgEditInteger;
    lblDaysExpire: TfpgLabel;
    EditInteger2: TfpgEditInteger;
    GroupBox1: TfpgGroupBox;
    cbxNoModifier: TfpgCheckBox;
    cbxMachineModifier: TfpgCheckBox;
    cbxUniqueModifier: TfpgCheckBox;
    cbxDateModifier: TfpgCheckBox;
    calModDate: TfpgCalendarCombo;
    cbxStringModifier: TfpgCheckBox;
    edtModString: TfpgEdit;
    Label1: TfpgLabel;
    edtModifier: TfpgEdit;
    Label2: TfpgLabel;
    edtBlockKey: TfpgEdit;
    btnKeyMaint: TfpgButton;
    GroupBox2: TfpgGroupBox;
    btnGenerate: TfpgButton;
    edtRegCode: TfpgEdit;
    btnCopyToClipboard: TfpgButton;
    Label3: TfpgLabel;
    edtSerialNumber: TfpgEdit;
    btnSerialRandom: TfpgButton;
    Label4: TfpgLabel;
    calSerialExpires: TfpgCalendarCombo;
    {@VFD_HEAD_END: CodeGenerationForm}
    FCode: TCode;
    FCodeType: TCodeType;
    FKey: TKey;
    FKeyType: TKeyType;
    FKeyFileName: string;
    procedure   SetCodeType(const AValue: TCodeType);
    procedure   FormCreate(Sender: TObject);
    procedure   FormShow(Sender: TObject);
    procedure   InfoChanged(Sender: TObject);
    procedure   btnKeyMaintClicked(Sender: TObject);
    procedure   btnGenerateClicked(Sender: TObject);
    procedure   btnOKClicked(Sender: TObject);
    procedure   pgCodeChanged(Sender: TObject; NewActiveSheet: TfpgTabSheet);
    procedure   ModifierChanged(Sender: TObject);
    procedure   btnSerialRandomClicked(Sender: TObject);
    procedure   OGMCheck;
    procedure   OGMQuit;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   AfterCreate; override;
    procedure   SetKey(Value: TKey);
    procedure   GetKey(var Value: TKey);
    property    Code: TCode read FCode;
    property    CodeType: TCodeType read FCodeType write SetCodeType;
    property    KeyFileName: string read FKeyFileName write FKeyFileName;
    property    KeyType: TKeyType read FKeyType write FKeyType;
  end;

{@VFD_NEWFORM_DECL}

implementation

uses
  ogutil,
  ogconst,
  fpg_dialogs,
  frm_keymaint;

{@VFD_NEWFORM_IMPL}

procedure TCodeGenerationForm.SetCodeType(const AValue: TCodeType);
begin
  if AValue <> TCodeType(pgCodes.ActivePageIndex) then
  begin
    FCodeType := AValue;
    pgCodes.ActivePageIndex := Ord(FCodeType);
  end;
end;

procedure TCodeGenerationForm.FormCreate(Sender: TObject);
var
  D: TDateTime;
begin
  pgCodes.ActivePageIndex := Ord(FCodeType);
  edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(edtBlockKey.Text)then
    edtBlockKey.Text := '';

  {initialize date edits}
  calDateStart.DateValue := Date;
  calDateEnd.DateValue := Date;
  calModDate.DateValue := Date;

  D := EncodeDate(9999,12,31);
  //UsageExpiresEd.Text := OgFormatDate(D);
  //SpecialExpiresEd.Text := OgFormatDate(D);
  calSerialExpires.DateValue := D;
  //RegExpiresEd.Text := OgFormatDate(D);
  //DaysExpiresEd.Text := OgFormatDate(D);

  InfoChanged(self);
end;

procedure TCodeGenerationForm.FormShow(Sender: TObject);
begin
  cbxNoModifier.Checked := True;
//  OGMCheck;
end;

procedure TCodeGenerationForm.InfoChanged(Sender: TObject);
begin
 // GenerateBtn.Enabled := HexToBuffer(BlockKeyEd.Text, FKey, SizeOf(FKey));
 // OKBtn.Enabled := Length(RegCodeEd.Text) > 0;
end;

procedure TCodeGenerationForm.btnKeyMaintClicked(Sender: TObject);
var
  F: TKeyMaintForm;
begin
  F := TKeyMaintForm.Create(nil);
  try
    F.SetKey(FKey);
    F.KeyType := FKeyType;
    F.KeyFileName := FKeyFileName;
    F.ShowHint := ShowHint;
    if F.ShowModal = mrOK then
    begin
      F.GetKey(FKey);
      edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
      if HexStringIsZero(edtBlockKey.Text)then
        edtBlockKey.Text := '';
      FKeyType := F.KeyType;
      FKeyFileName := F.KeyFileName;
      InfoChanged(Self);
    end;
  finally
    F.Free;
  end;
end;

procedure TCodeGenerationForm.btnGenerateClicked(Sender: TObject);
var
  I: LongInt;
  Work: TCode;
  K: TKey;
  Modifier: LongInt;
  D1, D2: TDateTime;
begin
  Modifier := 0;
  if ((edtModifier.Text = '') or HexToBuffer(edtModifier.Text, Modifier, SizeOf(LongInt))) then
  begin
    K := FKey;
    ApplyModifierToKeyPrim(Modifier, K, SizeOf(K));

    case pgCodes.ActivePageIndex of
      0 : begin
            D1 := calDateStart.DateValue;
            D2 := calDateEnd.DateValue;

            InitDateCode(K, Trunc(D1), Trunc(D2), FCode);
            Work := FCode;
            MixBlock(T128bit(K), Work, False);

            {sanity check}
            calDateStart.DateValue := Work.FirstDate+BaseDate;
            calDateEnd.DateValue := Work.EndDate+BaseDate;
            //StartDateEd.Text := OgFormatDate(Work.FirstDate+BaseDate);
            //EndDateEd.Text := OgFormatDate(Work.EndDate+BaseDate);
          end;
      1 : begin
            //try
            //  D1 := StrToDate(DaysExpiresEd.Text);
            //except
            //  on EConvertError do begin
            //    ShowMessage(SCInvalidExDate);
            //    DaysExpiresEd.SetFocus;
            //    Exit;
            //  end else
            //    raise;
            //end;
            //InitDaysCode(K, StrToIntDef(DaysCountEd.Text, 0), D1, FCode);
          end;
      2 : begin
            //try
            //  D1 := StrToDate(RegExpiresEd.Text);
            //except
            //  on EConvertError do begin
            //    ShowMessage(SCInvalidExDate);
            //    RegExpiresEd.SetFocus;
            //    Exit;
            //  end else
            //    raise;
            //end;
            //InitRegCode(K, RegStrEd.Text, D1, FCode);
          end;
      3 : begin
            D1 := calSerialExpires.DateValue;
            InitSerialNumberCode(K, StrToIntDef(edtSerialNumber.Text, 0), D1, FCode);
          end;
      4 : begin
            //try
            //  D1 := StrToDate(UsageExpiresEd.Text);
            //except
            //  on EConvertError do begin
            //    ShowMessage(SCInvalidExDate);
            //    UsageExpiresEd.SetFocus;
            //    Exit;
            //  end else
            //    raise;
            //end;
            //InitUsageCode(K, StrToIntDef(UsageCountEd.Text, 0), D1, FCode);
          end;
      5 : begin
            //I := StrToIntDef(NetworkSlotsEd.Text, 2);
            //if I < 1 then
            //  I := 1;
            //NetworkSlotsEd.Text := IntToStr(I);
            //EncodeNAFCountCode(K, I, FCode);
          end;
      6 : begin
            //try
            //  D1 := StrToDate(SpecialExpiresEd.Text);
            //except
            //  on EConvertError do begin
            //    ShowMessage(SCInvalidExDate);
            //    SpecialExpiresEd.SetFocus;
            //    Exit;
            //  end else
            //    raise;
            //end;
            //InitSpecialCode(K, StrToIntDef(SpecialDataEd.Text, 0), D1, FCode);
          end;
    end;

    edtRegCode.Text := BufferToHex(FCode, SizeOf(FCode));
  end
  else
    TfpgMessageDialog.Critical('', SCInvalidKeyOrModifier);
end;

procedure TCodeGenerationForm.btnOKClicked(Sender: TObject);
begin
  Close;
end;

procedure TCodeGenerationForm.pgCodeChanged(Sender: TObject; NewActiveSheet: TfpgTabSheet);
begin
  edtRegCode.Text := '';
  cbxNoModifier.Checked := True;
  edtModifier.Text := '';
end;

procedure TCodeGenerationForm.ModifierChanged(Sender: TObject);
const
  Busy: Boolean = False;
var
  L: LongInt;
  D: TDateTime;
  S: string;
  i: Integer;
begin
  if Busy then
    Exit;

  {set busy flag so that setting "Checked" won't recurse}
  Busy := True;
  try
    L := 0;

    if (Sender = cbxNoModifier) and cbxNoModifier.Checked then
    begin
      cbxUniqueModifier.Checked := False;
      cbxMachineModifier.Checked := False;
      cbxDateModifier.Checked := False;
      cbxStringModifier.Checked := False;
      edtModifier.ReadOnly := True;
    end
    else
    begin
      cbxNoModifier.Checked := False;
      edtModifier.ReadOnly := False;
    end;

(*
    if not UniqueModifierCb.Checked and
       not MachineModifierCb.Checked and
       not DateModifierCb.Checked and
       not StringModifierCb.Checked and                              {!!.11}
       (ModifierEd.Text = '') then begin                             {!!.11}
      NoModifierCb.Checked := True;
      ModifierEd.Color := clBtnFace;                                 {!!.11}
      ModifierEd.ReadOnly := True;                                   {!!.11}
    end;
*)
    if cbxMachineModifier.Checked then
    begin
      if L = 0 then
        L := GenerateMachineModifierPrim
      else
        L := L xor GenerateMachineModifierPrim;
    end;

    {set status of string field}
    edtModString.Enabled := cbxStringModifier.Checked;
    //if edtModString.Enabled then
    //  ModStringEd.Color := clWindow
    //else
    //  ModStringEd.Color := clBtnFace;

    if cbxStringModifier.Checked then
    begin
      S := edtModString.Text;
      {strip accented characters from the string}
      for i := Length(S) downto 1 do
        if Ord(S[i]) > 127 then
          Delete(S, i, 1);
      L := StringHashELF(S);
    end;

    {set status of date field}
    calModDate.Enabled := cbxDateModifier.Checked;
    //if ModDateEd.Enabled then
    //  ModDateEd.Color := clWindow
    //else
    //  ModDateEd.Color := clBtnFace;

    if cbxDateModifier.Checked then
    begin
      D := calModDate.DateValue;
      if Trunc(D) <> 0 then
      begin
        if L = 0 then
          L := GenerateDateModifierPrim(D)
        else
          L := L xor GenerateDateModifierPrim(D);
      end;
    end;

    if cbxUniqueModifier.Checked then
    begin
      if L = 0 then
        L := GenerateUniqueModifierPrim
      else
        L := L xor GenerateUniqueModifierPrim;
    end;

    if L = 0 then
      edtModifier.Text := ''
    else
      edtModifier.Text := '$' + BufferToHex(L, 4);
  finally
    Busy := False;
  end;
end;

procedure TCodeGenerationForm.btnSerialRandomClicked(Sender: TObject);
var
  I: Integer;
  L: LongInt;
  Bytes: array[0..3] of Byte absolute L;
begin
  for I := 0 to 3 do
    Bytes[I] := Random(256);
  edtSerialNumber.Text := IntToHex(L, 8);
end;

procedure TCodeGenerationForm.OGMCheck;
var
  F: TKeyMaintForm;
begin
  if not HexToBuffer(edtBlockKey.Text, FKey, SizeOf(FKey)) then
  begin
    {get a key}
    F := TKeyMaintForm.Create(nil);
    try
      F.SetKey(FKey);
      F.KeyType := ktRandom;
      F.KeyFileName := FKeyFileName;
      F.ShowHint := ShowHint;
      if F.ShowModal = mrOK then
      begin
        F.GetKey(FKey);
        edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
        if HexStringIsZero(edtBlockKey.Text) then
          edtBlockKey.Text := '';
        FKeyFileName := F.KeyFileName;
        InfoChanged(Self);
      end
      else
        OGMQuit;
    finally
      F.Free;
    end;
  end;
end;

procedure TCodeGenerationForm.OGMQuit;
begin
  ModalResult := mrCancel;
end;

constructor TCodeGenerationForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnCreate := @FormCreate;
  OnShow := @FormShow;
end;

procedure TCodeGenerationForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: CodeGenerationForm}
  Name := 'CodeGenerationForm';
  SetPosition(714, 208, 490, 478);
  WindowTitle := 'Code Generation';
  Hint := '';
  ShowHint := True;

  btnOK := TfpgButton.Create(self);
  with btnOK do
  begin
    Name := 'btnOK';
    SetPosition(316, 444, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'OK';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 1;
    OnClick := @btnOKClicked;
  end;

  btnCancel := TfpgButton.Create(self);
  with btnCancel do
  begin
    Name := 'btnCancel';
    SetPosition(400, 444, 80, 24);
    Anchors := [anRight,anBottom];
    Text := 'Cancel';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 2;
    OnClick := @btnOKClicked;
  end;

  pgCodes := TfpgPageControl.Create(self);
  with pgCodes do
  begin
    Name := 'pgCodes';
    SetPosition(4, 4, 482, 108);
    Anchors := [anLeft,anRight,anTop];
    Hint := '';
    TabOrder := 3;
    OnChange  := @pgCodeChanged;
  end;

  tsDate := TfpgTabSheet.Create(pgCodes);
  with tsDate do
  begin
    Name := 'tsDate';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'Date';
  end;

  tsDays := TfpgTabSheet.Create(pgCodes);
  with tsDays do
  begin
    Name := 'tsDays';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'Days';
  end;

  tsReg := TfpgTabSheet.Create(pgCodes);
  with tsReg do
  begin
    Name := 'tsReg';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'Reg';
  end;

  tsSerialNo := TfpgTabSheet.Create(pgCodes);
  with tsSerialNo do
  begin
    Name := 'tsSerialNo';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'S/N';
  end;

  tsUsage := TfpgTabSheet.Create(pgCodes);
  with tsUsage do
  begin
    Name := 'tsUsage';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'Usage';
  end;

  tsNetwork := TfpgTabSheet.Create(pgCodes);
  with tsNetwork do
  begin
    Name := 'tsNetwork';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'Network';
  end;

  tsSpecial := TfpgTabSheet.Create(pgCodes);
  with tsSpecial do
  begin
    Name := 'tsSpecial';
    SetPosition(3, 24, 476, 81);
    Anchors := [anLeft,anRight,anTop,anBottom];
    Text := 'Special';
  end;

  lblDateStart := TfpgLabel.Create(tsDate);
  with lblDateStart do
  begin
    Name := 'lblDateStart';
    SetPosition(8, 8, 104, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Start date:';
  end;

  calDateStart := TfpgCalendarCombo.Create(tsDate);
  with calDateStart do
  begin
    Name := 'calDateStart';
    SetPosition(120, 4, 120, 24);
    BackgroundColor := TfpgColor($80000002);
    DateFormat := 'yyyy-mm-dd';
    DayColor := TfpgColor($000000);
    FontDesc := '#List';
    Hint := '';
    HolidayColor := TfpgColor($000000);
    SelectedColor := TfpgColor($000000);
    TabOrder := 2;
    SingleClickSelect := True;
  end;

  lblDateEnd := TfpgLabel.Create(tsDate);
  with lblDateEnd do
  begin
    Name := 'lblDateEnd';
    SetPosition(8, 36, 104, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'End date:';
  end;

  calDateEnd := TfpgCalendarCombo.Create(tsDate);
  with calDateEnd do
  begin
    Name := 'calDateEnd';
    SetPosition(120, 32, 120, 24);
    BackgroundColor := TfpgColor($80000002);
    DateFormat := 'yyyy-mm-dd';
    DayColor := TfpgColor($000000);
    FontDesc := '#List';
    Hint := '';
    HolidayColor := TfpgColor($000000);
    SelectedColor := TfpgColor($000000);
    TabOrder := 4;
    SingleClickSelect := True;
  end;

  lblDaysCount := TfpgLabel.Create(tsDays);
  with lblDaysCount do
  begin
    Name := 'lblDaysCount';
    SetPosition(8, 8, 104, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Day count:';
  end;

  EditInteger1 := TfpgEditInteger.Create(tsDays);
  with EditInteger1 do
  begin
    Name := 'EditInteger1';
    SetPosition(120, 4, 120, 24);
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 2;
    Value := 0;
  end;

  lblDaysExpire := TfpgLabel.Create(tsDays);
  with lblDaysExpire do
  begin
    Name := 'lblDaysExpire';
    SetPosition(8, 36, 104, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Expires:';
  end;

  EditInteger2 := TfpgEditInteger.Create(tsDays);
  with EditInteger2 do
  begin
    Name := 'EditInteger2';
    SetPosition(120, 32, 120, 24);
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 4;
    Value := 0;
  end;

  GroupBox1 := TfpgGroupBox.Create(self);
  with GroupBox1 do
  begin
    Name := 'GroupBox1';
    SetPosition(4, 120, 482, 216);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Key used to encode';
  end;

  cbxNoModifier := TfpgCheckBox.Create(GroupBox1);
  with cbxNoModifier do
  begin
    Name := 'cbxNoModifier';
    SetPosition(8, 20, 120, 20);
    FontDesc := '#Label1';
    Hint := '';
    TabOrder := 1;
    Text := 'No modifier';
    OnChange  := @ModifierChanged;
  end;

  cbxMachineModifier := TfpgCheckBox.Create(GroupBox1);
  with cbxMachineModifier do
  begin
    Name := 'cbxMachineModifier';
    SetPosition(184, 20, 120, 20);
    FontDesc := '#Label1';
    Hint := '';
    TabOrder := 2;
    Text := 'Machine modifier';
    OnChange  := @ModifierChanged;
  end;

  cbxUniqueModifier := TfpgCheckBox.Create(GroupBox1);
  with cbxUniqueModifier do
  begin
    Name := 'cbxUniqueModifier';
    SetPosition(344, 20, 120, 20);
    FontDesc := '#Label1';
    Hint := '';
    TabOrder := 3;
    Text := 'Unique modifier';
    OnChange  := @ModifierChanged;
  end;

  cbxDateModifier := TfpgCheckBox.Create(GroupBox1);
  with cbxDateModifier do
  begin
    Name := 'cbxDateModifier';
    SetPosition(8, 48, 120, 20);
    FontDesc := '#Label1';
    Hint := '';
    TabOrder := 4;
    Text := 'Date modifier';
    OnChange  := @ModifierChanged;
  end;

  calModDate := TfpgCalendarCombo.Create(GroupBox1);
  with calModDate do
  begin
    Name := 'calModDate';
    SetPosition(140, 44, 120, 24);
    BackgroundColor := TfpgColor($80000002);
    DateFormat := 'yyyy-mm-dd';
    DayColor := TfpgColor($000000);
    FontDesc := '#List';
    Hint := '';
    HolidayColor := TfpgColor($000000);
    SelectedColor := TfpgColor($000000);
    TabOrder := 5;
    SingleClickSelect := True;
    OnChange := @ModifierChanged;
  end;

  cbxStringModifier := TfpgCheckBox.Create(GroupBox1);
  with cbxStringModifier do
  begin
    Name := 'cbxStringModifier';
    SetPosition(8, 76, 120, 20);
    FontDesc := '#Label1';
    Hint := '';
    TabOrder := 6;
    Text := 'String Modifier';
    OnChange  := @ModifierChanged;
  end;

  edtModString := TfpgEdit.Create(GroupBox1);
  with edtModString do
  begin
    Name := 'edtModString';
    SetPosition(140, 72, 332, 24);
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 7;
    Text := '';
    OnChange := @ModifierChanged;
  end;

  Label1 := TfpgLabel.Create(GroupBox1);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(8, 112, 80, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Modifier:';
  end;

  edtModifier := TfpgEdit.Create(GroupBox1);
  with edtModifier do
  begin
    Name := 'edtModifier';
    SetPosition(8, 128, 252, 24);
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 9;
    Text := '';
  end;

  Label2 := TfpgLabel.Create(GroupBox1);
  with Label2 do
  begin
    Name := 'Label2';
    SetPosition(8, 160, 80, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Key';
  end;

  edtBlockKey := TfpgEdit.Create(GroupBox1);
  with edtBlockKey do
  begin
    Name := 'edtBlockKey';
    SetPosition(8, 176, 428, 24);
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 11;
    Text := '';
  end;

  btnKeyMaint := TfpgButton.Create(GroupBox1);
  with btnKeyMaint do
  begin
    Name := 'btnKeyMaint';
    SetPosition(444, 176, 24, 24);
    Text := 'K';
    Flat := True;
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 12;
    OnClick  := @btnKeyMaintClicked;
  end;

  GroupBox2 := TfpgGroupBox.Create(self);
  with GroupBox2 do
  begin
    Name := 'GroupBox2';
    SetPosition(4, 344, 482, 72);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Generate Code';
  end;

  btnGenerate := TfpgButton.Create(GroupBox2);
  with btnGenerate do
  begin
    Name := 'btnGenerate';
    SetPosition(8, 28, 80, 24);
    Text := 'Generate';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 1;
    OnClick := @btnGenerateClicked;
  end;

  edtRegCode := TfpgEdit.Create(GroupBox2);
  with edtRegCode do
  begin
    Name := 'edtRegCode';
    SetPosition(96, 28, 340, 24);
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 2;
    Text := '';
  end;

  btnCopyToClipboard := TfpgButton.Create(GroupBox2);
  with btnCopyToClipboard do
  begin
    Name := 'btnCopyToClipboard';
    SetPosition(444, 28, 24, 24);
    Text := 'C';
    Flat := True;
    FontDesc := '#Label1';
    Hint := 'Copy to clipboard';
    ImageName := '';
    TabOrder := 3;
  end;

  Label3 := TfpgLabel.Create(tsSerialNo);
  with Label3 do
  begin
    Name := 'Label3';
    SetPosition(8, 8, 108, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Serial Number:';
  end;

  edtSerialNumber := TfpgEdit.Create(tsSerialNo);
  with edtSerialNumber do
  begin
    Name := 'edtSerialNumber';
    SetPosition(120, 4, 120, 24);
    ExtraHint := '';
    FontDesc := '#Edit1';
    Hint := '';
    TabOrder := 2;
    Text := '';
  end;

  btnSerialRandom := TfpgButton.Create(tsSerialNo);
  with btnSerialRandom do
  begin
    Name := 'btnSerialRandom';
    SetPosition(8, 40, 116, 24);
    Text := 'Random Number';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 3;
    OnClick := @btnSerialRandomClicked;
  end;

  Label4 := TfpgLabel.Create(tsSerialNo);
  with Label4 do
  begin
    Name := 'Label4';
    SetPosition(256, 8, 60, 16);
    FontDesc := '#Label1';
    Hint := '';
    Text := 'Expires:';
  end;

  calSerialExpires := TfpgCalendarCombo.Create(tsSerialNo);
  with calSerialExpires do
  begin
    Name := 'calSerialExpires';
    SetPosition(316, 4, 120, 24);
    BackgroundColor := TfpgColor($80000002);
    DateFormat := 'yyyy-mm-dd';
    DayColor := TfpgColor($000000);
    FontDesc := '#List';
    Hint := '';
    HolidayColor := TfpgColor($000000);
    SelectedColor := TfpgColor($000000);
    TabOrder := 5;
  end;

  {@VFD_BODY_END: CodeGenerationForm}
  {%endregion}

  { Simply to setup some of those component state, now that all the event
    handlers have been hooked up. }
//  ModifierChanged(cbxNoModifier);
end;

procedure TCodeGenerationForm.SetKey(Value: TKey);
begin
  FKey := Value;
  edtBlockKey.Text := BufferToHex(FKey, SizeOf(FKey));
  if HexStringIsZero(edtBlockKey.Text) then
    edtBlockKey.Text := '';
end;

procedure TCodeGenerationForm.GetKey(var Value: TKey);
begin
  Value := FKey;
end;


initialization
  Randomize;

end.
