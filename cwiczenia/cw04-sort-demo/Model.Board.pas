unit Model.Board;

interface

uses
  System.Classes;

type
  TBoard = class(TComponent)
  const
    MaxValue = 100;
  private
    FData: TArray<Integer>;
    function GetValue(Index:integer): integer;
  public
    SwapCounter: Integer;
    constructor Create(AOwner: TComponent); override;
    procedure GenerateData (size: integer);
    procedure swap(i, j: Integer);
    function Count: integer;
    property Data[Index: integer]: integer read GetValue;
  end;

implementation

{ TBoard }

function TBoard.Count: integer;
begin
  Count := Length (FData);
end;

constructor TBoard.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TBoard.GenerateData(size: integer);
var
  i: Integer;
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

procedure TBoard.swap(i, j: Integer);
var
  v: Integer;
begin
  v := FData[i];
  FData[i] := FData[j];
  FData[j] := v;
  inc(SwapCounter);
end;

end.
