program JsonDemo;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Utils.JSON.FromDataset in 'Utils.JSON.FromDataset.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
