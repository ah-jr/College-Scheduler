object Scheduler: TScheduler
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 946
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Enabled = True
  GlassFrame.SheetOfGlass = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlContent: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 946
    Align = alClient
    BevelOuter = bvSpace
    TabOrder = 0
    object pnlDates: TPanel
      Left = 300
      Top = 10
      Width = 444
      Height = 232
      BevelOuter = bvNone
      TabOrder = 0
      object pnlDatesContent: TPanel
        Left = 0
        Top = 41
        Width = 444
        Height = 191
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlDatesButton: TPanel
        Left = 0
        Top = 0
        Width = 444
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object btnAddDate: TButton
          Left = 0
          Top = 0
          Width = 444
          Height = 41
          Align = alClient
          Caption = 'Add Date'
          TabOrder = 0
        end
      end
    end
    object pnlDisciplines: TPanel
      Left = 10
      Top = 10
      Width = 272
      Height = 415
      BevelOuter = bvNone
      TabOrder = 1
      object pnlDisciplineButton: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnAddDiscipline: TButton
          Left = 0
          Top = 0
          Width = 272
          Height = 41
          Align = alClient
          Caption = 'Add Discipline'
          TabOrder = 0
          OnClick = btnAddDisciplineClick
        end
      end
    end
  end
end
