program cw01_ClassHelpers;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Frame.DateTime in 'Frame.DateTime.pas' {FrameDateTime: TFrame},
  Helper.TDateTime in '..\helpers-repo\Helper.TDateTime.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
