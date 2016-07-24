object Form_Messenger_Main: TForm_Messenger_Main
  Left = 0
  Top = 0
  Caption = 'Delphi messenger'
  ClientHeight = 287
  ClientWidth = 564
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
  object Edit_Sended_Message: TEdit
    Left = 32
    Top = 236
    Width = 381
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit_Sended_MessageKeyPress
  end
  object Button_Send_Message: TButton
    Left = 456
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 1
    OnClick = Button_Send_MessageClick
  end
  object RichEdit: TRichEdit
    Left = 32
    Top = 20
    Width = 499
    Height = 201
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Zoom = 100
  end
  object TetheringAppProfile: TTetheringAppProfile
    Manager = TetheringManager
    Text = '@OnCreate'
    Actions = <>
    Resources = <>
    OnResourceReceived = TetheringAppProfileResourceReceived
    Left = 312
    Top = 164
  end
  object TetheringManager: TTetheringManager
    OnEndManagersDiscovery = TetheringManagerEndManagersDiscovery
    OnEndProfilesDiscovery = TetheringManagerEndProfilesDiscovery
    OnRequestManagerPassword = TetheringManagerRequestManagerPassword
    Text = '@OnCreate'
    AllowedAdapters = 'Network'
    Left = 192
    Top = 168
  end
  object ActionList: TActionList
    Left = 376
    Top = 152
  end
end
