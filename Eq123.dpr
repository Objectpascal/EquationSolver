program Eq123;

uses
  Vcl.Forms,
  Main_u in 'Main_u.pas' {Form_Main},
  Equation_Solver in 'Equation_Solver.pas',
  problems_u in 'problems_u.pas' {form_Problems},
  solve_u in 'solve_u.pas' {FormSolve},
  Z_class_u in 'Z_class_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
