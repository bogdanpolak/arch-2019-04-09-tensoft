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
  for i := 0 to Length(data) - 1 do
  begin
    minIdx := i;
    minv := data[i];
    for j := i + 1 to Length(data) - 1 do
    begin
      if data[j] < minv then
      begin
        minIdx := j;
        minv := data[j];
      end;
    end;
    if minIdx <> i then
      self.swap(i, minIdx);
    if Terminated then
      break;
  end;
  Synchronize(
    procedure()
    begin
      DrawResults(FSwapPaintBox, 'InsertionSort', Length(data), sw.Elapsed,
        SwapCounter);
    end);
  IsWorking := False;
end;

end.
