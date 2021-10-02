unit Scheduler;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DisciplineAdd,
  DateAdd,
  Discipline;

type
  TScheduler = class(TForm)
    pnlDisciplines: TPanel;
    pnlDates: TPanel;
    btnAddDate: TButton;
    btnAddDiscipline: TButton;
    pnlDisciplineContent: TPanel;
    pnlDisciplineButton: TPanel;
    pnlDatesContent: TPanel;
    pnlDatesButton: TPanel;
    sbDisciplines: TScrollBox;
    procedure btnAddDisciplineClick(Sender: TObject);
    procedure sbDisciplinesMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure sbDisciplinesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);

  private
    m_lstDisciplines : TList<TDiscipline>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;
  end;

var
  SchedulerForm : TScheduler;

implementation

{$R *.dfm}

constructor TScheduler.Create(AOwner: TComponent);
begin
  inherited;
  m_lstDisciplines := TList<TDiscipline>.Create;
end;

destructor TScheduler.Destroy;
var
  DisciplineFrame : TDiscipline;
begin
  for DisciplineFrame in m_lstDisciplines do
    DisciplineFrame.Free;

  FreeAndNil(m_lstDisciplines);

  inherited;
end;

procedure TScheduler.FormResize(Sender: TObject);
begin
  pnlDisciplines.Width := Width - pnlDates.Width;
end;

procedure TScheduler.sbDisciplinesMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbDisciplines.VertScrollBar.Position := sbDisciplines.VertScrollBar.ScrollPos + 8;
end;

procedure TScheduler.sbDisciplinesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbDisciplines.VertScrollBar.Position := sbDisciplines.VertScrollBar.ScrollPos - 8;
end;

procedure TScheduler.btnAddDisciplineClick(Sender: TObject);
var
  AddDisciplineForm : TDisciplineAdd;
  DisciplineFrame   : TDiscipline;
begin
  //AddDisciplineForm := TDisciplineAdd.Create(nil);
  //AddDisciplineForm.Show;

  DisciplineFrame := TDiscipline.Create(sbDisciplines);
  DisciplineFrame.Name := 'DisciplineFrame' + IntToStr(m_lstDisciplines.Count);
  DisciplineFrame.Parent := sbDisciplines;
  DisciplineFrame.Show;
  DisciplineFrame.Top := m_lstDisciplines.Count * DisciplineFrame.Height + 5;

  m_lstDisciplines.Add(DisciplineFrame);

end;

end.
