unit Thread.QuickSort;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Thread.Sort;

type
  TQuickThread = class(TSortThread)
  protected
    procedure Execute; override;
  end;

var
  QuickSortIsWorking: boolean;

implementation

uses
  System.Diagnostics,
  WinApi.Windows;

procedure TQuickThread.Execute;
  procedure qsort(idx1, idx2: integer);
  var
    i: integer;
    j: integer;
    mediana: integer;
  begin
    if Terminated then
      exit;
    i := idx1;
    j := idx2;
    mediana := data[(i + j) div 2];
    repeat
      while data[i] < mediana do
        inc(i);
      while mediana < data[j] do
        dec(j);
      if i <= j then
      begin
        self.swap(i, j);
        inc(i);
        dec(j);
      end;
    until i > j;
    if idx1 < j then
      qsort(idx1, j);
    if i < idx2 then
      qsort(i, idx2);
  end;

var
  sw: TStopwatch;
begin
  QuickSortIsWorking := True;
  sw := TStopwatch.StartNew;
  qsort(0, Length(data) - 1);
  Synchronize(
    procedure()
    begin
      DrawResults(FSwapPaintBox, 'QuickSort', Length(data), sw.Elapsed,
        SwapCounter);
    end);
  QuickSortIsWorking := False;
end;

end.
