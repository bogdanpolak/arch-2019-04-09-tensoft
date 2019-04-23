{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Model.Board;

interface

uses
  System.Classes,
  System.TimeSpan;

type
  TSortResults = record
    TotalTime: System.TimeSpan.TTimeSpan;
    SwapCounter: integer;
  end;

  TBoard = class
  const
    MaxValue = 100;
  private
    FData: TArray<integer>;
    function GetValue(Index: integer): integer;
  public
    FSortResults: TSortResults;
    procedure GenerateData(size: integer);
    procedure swap(i, j: integer);
    function Count: integer;
    property Data[Index: integer]: integer read GetValue;
  end;

implementation

{ TBoard }

function TBoard.Count: integer;
begin
  Count := Length(FData);
end;

procedure TBoard.GenerateData(size: integer);
var
  i: integer;
begin
  randomize;
  SetLength(FData, size);
  for i := 0 to Length(FData) - 1 do
    FData[i] := random(MaxValue) + 1;
end;

function TBoard.GetValue(Index: integer): integer;
begin
  Result := FData[index];
end;

procedure TBoard.swap(i, j: integer);
var
  v: integer;
begin
  v := FData[i];
  FData[i] := FData[j];
  FData[j] := v;
  inc(FSortResults.SwapCounter);
end;

end.
