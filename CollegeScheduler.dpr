program CollegeScheduler;

uses
  Vcl.Forms,
  Scheduler in 'Scheduler.pas' {Form1},
  DisciplineAdd in 'DisciplineAdd.pas' {Form2},
  DateAdd in 'DateAdd.pas' {Form3},
  Discipline in 'Discipline.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TScheduler, SchedulerForm);
  Application.Run;
end.
