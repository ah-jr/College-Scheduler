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
    m_lstDisciplineData : TList<TList<String>>;

    procedure ReadFileData;
    procedure SaveFileData;
    procedure LoadFrames;
    procedure RedimDisciplinePanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure AddDiscipline(lstInfo : TList<String>; AddToDisciplineDataList : Boolean = True);
  end;

var
  SchedulerForm : TScheduler;

implementation

{$R *.dfm}

uses
  Math;

constructor TScheduler.Create(AOwner: TComponent);
begin
  inherited;
  m_lstDisciplines := TList<TDiscipline>.Create;
  m_lstDisciplineData := TList<TList<String>>.Create;

  ReadFileData;
  LoadFrames;
end;

destructor TScheduler.Destroy;
var
  DisciplineFrame : TDiscipline;
  ListItem        : TList<String>;
begin
  SaveFileData;

  for DisciplineFrame in m_lstDisciplines do
    DisciplineFrame.Free;

  for ListItem in m_lstDisciplineData do
    ListItem.Free;

  FreeAndNil(m_lstDisciplines);
  FreeAndNil(m_lstDisciplineData);

  inherited;
end;

procedure TScheduler.ReadFileData;
var
  DataFile   : TextFile;
  strContent : string;
  lstInfo    : TList<String>;
  nCount     : Integer;
const
  ItemCount = 9;
begin
  try
    AssignFile(DataFile, 'Data.txt');
    Reset(DataFile);

    nCount := ItemCount + 1;

    while not Eof(DataFile) do
    begin
      if nCount > ItemCount then
        begin
          lstInfo := TList<String>.Create;
          m_lstDisciplineData.Add(lstInfo);
          nCount  := 0;
        end;

      ReadLn(DataFile, strContent);
      lstInfo.Add(strContent);

      Inc(nCount);
    end;

    if nCount <> ItemCount then
      ShowMessage('Error : File badly formatted.');

    CloseFile(DataFile);
  except
    ShowMessage('Warning : Could not open file.');
  end;
end;

procedure TScheduler.SaveFileData;
var
  DataFile   : TextFile;
  strContent : String;
  ListItem   : TList<String>;
begin
  AssignFile(DataFile, 'Data.txt');
  ReWrite(DataFile);

  for ListItem in m_lstDisciplineData do
  begin
    for strContent in ListItem do
      WriteLn(DataFile, strContent);
  end;

  CloseFile(DataFile);
end;

procedure TScheduler.LoadFrames;
var
  ListItem    : TList<String>;
begin
  for ListItem in m_lstDisciplineData do
    begin
      AddDiscipline(ListItem, False);
    end;
end;

procedure TScheduler.RedimDisciplinePanel;
var
  nWiderFrame : Integer;
  nIndex      : Integer;
begin
  nWiderFrame := 0;
  for nIndex := 0 to sbDisciplines.ComponentCount - 1 do
    begin
      if sbDisciplines.Components[nIndex] is TFrame then
        nWiderFrame := Max(nWiderFrame, TFrame(sbDisciplines.Components[nIndex]).Width);
    end;

  nWiderFrame := Max(300, nWiderFrame);

  pnlDisciplines.Width := nWiderFrame + 50;
end;

procedure TScheduler.FormResize(Sender: TObject);
const
  TitleBarHeight = 35;
begin
  pnlDisciplines.Top    := 0;
  pnlDisciplines.Left   := 0;
  pnlDisciplines.Height       := Height-TitleBarHeight;
  RedimDisciplinePanel;

  pnlDates.Width        := Width - pnlDisciplines.Width;
  pnlDates.Height       := Height-TitleBarHeight;
  pnlDates.Left         := pnlDisciplines.Width;
  pnlDates.Top          := 0;
end;

procedure TScheduler.sbDisciplinesMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbDisciplines.VertScrollBar.Position := sbDisciplines.VertScrollBar.ScrollPos + 8;
end;

procedure TScheduler.sbDisciplinesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbDisciplines.VertScrollBar.Position := sbDisciplines.VertScrollBar.ScrollPos - 8;
end;

procedure TScheduler.AddDiscipline(lstInfo : TList<String>; AddToDisciplineDataList : Boolean = True);
var
  DisciplineFrame   : TDiscipline;
begin
  DisciplineFrame        := TDiscipline.Create(sbDisciplines);
  DisciplineFrame.Name   := 'DisciplineFrame' + IntToStr(m_lstDisciplines.Count);
  DisciplineFrame.Parent := sbDisciplines;
  DisciplineFrame.Top    := m_lstDisciplines.Count * (DisciplineFrame.Height + 15) + 10;
  DisciplineFrame.Left   := 10;
  DisciplineFrame.Show;

  DisciplineFrame.SetInfo(lstInfo);

  if AddToDisciplineDataList then
    m_lstDisciplineData.Add(lstInfo);

  m_lstDisciplines.Add(DisciplineFrame);
  FormResize(nil);
end;

procedure TScheduler.btnAddDisciplineClick(Sender: TObject);
var
  AddDisciplineForm : TDisciplineAdd;
begin
  AddDisciplineForm := TDisciplineAdd.Create(nil);
  AddDisciplineForm.Top  := Top;
  AddDisciplineForm.Left := Left + Width + 5;

  AddDisciplineForm.Show;
end;

end.
