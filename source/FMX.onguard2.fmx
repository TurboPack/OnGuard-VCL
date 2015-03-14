object CodeGenerateFrm: TCodeGenerateFrm
  Left = 247
  Top = 137
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Code Generation'
  ClientHeight = 419
  ClientWidth = 464
  Position = ScreenCenter
  FormFactor.Width = 320
  FormFactor.Height = 480
  FormFactor.Devices = [Desktop, iPhone, iPad]
  OnCreate = FormCreate
  Left = 247
  Top = 137
  DesignerMasterStyle = 0
  object GenerateGb: TGroupBox
    Position.X = 4.000000000000000000
    Position.Y = 332.000000000000000000
    Size.Width = 457.000000000000000000
    Size.Height = 49.000000000000000000
    Size.PlatformDefault = False
    Text = 'Generate Code'
    TabOrder = 2
    object RegCodeCopySb: TSpeedButton
      Position.X = 422.000000000000000000
      Position.Y = 17.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = RegCodeCopySbClick
    end
    object GenerateBtn: TButton
      Default = True
      Position.X = 8.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 77.000000000000000000
      Size.Height = 25.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Generate'
      OnClick = GenerateBtnClick
    end
    object RegCodeEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 1
      ReadOnly = True
      Position.X = 96.000000000000000000
      Position.Y = 18.000000000000000000
      Size.Width = 323.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      OnChange = InfoChanged
    end
  end
  object OKBtn: TButton
    ModalResult = 1
    Position.X = 307.000000000000000000
    Position.Y = 389.000000000000000000
    Size.Width = 75.000000000000000000
    Size.Height = 25.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 3
    Text = 'OK'
    TextSettings.WordWrap = True
    OnClick = ParametersChanged
  end
  object CancelBtn: TButton
    ModalResult = 2
    Position.X = 386.000000000000000000
    Position.Y = 389.000000000000000000
    Size.Width = 75.000000000000000000
    Size.Height = 25.000000000000000000
    Size.PlatformDefault = False
    TabOrder = 0
    Text = 'Cancel'
    TextSettings.WordWrap = True
  end
  object GroupBox1: TGroupBox
    Position.X = 4.000000000000000000
    Position.Y = 136.000000000000000000
    Size.Width = 457.000000000000000000
    Size.Height = 193.000000000000000000
    Size.PlatformDefault = False
    Text = 'Key used to encode'
    TabOrder = 1
    object Label5: TLabel
      AutoSize = True
      Position.X = 12.000000000000000000
      Position.Y = 148.000000000000000000
      Size.Width = 26.000000000000000000
      Size.Height = 16.000000000000000000
      Size.PlatformDefault = False
      TextSettings.WordWrap = False
      Text = 'Key:'
    end
    object GenerateKeySb: TSpeedButton
      Position.X = 426.000000000000000000
      Position.Y = 163.000000000000000000
      Size.Width = 23.000000000000000000
      Size.Height = 23.000000000000000000
      Size.PlatformDefault = False
      StyleLookup = 'buttonstyle'
      TextSettings.WordWrap = True
      OnClick = GenerateKeySbClick
    end
    object Label1: TLabel
      AutoSize = True
      Position.X = 8.000000000000000000
      Position.Y = 107.000000000000000000
      Size.Width = 51.000000000000000000
      Size.Height = 16.000000000000000000
      Size.PlatformDefault = False
      TextSettings.WordWrap = False
      Text = 'Modifier:'
    end
    object UniqueModifierCb: TCheckBox
      Position.X = 304.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 105.000000000000000000
      Size.Height = 17.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 3
      Text = 'Unique modifier'
      OnClick = ModifierClick
    end
    object MachineModifierCb: TCheckBox
      Position.X = 152.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 105.000000000000000000
      Size.Height = 17.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 1
      Text = 'Machine modifier'
      OnClick = ModifierClick
    end
    object DateModifierCb: TCheckBox
      Position.X = 16.000000000000000000
      Position.Y = 48.000000000000000000
      Size.Width = 105.000000000000000000
      Size.Height = 17.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 2
      Text = 'Date modifier'
      OnClick = ModifierClick
    end
    object NoModifierCb: TCheckBox
      IsChecked = True
      Position.X = 16.000000000000000000
      Position.Y = 16.000000000000000000
      Size.Width = 105.000000000000000000
      Size.Height = 17.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'No modifier'
      OnClick = ModifierClick
    end
    object ModifierEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 4
      ReadOnly = True
      Position.X = 8.000000000000000000
      Position.Y = 124.000000000000000000
      Size.Width = 169.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      OnChange = ParametersChanged
    end
    object BlockKeyEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 5
      ReadOnly = True
      Position.X = 8.000000000000000000
      Position.Y = 164.000000000000000000
      Size.Width = 415.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      OnChange = InfoChanged
    end
    object StringModifierCb: TCheckBox
      Position.X = 16.000000000000000000
      Position.Y = 72.000000000000000000
      Size.Width = 97.000000000000000000
      Size.Height = 17.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 6
      Text = 'String Modifier'
      OnClick = ModifierClick
    end
    object ModStringEd: TEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      TabOrder = 7
      Position.X = 111.000000000000000000
      Position.Y = 69.000000000000000000
      Enabled = False
      Size.Width = 312.000000000000000000
      Size.Height = 21.000000000000000000
      Size.PlatformDefault = False
      OnChange = ModifierClick
    end
    object ModDateCalendarEdit: TDateEdit
      Touch.InteractiveGestures = [LongTap, DoubleTap]
      Date = 41737.000000000000000000
      Position.X = 112.000000000000000000
      Position.Y = 46.000000000000000000
      Size.Width = 100.000000000000000000
      Size.Height = 22.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 11
    end
  end
  object CodesTC: TTabControl
    Position.X = 8.000000000000000000
    Position.Y = 8.000000000000000000
    Size.Width = 449.000000000000000000
    Size.Height = 129.000000000000000000
    Size.PlatformDefault = False
    TabIndex = 5
    TabOrder = 4
    TabPosition = Top
    object TabItem1: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = False
      Size.Width = 45.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Date'
      object Label9: TLabel
        Position.X = 16.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 65.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Start date:'
      end
      object Label11: TLabel
        Position.X = 208.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 65.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'End date:'
      end
      object StartDateCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41736.000000000000000000
        OnChange = ParametersChanged
        Position.X = 80.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 2
      end
      object EndDateCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41736.000000000000000000
        OnChange = ParametersChanged
        Position.X = 272.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 3
      end
    end
    object TabItem2: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = False
      Size.Width = 45.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Days'
      object Label13: TLabel
        Position.X = 16.000000000000000000
        Position.Y = 24.000000000000000000
        Size.Width = 73.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Day count:'
      end
      object Label2: TLabel
        Position.X = 216.000000000000000000
        Position.Y = 24.000000000000000000
        Size.Width = 49.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Expires:'
      end
      object DaysCountSpinBox: TSpinBox
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        TabOrder = 2
        Cursor = crIBeam
        Max = 4294967040.000000000000000000
        Position.X = 88.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        OnChange = ParametersChanged
      end
      object DaysExpiresCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41736.000000000000000000
        OnChange = ParametersChanged
        Position.X = 272.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 3
      end
    end
    object TabItem3: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = False
      Size.Width = 40.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Reg'
      object Label6: TLabel
        Position.X = 8.000000000000000000
        Position.Y = 8.000000000000000000
        Size.Width = 41.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'String:'
      end
      object RegStrEd: TEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        TabOrder = 1
        Position.X = 48.000000000000000000
        Position.Y = 8.000000000000000000
        Size.Width = 361.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        OnChange = ParametersChanged
      end
      object RegStrCopySb: TSpeedButton
        Position.X = 416.000000000000000000
        Position.Y = 8.000000000000000000
        Size.Width = 25.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        StyleLookup = 'buttonstyle'
      end
      object RegRandomBtn: TButton
        Position.X = 48.000000000000000000
        Position.Y = 40.000000000000000000
        Size.Width = 105.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 3
        Text = '&Random Number'
        OnClick = RegRandomBtnClick
      end
      object Label4: TLabel
        Position.X = 192.000000000000000000
        Position.Y = 40.000000000000000000
        Size.Width = 49.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Expires:'
      end
      object RegExpiresCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41736.000000000000000000
        OnChange = ParametersChanged
        Position.X = 256.000000000000000000
        Position.Y = 40.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 5
      end
    end
    object TabItem4: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = False
      Size.Width = 39.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'S/N'
      object Label7: TLabel
        Position.X = 16.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 81.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Serial number:'
      end
      object Label15: TLabel
        Position.X = 240.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 49.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Expires:'
      end
      object SerialNumberNumberBox: TNumberBox
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        TabOrder = 2
        Cursor = crIBeam
        DecimalDigits = 0
        Max = 4294967040.000000000000000000
        Position.X = 96.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 121.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        OnChange = ParametersChanged
      end
      object SerialExpiresCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41737.000000000000000000
        OnChange = ParametersChanged
        Position.X = 296.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 3
      end
      object SerRandomBtn: TButton
        Position.X = 16.000000000000000000
        Position.Y = 48.000000000000000000
        Size.Width = 121.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 4
        Text = 'Random Number'
        OnClick = SerRandomBtnClick
      end
    end
    object TabItem5: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = False
      Size.Width = 53.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Usage'
      object Label14: TLabel
        Position.X = 16.000000000000000000
        Position.Y = 24.000000000000000000
        Size.Width = 73.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Usage count:'
      end
      object Label17: TLabel
        Position.X = 232.000000000000000000
        Position.Y = 24.000000000000000000
        Size.Width = 49.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Expires:'
      end
      object UsageCountNumberBox: TNumberBox
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        TabOrder = 2
        Cursor = crIBeam
        Max = 4294967040.000000000000000000
        Position.X = 96.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        OnChange = ParametersChanged
      end
      object UsageExpiresCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41737.000000000000000000
        OnChange = ParametersChanged
        Position.X = 288.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 3
      end
    end
    object TabItem6: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = True
      Size.Width = 66.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Network'
      object Label10: TLabel
        Position.X = 16.000000000000000000
        Position.Y = 24.000000000000000000
        Size.Width = 73.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Access slots:'
      end
      object NetworkSlotsNumberBox: TNumberBox
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        TabOrder = 1
        Cursor = crIBeam
        Min = 1.000000000000000000
        Max = 4294967040.000000000000000000
        Value = 2.000000000000000000
        Position.X = 104.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        OnChange = ParametersChanged
      end
    end
    object TabItem7: TTabItem
      CustomIcon = <
        item
        end>
      IsSelected = False
      Size.Width = 57.000000000000000000
      Size.Height = 24.000000000000000000
      Size.PlatformDefault = False
      TabOrder = 0
      Text = 'Special'
      object Label12: TLabel
        Position.X = 16.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 73.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Special data:'
      end
      object Label19: TLabel
        Position.X = 240.000000000000000000
        Position.Y = 16.000000000000000000
        Size.Width = 49.000000000000000000
        Size.Height = 17.000000000000000000
        Size.PlatformDefault = False
        Text = 'Expires:'
      end
      object SpecialDataNumberBox: TNumberBox
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        TabOrder = 2
        Cursor = crIBeam
        Max = 4294967296.000000000000000000
        Position.X = 88.000000000000000000
        Position.Y = 8.000000000000000000
        Size.Width = 121.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        OnChange = ParametersChanged
      end
      object SpecialExpiresCalendarEdit: TDateEdit
        Touch.InteractiveGestures = [LongTap, DoubleTap]
        Date = 41737.000000000000000000
        OnChange = ParametersChanged
        Position.X = 288.000000000000000000
        Position.Y = 8.000000000000000000
        Size.Width = 100.000000000000000000
        Size.Height = 22.000000000000000000
        Size.PlatformDefault = False
        TabOrder = 3
      end
    end
  end
end
