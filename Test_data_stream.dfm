object frmTestDataStream: TfrmTestDataStream
  Left = 0
  Top = 0
  Caption = 'Test data stream'
  ClientHeight = 152
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 33
    Width = 74
    Height = 13
    Caption = 'Data delimeter:'
  end
  object Label2: TLabel
    Left = 37
    Top = 69
    Width = 63
    Height = 13
    Caption = 'Series count:'
  end
  object Label3: TLabel
    Left = 34
    Top = 102
    Width = 66
    Height = 13
    Caption = 'Interval (ms):'
  end
  object Label4: TLabel
    Left = 32
    Top = 134
    Width = 100
    Height = 13
    Caption = 'String end - $0D $0A'
  end
  object btnStartStop: TBitBtn
    Left = 339
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Start'
    Default = True
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 0
    OnClick = btnStartStopClick
  end
  object btnExit: TBitBtn
    Left = 339
    Top = 118
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Exit'
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnExitClick
  end
  object edDelimeter: TEdit
    Left = 106
    Top = 25
    Width = 39
    Height = 30
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Text = ','
  end
  object edSeriesCount: TEdit
    Left = 106
    Top = 66
    Width = 39
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object edInterval: TEdit
    Left = 106
    Top = 99
    Width = 39
    Height = 21
    TabOrder = 4
    Text = '20'
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 308
    Top = 32
  end
end
