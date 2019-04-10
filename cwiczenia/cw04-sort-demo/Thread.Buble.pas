unit Thread.Buble;

interface

uses
  System.Classes,
  Vcl.ExtCtrls;

type
  TBubleThread = class(TThread)
  private
    FSwapPaintBox: TPaintBox;
    procedure GenerateData(items: Integer);
    procedure swap(i, j: Integer);
    procedure DrawItem(paintbox: TPaintBox; index, value: integer);
    { Private declarations }
  protected
    procedure Execute; override;
  public
    SwapCounter: Integer;
    data: TArray<Integer>;
    constructor Create(Count: Integer; ASwapPaintBox: TPaintBox);
  end;


implementation

uses
  System.Diagnostics,
  Vcl.Graphics,
  Colors.Hsl,
  WinApi.Windows;

  const
    MaxValue = 100;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TBubleThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ TBubleThread }

constructor TBubleThread.Create(Count: Integer; ASwapPaintBox: TPaintBox);
begin
  FSwapPaintBox := ASwapPaintBox;
  GenerateData (Count);
  inherited Create;
end;

procedure TBubleThread.Execute;
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data)-1 do
    for j := 0 to Length(data)-2 do
      if data[j] > data [j+1] then begin
        swap( j, j+1);
        if Self.Terminated then
          break;
      end;

end;

procedure TBubleThread.GenerateData(items:Integer);
var
  i: Integer;
begin
  randomize;
  SetLength(data, items);
  for i := 0 to Length(data)-1 do
    data[i] := random(MaxValue)+1;
end;

procedure TBubleThread.swap (i, j: Integer);
var
  v: Integer;
begin
  v := data[i];
  data[i] := data [j];
  data[j] := v;
  DrawItem (FSwapPaintBox, i, data[i]);
  DrawItem (FSwapPaintBox, j, data[j]);
  inc(SwapCounter);
  // WaitMilisecond (4.5);
  Sleep(4);
end;


function GetColor (value: integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value*256/(MaxValue+1));
  col := HSLtoRGB (Hue, 220, 120);
  Result := RGB (col.r, col.g, col.b);
end;

procedure TBubleThread.DrawItem (paintbox: TPaintBox; index, value: integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := paintbox.Height;
  j := round( value * maxhg / MaxValue);
  c := paintbox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := paintbox.Color;
  c.Rectangle( x, 0, x+5, maxhg-(j)+1 );
  c.Brush.Color := GetColor(value);
  c.Rectangle( x, maxhg-(j), x+5, maxhg );
end;

end.
