program delphiJson;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Car in 'Car.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
