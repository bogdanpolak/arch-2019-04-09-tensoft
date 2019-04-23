program SortDemo;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Colors.Hsl in 'Colors.Hsl.pas',
  Thread.BubbleSort in 'Thread.BubbleSort.pas',
  Thread.QuickSort in 'Thread.QuickSort.pas',
  Thread.Sort in 'Thread.Sort.pas',
  Thread.InsertionSort in 'Thread.InsertionSort.pas',
  Model.Board in 'Model.Board.pas',
  View.Board in 'View.Board.pas',
  Component.SortManager in 'Component.SortManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
