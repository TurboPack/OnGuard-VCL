object KeyMaintFrm: TKeyMaintFrm
  Left = 264
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Key Maintenance'
  ClientHeight = 333
  ClientWidth = 464
  Position = ScreenCenter
  FormFactor.Width = 320
  FormFactor.Height = 480
  FormFactor.Devices = [Desktop, iPhone, iPad]
  OnCreate = FormCreate
  Left = 264
  Top = 169
  DesignerMasterStyle = 0
  object ProductsGb: TGroupBox
    Position.X = 6.000000000000000000
    Position.Y = 52.000000000000000000
    Size.Width = 454.000000000000000000
    Size.Height = 173.000000000000000000
    Size.PlatformDefault = False
    Text = 'Applications'
    TabOrder = 1
    object ProductsLb: TListBox
      Position.X = 8.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 343.000000000000000000
      Size.Height = 148.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      OnClick = InfoChanged
      OnDblClick = ProductsLbDblClick
      DisableFocusEffect = True
      ItemHeight = 13.000000000000000000
      DefaultItemStyles.ItemStyle = ''
      DefaultItemStyles.GroupHeaderStyle = ''
      DefaultItemStyles.GroupFooterStyle = ''
      Viewport.Width = 339.000000000000000000
      Viewport.Height = 144.000000000000000000
    end
    object AddBtn: TButton
      Position.X = 357.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 90.000000000000000000
      Size.Height = 25.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 1
      Text = 'Add...'
      OnClick = AddBtnClick
    end
    object DeleteBtn: TButton
      Position.X = 357.000000000000000000
      Position.Y = 112.000000000000000000
      Size.Width = 90.000000000000000000
      Size.Height = 25.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 3
      Text = 'Delete'
      OnClick = DeleteBtnClick
    end
    object EditBtn: TButton
      Position.X = 357.000000000000000000
      Position.Y = 48.000000000000000000
      Size.Width = 90.000000000000000000
      Size.Height = 25.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 2
      Text = 'Edit...'
      OnClick = EditBtnClick
    end
  end
  object OKBtn: TButton
    Default = True
    ModalResult = 1
    Position.X = 305.000000000000000000
    Position.Y = 304.000000000000000000
    Size.Width = 75.000000000000000000
    Size.Height = 25.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 2
    Text = 'OK'
    TextSettings.WordWrap = True
  end
  object CancelBtn: TButton
    ModalResult = 2
    Position.X = 385.000000000000000000
    Position.Y = 304.000000000000000000
    Size.Width = 75.000000000000000000
    Size.Height = 25.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 3
    Text = 'Cancel'
    TextSettings.WordWrap = True
  end
  object FileNameGb: TGroupBox
    Position.X = 7.000000000000000000
    Position.Y = 2.000000000000000000
    Size.Width = 454.000000000000000000
    Size.Height = 47.000000000000000000
    Size.PlatformDefault = False
    Text = 'File name'
    TabOrder = 0
    object OpenFileSb: TSpeedButton
      Position.X = 326.000000000000000000
      Position.Y = 15.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = OpenFileSbClick
    end
    object FileNameEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 0
      Position.X = 8.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 315.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
    end
    object OpenBtn: TButton
      Position.X = 357.000000000000000000
      Position.Y = 14.000000000000000000
      Size.Width = 90.000000000000000000
      Size.Height = 25.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 1
      Text = 'Open'
      TextSettings.WordWrap = True
      OnClick = OpenBtnClick
    end
  end
  object GroupBox1: TGroupBox
    Position.X = 6.000000000000000000
    Position.Y = 228.000000000000000000
    Size.Width = 454.000000000000000000
    Size.Height = 70.000000000000000000
    Size.PlatformDefault = False
    Text = 'Key'
    TabOrder = 4
    object CopyBlockKeySb: TSpeedButton
      Position.X = 398.000000000000000000
      Position.Y = 15.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = KeyCopySbClick
    end
    object CopyByteKeySb: TSpeedButton
      Position.X = 398.000000000000000000
      Position.Y = 41.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = CopyByteKeySbClick
    end
    object KeyPasteSb: TSpeedButton
      Position.X = 425.000000000000000000
      Position.Y = 15.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = KeyPasteSbClick
    end
    object SpeedButton1: TSpeedButton
      Position.X = 425.000000000000000000
      Position.Y = 41.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = SpeedButton1Click
    end
    object BlockKeyEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 0
      Position.X = 8.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 388.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
    end
    object BytesKeyEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 1
      Position.X = 8.000000000000000000
      Position.Y = 41.000000000000000000
      Size.Width = 388.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ini'
    FileName = 
      'C:\projects\components\tp\onguard\OnGuard\examples\Delphi\RegDem' +
      'o\OnGuard.ini'
    Filter = 'INI Files (*.ini)|*.ini|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofCreatePrompt]
    Title = 'Select Key Maintenance File'
    Left = 152
    Top = 304
  end
end
