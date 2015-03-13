object KeyGenerateFrm: TKeyGenerateFrm
  Left = 351
  Top = 190
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Key Generation'
  ClientHeight = 235
  ClientWidth = 464
  Position = ScreenCenter
  FormFactor.Width = 320
  FormFactor.Height = 480
  FormFactor.Devices = [Desktop, iPhone, iPad]
  OnCreate = FormCreate
  OnShow = FormShow
  Left = 351
  Top = 190
  DesignerMasterStyle = 0
  object Panel1: TPanel
    Position.X = 4.000000000000000000
    Position.Y = 6.000000000000000000
    Size.Width = 455.000000000000000000
    Size.Height = 191.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 0
    object Label2: TLabel
      AutoSize = True
      Position.X = 8.000000000000000000
      Position.Y = 32.000000000000000000
      Size.Width = 64.000000000000000000
      Size.Height = 16.000000000000000000
      Size.PlatformDefault = False
      TextSettings.WordWrap = False
      Text = 'Key Phrase:'
    end
    object CopyBlockSb: TSpeedButton
      Position.X = 426.000000000000000000
      Position.Y = 131.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = CopyBlockSbClick
    end
    object Label3: TLabel
      AutoSize = True
      Position.X = 8.000000000000000000
      Position.Y = 112.000000000000000000
      Size.Width = 26.000000000000000000
      Size.Height = 16.000000000000000000
      Size.PlatformDefault = False
      TextSettings.WordWrap = False
      Text = 'Key:'
    end
    object Label4: TLabel
      AutoSize = True
      Position.X = 8.000000000000000000
      Position.Y = 12.000000000000000000
      Size.Width = 54.000000000000000000
      Size.Height = 16.000000000000000000
      Size.PlatformDefault = False
      TextSettings.WordWrap = False
      Text = 'Key Type:'
    end
    object CopyByteKeySb: TSpeedButton
      Position.X = 426.000000000000000000
      Position.Y = 159.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = CopyByteKeySbClick
    end
    object KeyStringMe: TMemo
      Touch.InteractiveGestures = [Pan, LongTap, DoubleTap]
      DataDetectorTypes = []
      OnChange = KeyStringMeChange
      Position.X = 8.000000000000000000
      Position.Y = 48.000000000000000000
      Size.Width = 440.000000000000000000
      Size.Height = 49.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 1
      Viewport.Width = 436.000000000000000000
      Viewport.Height = 45.000000000000000000
    end
    object BlockKeyEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 3
      ReadOnly = True
      Position.X = 8.000000000000000000
      Position.Y = 132.000000000000000000
      Size.Width = 415.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      OnChange = BlockKeyEdChange
    end
    object GenerateBtn: TButton
      Enabled = False
      Position.X = 344.000000000000000000
      Position.Y = 9.000000000000000000
      Size.Width = 103.000000000000000000
      Size.Height = 25.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 2
      Text = 'Generate key'
      OnClick = GenerateBtnClick
    end
    object KeyTypeCb: TComboBox
      DisableFocusEffect = False
      Position.X = 64.000000000000000000
      Position.Y = 8.000000000000000000
      Size.Width = 169.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      OnChange = KeyTypeCbChange
      object TListBoxItem
        TabOrder = 0
        Text = 'Random'
      end
      object TListBoxItem
        TabOrder = 1
        Text = 'Standard Text'
      end
      object TListBoxItem
        TabOrder = 2
        Text = 'Case-sensitive Text'
      end
    end
    object ByteKeyEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 4
      ReadOnly = True
      Position.X = 8.000000000000000000
      Position.Y = 160.000000000000000000
      Size.Width = 415.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      OnChange = ByteKeyEdChange
    end
  end
  object CancelBtn: TButton
    ModalResult = 2
    Position.X = 384.000000000000000000
    Position.Y = 204.000000000000000000
    Size.Width = 75.000000000000000000
    Size.Height = 25.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 2
    Text = 'Cancel'
    TextSettings.WordWrap = True
  end
  object OKBtn: TButton
    Default = True
    ModalResult = 1
    Position.X = 305.000000000000000000
    Position.Y = 204.000000000000000000
    Size.Width = 75.000000000000000000
    Size.Height = 25.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 1
    Text = 'OK'
    TextSettings.WordWrap = True
  end
end
