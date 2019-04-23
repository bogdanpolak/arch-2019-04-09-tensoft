{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Thread.QuickSort;

interface

uses
  System.Classes,
  Thread.Sort;

type
  TQuickThread = class(TSortThread)
  protected
    procedure Sort; override;
  end;

implementation

procedure TQuickThread.Sort;
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
    mediana := FBoard.Data[(i + j) div 2];
    repeat
      while FBoard.Data[i] < mediana do
        inc(i);
      while mediana < FBoard.Data[j] do
        dec(j);
      if i <= j then
      begin
        DoSwap(i, j);
        inc(i);
        dec(j);
      end;
    until i > j;
    if idx1 < j then
      qsort(idx1, j);
    if i < idx2 then
      qsort(i, idx2);
  end;

begin
  qsort(0, FBoard.Count - 1);
end;

end.
