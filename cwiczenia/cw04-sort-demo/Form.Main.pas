unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  System.TimeSpan,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Model.Board,
  View.Board;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Button3: TButton;
    PaintBox3: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    BubbleBoard: TBoard;
    BubbleView: TBoardView;
    QuickBoard: TBoard;
    QuickView: TBoardView;
    InsertionBoard: TBoard;
    InsertionView: TBoardView;
  public
    { Public declarations }
  end;



var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Thread.Sort, Thread.BubbleSort, Thread.QuickSort, Thread.InsertionSort;

function ItemsInArray (paintbox:TPaintBox): integer;
begin
  Result := paintbox.Width div 6
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  BubbleBoard.GenerateData( BubbleView.CalculateTotalVisibleItems );
  BubbleView.DrawBoard;
  TBubbleThread.Create(BubbleBoard, BubbleView);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  QuickBoard.GenerateData( QuickView.CalculateTotalVisibleItems );
  QuickView.DrawBoard;
  TQuickThread.Create(QuickBoard, QuickView);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  InsertionBoard.GenerateData( InsertionView.CalculateTotalVisibleItems );
  InsertionView.DrawBoard;
  TInsertionThread.Create(InsertionBoard, InsertionView);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BubbleBoard := TBoard.Create(Self);
  BubbleView := TBoardView.Create(Self);
  BubbleView.FBoard := BubbleBoard;
  BubbleView.FPaintBox := PaintBox1;
  // --
  QuickBoard := TBoard.Create(Self);
  QuickView := TBoardView.Create(Self);
  QuickView.FBoard := QuickBoard;
  QuickView.FPaintBox := PaintBox2;
  // --
  InsertionBoard := TBoard.Create(Self);
  InsertionView := TBoardView.Create(Self);
  InsertionView.FBoard := InsertionBoard;
  InsertionView.FPaintBox := PaintBox3;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button1.Enabled := not BubbleSortIsWorking;
  Button2.Enabled := not QuickSortIsWorking;
  Button3.Enabled := not TInsertionThread.IsWorking;
end;

end.
