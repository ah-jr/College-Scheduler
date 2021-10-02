unit Discipline;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDiscipline = class(TFrame)
    lblTitle: TLabel;
    lblCode: TLabel;
    lblTeacher: TLabel;
    lblTime: TLabel;
    lblPass: TLabel;
    lblClass: TLabel;
    lblGrade: TLabel;
    btnMoodle: TButton;
    btnClassSite: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DisciplineFrame: TDiscipline;

implementation

{$R *.dfm}

end.
