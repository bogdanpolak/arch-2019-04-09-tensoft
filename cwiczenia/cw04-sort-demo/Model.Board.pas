unit Model.Board;

interface

uses
  System.Classes;

type
  TBoard = class(TComponent)
  const
    MaxValue = 100;
  private
    data: TArray<Integer>;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GenerateData (size: integer);

  end;

implementation

{ TBoard }

constructor TBoard.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TBoard.GenerateData(size: integer);
var
  i: Integer;
begin
  randomize;
  SetLength(data, size);
  for i := 0 to Length(data) - 1 do
    data[i] := random(MaxValue) + 1;
end;

end.
