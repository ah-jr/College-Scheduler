unit Scheduler;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  DWMApi,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DisciplineAdd,
  DateAdd,
  Discipline,
  System.Types;

type
  TScheduler = class(TForm)
    pnlDisciplines: TPanel;
    pnlDates: TPanel;
    btnAddDate: TButton;
    btnAddDiscipline: TButton;
    pnlDisciplineButton: TPanel;
    pnlDatesContent: TPanel;
    pnlDatesButton: TPanel;
    pnlContent: TPanel;
    procedure btnAddDisciplineClick(Sender: TObject);
//    procedure sbDisciplinesMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
//    procedure sbDisciplinesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    m_lstDisciplines : TList<TDiscipline>;
    m_lstDisciplineData : TList<TList<String>>;

    LeftFrame : TForm;

    procedure ReadFileData;
    procedure SaveFileData;
    procedure LoadFrames;
    procedure RedimDisciplinePanel;
    procedure UpdateForms;

    procedure EnableBlur(hwndHandle : HWND; nMode : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure AddDiscipline(lstInfo : TList<String>; AddToDisciplineDataList : Boolean = True);
  end;

  AccentPolicy = packed record
    AccentState: Integer;
    AccentFlags: Integer;
    GradientColor: Integer;
    AnimationId: Integer;
  end;

  WindowCompositionAttributeData = packed record
    Attribute: Cardinal;
    Data: Pointer;
    SizeOfData: Integer;
  end;

var
  SchedulerForm : TScheduler;
  SetWindowCompositionAttribute:function (hWnd: HWND; var data: WindowCompositionAttributeData):integer; stdcall;

implementation

{$R *.dfm}

uses
  Math;

constructor TScheduler.Create(AOwner: TComponent);
begin
  inherited;
  m_lstDisciplines := TList<TDiscipline>.Create;
  m_lstDisciplineData := TList<TList<String>>.Create;

  LeftFrame := TForm.Create(pnlDisciplines);
  LeftFrame.Parent := pnlDisciplines;
  LeftFrame.AlphaBlend := True;
  LeftFrame.BorderStyle := bsNone;
  LeftFrame.Color := clBlack;

  LeftFrame.AlphaBlendValue := 30;

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
  for nIndex := 0 to pnlDisciplines.ComponentCount - 1 do
    begin
      if pnlDisciplines.Components[nIndex] is TFrame then
        begin
          nWiderFrame := Max(nWiderFrame, TFrame(pnlDisciplines.Components[nIndex]).Width);
        end;
    end;

  nWiderFrame := Max(300, nWiderFrame);

  pnlDisciplines.Width := nWiderFrame + 50;
end;

procedure TScheduler.FormCreate(Sender: TObject);
begin
  //pnlDisciplineButton.Parent  := LeftFrame;
  //pnlDisciplineContent.Parent := LeftFrame;

  //pnlDisciplineButton.BringToFront;
  //pnlDisciplineContent.BringToFront;

  EnableBlur(Handle, 4);
end;

procedure TScheduler.UpdateForms;
var
  nIndex      : Integer;
begin
  if not LeftFrame.Visible then
    LeftFrame.Show;

  LeftFrame.Left   := 0;
  LeftFrame.Top    := 0;
  LeftFrame.Height := pnlDisciplines.Height;
  LeftFrame.Width  := pnlDisciplines.Width;

  for nIndex := 0 to pnlDisciplines.ComponentCount - 1 do
    begin
      if pnlDisciplines.Components[nIndex] is TFrame then
        begin
          TFrame(pnlDisciplines.Components[nIndex]).BringToFront;
        end;
    end;
end;

procedure TScheduler.FormResize(Sender: TObject);
const
  TitleBarHeight = 35;
begin
  pnlDisciplines.Top    := 0;
  pnlDisciplines.Left   := 0;
  pnlDisciplines.Height := Height-TitleBarHeight;
  RedimDisciplinePanel;

  pnlDates.Width        := Width - pnlDisciplines.Width;
  pnlDates.Height       := Height-TitleBarHeight-100;
  pnlDates.Left         := pnlDisciplines.Width;
  pnlDates.Top          := 0;

  UpdateForms;
end;

procedure TScheduler.FormShow(Sender: TObject);
begin
  FormResize(nil);
end;

//procedure TScheduler.sbDisciplinesMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
//begin
//  sbDisciplines.VertScrollBar.Position := sbDisciplines.VertScrollBar.ScrollPos + 8;
//end;
//
//procedure TScheduler.sbDisciplinesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
//begin
//  sbDisciplines.VertScrollBar.Position := sbDisciplines.VertScrollBar.ScrollPos - 8;
//end;

procedure TScheduler.AddDiscipline(lstInfo : TList<String>; AddToDisciplineDataList : Boolean = True);
var
  DisciplineFrame   : TDiscipline;
begin
  DisciplineFrame        := TDiscipline.Create(pnlDisciplines);
  DisciplineFrame.Name   := 'DisciplineFrame' + IntToStr(m_lstDisciplines.Count);
  DisciplineFrame.Parent := pnlDisciplines;
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

procedure TScheduler.EnableBlur(hwndHandle : HWND; nMode : Integer);
const
  WCA_ACCENT_POLICY = 19;
  ACCENT_ENABLE_BLURBEHIND = 3;
  ACCENT_ENABLE_ACRYLICBLURBEHIND = 4;
var
  dwm10: THandle;
  data: WindowCompositionAttributeData;
  accent: AccentPolicy;
  clColor : TColor;
  blurAmount : Byte;
begin
  dwm10 := LoadLibrary('user32.dll');

  if nMode = 3 then
  begin
    clColor := $252525;
    blurAmount := 235;
  end
  else
  begin
    clColor := $202020;
    blurAmount := 200;
  end;

  try
    @SetWindowCompositionAttribute := GetProcAddress(dwm10, 'SetWindowCompositionAttribute');
    if @SetWindowCompositionAttribute <> nil then
    begin
      accent.AccentState := nMode;
      accent.AccentFlags := 2;
      accent.GradientColor := (blurAmount SHL 24) or clColor;
      data.Attribute := WCA_ACCENT_POLICY;
      data.SizeOfData := SizeOf(accent);
      data.Data := @accent;
      SetWindowCompositionAttribute(hwndHandle, data);
    end
    else
    begin
      ShowMessage('Not found Windows 10 SetWindowCompositionAttribute in user32.dll');
    end;
  finally
    FreeLibrary(dwm10);
  end;
end;

end.
