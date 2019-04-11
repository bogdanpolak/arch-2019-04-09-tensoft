unit Thread.BubbleSort;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Thread.Sort;

type
  TBubbleThread = class(TSortThread)
  protected
    procedure Execute; override;
  end;

var
  BubbleSortIsWorking: boolean;

implementation

uses
  System.Diagnostics,
  WinApi.Windows;

{ TBubleThread }

procedure TBubbleThread.Execute;
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
begin
  BubbleSortIsWorking := True;
  sw := TStopwatch.StartNew;
  for i := 0 to FBoard.Count - 1 do
    for j := 0 to FBoard.Count - 2 do
      if FBoard.Data[j] > FBoard.Data[j + 1] then
      begin
        if Self.Terminated then
          break;
        DoSwap(j, j + 1);
      end;
  Synchronize(
    procedure()
    begin
      DrawResults(FSwapPaintBox, 'Bubble Sort', FBoard, sw.Elapsed);
    end);
  BubbleSortIsWorking := False;
end;

end.
