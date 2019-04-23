{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Thread.BubbleSort;

interface

uses
  System.Classes,
  Thread.Sort;

type
  TBubbleThread = class(TSortThread)
  protected
    procedure Sort; override;
  end;

implementation

procedure TBubbleThread.Sort;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to FBoard.Count - 1 do
    for j := 0 to FBoard.Count - 2 do
      if FBoard.Data[j] > FBoard.Data[j + 1] then
      begin
        if Self.Terminated then
          break;
        DoSwap(j, j + 1);
      end;
end;

end.
