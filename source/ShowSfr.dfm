object frmSfr: TfrmSfr
  Left = 0
  Top = 0
  Caption = 'Special function registers (SFR)'
  ClientHeight = 530
  ClientWidth = 206
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvData: TListView
    Left = 0
    Top = 0
    Width = 206
    Height = 530
    Align = alClient
    Columns = <
      item
        Caption = 'Addr.'
      end
      item
        Caption = 'Name'
        Width = 80
      end
      item
        Caption = 'Value'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnData = lvDataData
    OnMouseDown = lvDataMouseDown
    OnMouseMove = lvDataMouseMove
  end
end
