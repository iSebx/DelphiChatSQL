object frm_Conversation: Tfrm_Conversation
  Left = 0
  Top = 0
  Caption = 'frm_Conversation'
  ClientHeight = 416
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Contact: TLabel
    Left = 120
    Top = 10
    Width = 115
    Height = 24
    Caption = 'lbl_Contact'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object img_ContactAvatar: TImage
    Left = 24
    Top = 10
    Width = 81
    Height = 80
  end
  object mm_Message: TMemo
    Left = 24
    Top = 96
    Width = 537
    Height = 257
    TabOrder = 0
  end
  object e_message: TEdit
    Left = 24
    Top = 360
    Width = 489
    Height = 33
    TabOrder = 1
  end
  object btn_Send: TButton
    Left = 519
    Top = 359
    Width = 42
    Height = 34
    Caption = 'Send'
    TabOrder = 2
  end
end
