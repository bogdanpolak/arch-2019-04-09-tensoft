unit Thread.InsertionSort;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Thread.Sort;

type
  TInsertionThread = class(TSortThread)
  protected
    procedure Execute; override;
  public
    class var IsWorking: boolean;
  end;

implementation

uses
  System.Diagnostics,
  WinApi.Windows;

{ TBubleThread }

procedure TInsertionThread.Execute;
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
  minIdx: Integer;
  minv: Integer;
begin
  IsWorking := True;
  sw := TStopwatch.StartNew;
  for i := 0 to FBoard.Count - 1 do
  begin
    minIdx := i;
    minv := FBoard.Data[i];
    for j := i + 1 to FBoard.Count - 1 do
    begin
      if FBoard.Data[j] < minv then
      begin
        minIdx := j;
        minv := FBoard.Data[j];
      end;
    end;
    if minIdx <> i then
      DoSwap(i, minIdx);
    if Terminated then
      break;
  end;
  Synchronize(
    procedure()
    begin
      DrawResults(FSwapPaintBox, 'InsertionSort', FBoard, sw.Elapsed);
    end);
  IsWorking := False;
end;

end.
