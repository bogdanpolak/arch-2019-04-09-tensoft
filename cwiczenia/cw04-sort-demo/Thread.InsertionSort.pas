unit Thread.InsertionSort;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Thread.Sort;

type
  TInsertionThread = class(TSortThread)
  private
    procedure Sort;
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
  sw: TStopwatch;
begin
  IsWorking := True;
  try
    sw := TStopwatch.StartNew;
    Sort;
    DoSynchroDrawSummary('InsertionSort', sw.Elapsed);
  finally
    IsWorking := False;
  end;
end;

procedure TInsertionThread.Sort;
var
  i: Integer;
  j: Integer;
  minIdx: Integer;
  minv: Integer;
begin
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
end;

end.
