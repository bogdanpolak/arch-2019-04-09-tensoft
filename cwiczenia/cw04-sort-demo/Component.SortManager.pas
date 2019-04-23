unit Component.SortManager;

interface

{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
uses
  System.Classes,
  Vcl.ExtCtrls,
  View.Board,
  Model.Board,
  Thread.Sort;

type
  TSortAlgorithm = (saNone, saBubbleSort, saQuickSort, saInsertionSort);

  TThreadSortClass = class of TSortThread;

  TSortManager = class(TComponent)
  private
    FSortAlgorithm: TSortAlgorithm;
    FView: TBoardView;
    FBoard: TBoard;
    FThread: TSortThread;
    FPaintBox: TPaintBox;
    procedure DependeciesGuard;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateAndInit(AOwner: TComponent;
      APaintBox: TPaintBox; ASortAlgorithm: TSortAlgorithm); virtual;
    procedure Execute;
    function GetAlgorithmName: string;
    function IsBusy: boolean;
    property PaintBox: TPaintBox read FPaintBox write FPaintBox;
    property SortAlgorithm: TSortAlgorithm read FSortAlgorithm
      write FSortAlgorithm;
  end;

implementation

uses
  System.SysUtils,
  Thread.BubbleSort,
  Thread.InsertionSort,
  Thread.QuickSort;

constructor TSortManager.Create(AOwner: TComponent);
begin
  inherited;
  FBoard := TBoard.Create(Self);
  FView := TBoardView.Create(Self);
  FView.FBoard := FBoard;
end;

constructor TSortManager.CreateAndInit(AOwner: TComponent;
  APaintBox: TPaintBox; ASortAlgorithm: TSortAlgorithm);
begin
  Create(AOwner);
  SortAlgorithm := ASortAlgorithm;
  PaintBox := APaintBox;
end;

procedure TSortManager.DependeciesGuard;
begin
  if (PaintBox = nil) or (SortAlgorithm = saNone) then
    raise Exception.Create('Dependecies Guard Error!');
  // --------------
  // dependency initialization
  FView.FPaintBox := PaintBox;
  FView.FAlgorithmName := GetAlgorithmName();
end;

procedure TSortManager.Execute;
var
  VisibleItems: Integer;
begin
  DependeciesGuard;
  VisibleItems := FView.CalculateTotalVisibleItems;
  FBoard.GenerateData(VisibleItems);
  FView.DrawBoard;
  if FThread <> nil then
    FreeAndNil(FThread);
  case FSortAlgorithm of
    saNone:
      raise Exception.Create('Error Message');
    saBubbleSort:
      FThread := TBubbleThread.Create(FBoard, FView);
    saQuickSort:
      FThread := TQuickThread.Create(FBoard, FView);
    saInsertionSort:
      FThread := TInsertionThread.Create(FBoard, FView);
  else
    raise Exception.Create('Error Message');
  end;
end;

function TSortManager.GetAlgorithmName: string;
begin
  case FSortAlgorithm of
    saNone:
      raise Exception.Create('Error Message');
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
  Result := (FThread <> nil) and not(FThread.Finished);
end;

end.
