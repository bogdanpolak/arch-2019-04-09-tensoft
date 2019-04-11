{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  System.TimeSpan,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls;

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
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Thread.Sort,
  Thread.BubbleSort, Thread.QuickSort, Thread.InsertionSort,
  Model.Board,
  View.Board;

{ * ----------------------------------------------------------------------
  * TSortManager component
  * ---------------------------------------------------------------------- }

type
  TSortAlgorithm = (saBubbleSort, saQuickSort, saInsertionSort);

  TSortManager = class(TComponent)
  private
    FSortAlgorithm: TSortAlgorithm;
    FView: TBoardView;
    FBoard: TBoard;
    FThread: TSortThread;
  public
    constructor Create(AOwner: TComponent; APaintBox: TPaintBox;
      ASortAlgorithm: TSortAlgorithm);
    procedure Execute;
    function GetAlgorithmName: string;
    function IsBusy: boolean;
  end;

constructor TSortManager.Create(AOwner: TComponent; APaintBox: TPaintBox;
  ASortAlgorithm: TSortAlgorithm);
begin
  inherited Create(AOwner);
  FSortAlgorithm := ASortAlgorithm;
  FBoard := TBoard.Create(Self);
  FView := TBoardView.Create(Self);
  FView.FAlgorithmName := GetAlgorithmName();
  FView.FBoard := FBoard;
  FView.FPaintBox := APaintBox;
end;

procedure TSortManager.Execute;
var
  VisibleItems: Integer;
begin
  VisibleItems := FView.CalculateTotalVisibleItems;
  FBoard.GenerateData(VisibleItems);
  FView.DrawBoard;
  if FThread <> nil then
    FreeAndNil(FThread);
  case FSortAlgorithm of
    saBubbleSort:
      FThread := TBubbleThread.Create(FBoard, FView);
    saQuickSort:
      FThread := TQuickThread.Create(FBoard, FView);
    saInsertionSort:
      FThread := TInsertionThread.Create(FBoard, FView);
  end;
end;

function TSortManager.GetAlgorithmName: string;
begin
  case FSortAlgorithm of
    saBubbleSort:
      Result := 'Bubble Sort';
    saQuickSort:
      Result := 'Quick Sort';
    saInsertionSort:
      Result := 'Insertion Sort';
  end;
end;

function TSortManager.IsBusy: boolean;
begin
  Result := (FThread<>nil) and not(FThread.Finished);
end;

{ * ----------------------------------------------------------------------
  * Main app form
  * ---------------------------------------------------------------------- }

var
  BubbleManager, QuickManager, InsertionManager: TSortManager;

procedure TForm1.Button1Click(Sender: TObject);
begin
  BubbleManager.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  QuickManager.Execute;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  InsertionManager.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BubbleManager := TSortManager.Create(Self, PaintBox1, saBubbleSort);
  QuickManager := TSortManager.Create(Self, PaintBox2, saQuickSort);
  InsertionManager := TSortManager.Create(Self, PaintBox3, saInsertionSort);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button1.Enabled := not BubbleManager.IsBusy;
  Button2.Enabled := not QuickManager.IsBusy;
  Button3.Enabled := not InsertionManager.IsBusy;
end;

end.
