object frm_OnLine: Tfrm_OnLine
  Left = 0
  Top = 0
  Caption = 'frm_OnLine'
  ClientHeight = 619
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_User: TLabel
    Left = 120
    Top = 32
    Width = 84
    Height = 24
    Caption = 'lbl_User'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object img_avatar: TImage
    Left = 24
    Top = 32
    Width = 81
    Height = 80
  end
  object lbl_UserConnected: TLabel
    Left = 120
    Top = 96
    Width = 90
    Height = 13
    Caption = 'lbl_UserConnected'
  end
  object lb_Contact: TListBox
    Left = 24
    Top = 128
    Width = 265
    Height = 449
    ItemHeight = 13
    TabOrder = 0
  end
  object btn_Disconect: TButton
    Left = 214
    Top = 583
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
  end
  object cb_ConnectState: TComboBox
    Left = 120
    Top = 62
    Width = 145
    Height = 21
    TabOrder = 2
    Text = 'cb_ConnectState'
  end
end
