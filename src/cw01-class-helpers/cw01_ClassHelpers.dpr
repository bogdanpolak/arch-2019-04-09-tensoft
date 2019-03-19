program cw01_ClassHelpers;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Frame.DateTime in 'Frame.DateTime.pas' {FrameDateTime: TFrame},
  Helper.TWinControl in '..\helpers-repo\Helper.TWinControl.pas',
  Frame.DataSet in 'Frame.DataSet.pas' {FrameDataSet: TFrame},
  Helper.TDataSet in '..\helpers-repo\Helper.TDataSet.pas',
  Helper.TDateTime in '..\helpers-repo\Helper.TDateTime.pas',
  Helper.TDBGrid in '..\helpers-repo\Helper.TDBGrid.pas',
  Helper.TJSONObject in '..\helpers-repo\Helper.TJSONObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
