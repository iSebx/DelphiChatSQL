object frm_InittSession: Tfrm_InittSession
  Left = 0
  Top = 0
  Caption = 'Delphi Chat'
  ClientHeight = 419
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 200
    Width = 52
    Height = 13
    Caption = 'User Name'
  end
  object Label2: TLabel
    Left = 120
    Top = 264
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object img_avatar: TImage
    Left = 67
    Top = 24
    Width = 158
    Height = 161
  end
  object e_UserName: TEdit
    Left = 32
    Top = 224
    Width = 225
    Height = 21
    TabOrder = 0
    Text = 'Seb'
  end
  object e_Password: TEdit
    Left = 32
    Top = 288
    Width = 225
    Height = 21
    TabOrder = 1
    Text = '3001'
  end
  object btn_connect: TButton
    Left = 104
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = btn_connectClick
  end
  object btn_Register: TButton
    Left = 104
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Register'
    TabOrder = 3
  end
  object ADO_Connection: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=DelphiChatDB;Data Source=LI' +
      'OTTA;Initial File Name="";Server SPN=""'
    Provider = 'SQLNCLI11.1'
    Left = 224
    Top = 360
  end
  object ADOStoredProc1: TADOStoredProc
    Connection = ADO_Connection
    Parameters = <>
    Left = 224
    Top = 312
  end
end
