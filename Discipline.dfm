object Discipline: TDiscipline
  Tag = 1
  Left = 0
  Top = 0
  Width = 248
  Height = 157
  AutoSize = True
  TabOrder = 0
  OnResize = FrameResize
  object lblTitle: TLabel
    Left = 0
    Top = 0
    Width = 45
    Height = 19
    Caption = 'Title'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lblCode: TLabel
    Left = 0
    Top = 22
    Width = 24
    Height = 13
    Caption = 'Code'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lblTeacher: TLabel
    Left = 0
    Top = 40
    Width = 54
    Height = 13
    Caption = 'Teacher: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object lblTime: TLabel
    Left = 0
    Top = 76
    Width = 36
    Height = 13
    Caption = 'Time: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object lblPass: TLabel
    Left = 0
    Top = 94
    Width = 72
    Height = 13
    Caption = 'Moodle Pass:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object lblClass: TLabel
    Left = 0
    Top = 58
    Width = 42
    Height = 13
    Caption = 'Class: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object lblGrade: TLabel
    Left = 0
    Top = 112
    Width = 42
    Height = 13
    Caption = 'Grade: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
  end
  object lblTeacherCnt: TLabel
    Left = 81
    Top = 40
    Width = 42
    Height = 13
    Caption = 'Teacher'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTimeCnt: TLabel
    Left = 81
    Top = 76
    Width = 24
    Height = 13
    Caption = 'Time'
    Font.Charset = OEM_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblClassCnt: TLabel
    Left = 81
    Top = 58
    Width = 30
    Height = 13
    Caption = 'Class'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPassCnt: TLabel
    Left = 81
    Top = 94
    Width = 66
    Height = 13
    Caption = 'Moodle Pass'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblGradeCnt: TLabel
    Left = 81
    Top = 112
    Width = 30
    Height = 13
    Caption = 'Grade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnMoodle: TButton
    Left = 0
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Moodle'
    TabOrder = 0
    OnClick = btnMoodleClick
  end
  object btnClassSite: TButton
    Left = 81
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Class Site'
    TabOrder = 1
    OnClick = btnClassSiteClick
  end
  object btnEdit: TButton
    Left = 162
    Top = 132
    Width = 40
    Height = 25
    Caption = 'Edit'
    TabOrder = 2
  end
  object btnDelete: TButton
    Left = 208
    Top = 132
    Width = 40
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
  end
end
