unit Discipline;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Winapi.ShellAPI;

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
    lblTeacherCnt: TLabel;
    lblTimeCnt: TLabel;
    lblClassCnt: TLabel;
    lblPassCnt: TLabel;
    lblGradeCnt: TLabel;
    btnEdit: TButton;
    btnDelete: TButton;
    procedure btnMoodleClick(Sender: TObject);
    procedure btnClassSiteClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);

  private
    strMoodleLink : String;
    strSiteLink   : String;

    ColorFrame    : TForm;

  public
    constructor Create(AOwner:TComponent);override;
    procedure SetInfo(lstInfo : TList<String>);
  end;

var
  DisciplineFrame: TDiscipline;

implementation

{$R *.dfm}

constructor TDiscipline.Create(AOwner: TComponent);
begin
  inherited;
  Brush.Style := bsClear;

  ColorFrame := TForm.Create(Self);
  ColorFrame.Parent := Self;
  ColorFrame.AlphaBlend := True;
  ColorFrame.BorderStyle := bsNone;
  ColorFrame.Color := clBlack;
  ColorFrame.Name := 'ColorFrame';

  ColorFrame.AlphaBlendValue := 30;
  ColorFrame.Show;
end;

procedure TDiscipline.FrameResize(Sender: TObject);
var
  nIndex : Integer;
begin
  ColorFrame.Top    := 0;
  ColorFrame.Left   := 0;
  ColorFrame.Width  := Width;
  ColorFrame.Height := Height;

  for nIndex := 0 to Self.ComponentCount - 1 do
    begin
      if (Self.Components[nIndex].Name <> 'ColorFrame') then
        begin
          TControl(Self.Components[nIndex]).BringToFront;
        end;
    end;
end;

procedure TDiscipline.btnClassSiteClick(Sender: TObject);
begin
  ShellExecute(Handle,
               'open',
               PWideChar(strSiteLink),
               nil,
               nil,
               SW_SHOWMAXIMIZED);
end;

procedure TDiscipline.btnMoodleClick(Sender: TObject);
begin
  ShellExecute(Handle,
               'open',
               PWideChar(strMoodleLink),
               nil,
               nil,
               SW_SHOWMAXIMIZED);
end;

procedure TDiscipline.SetInfo(lstInfo : TList<String>);
begin
  lblTitle.Caption      := lstInfo[0];
  lblCode.Caption       := lstInfo[1];
  lblTeacherCnt.Caption := lstInfo[2];
  lblClassCnt.Caption   := lstInfo[3];
  lblTimeCnt.Caption    := lstInfo[4];
  lblPassCnt.Caption    := lstInfo[5];
  lblGradeCnt.Caption   := lstInfo[6];

  strMoodleLink         := lstInfo[7];
  strSiteLink           := lstInfo[8];
end;

end.
