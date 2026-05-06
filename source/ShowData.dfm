object frmData: TfrmData
  Left = 0
  Top = 0
  Caption = 'Data Segment'
  ClientHeight = 445
  ClientWidth = 404
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lvData: TListView
    Left = 0
    Top = 0
    Width = 404
    Height = 445
    Align = alClient
    Columns = <
      item
        Caption = 'Addr.'
      end
      item
        Caption = 'Name'
        Width = 100
      end
      item
        Caption = '0'
        Width = 28
      end
      item
        Caption = '1'
        Width = 28
      end
      item
        Caption = '2'
        Width = 28
      end
      item
        Caption = '3'
        Width = 28
      end
      item
        Caption = '4'
        Width = 28
      end
      item
        Caption = '5'
        Width = 28
      end
      item
        Caption = '6'
        Width = 28
      end
      item
        Caption = '7'
        Width = 28
      end>
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnData = lvDataData
    OnMouseDown = lvDataMouseDown
    OnMouseMove = lvDataMouseMove
  end
end
