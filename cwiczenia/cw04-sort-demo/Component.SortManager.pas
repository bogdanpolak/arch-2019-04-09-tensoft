{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Component.SortManager;

interface

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
    procedure Init(APaintBox: TPaintBox; ASortAlgorithm: TSortAlgorithm);
    procedure DependeciesGuard;
  public
    constructor CreateAndInit(AOwner: TComponent;
      APaintBox: TPaintBox; ASortAlgorithm: TSortAlgorithm); virtual;
    destructor Destroy; override;
    procedure Execute;
    function GetAlgorithmName: string;
    function IsBusy: boolean;
    property SortAlgorithm: TSortAlgorithm read FSortAlgorithm
      write FSortAlgorithm;
  end;

implementation

uses
  System.SysUtils,
  Thread.BubbleSort,
  Thread.InsertionSort,
  Thread.QuickSort;

procedure TSortManager.Init(APaintBox: TPaintBox; ASortAlgorithm: TSortAlgorithm);
begin
  SortAlgorithm := ASortAlgorithm;
  FBoard := TBoard.Create(Self);
  FView := TBoardView.Create(FBoard,APaintBox);
  FView.FAlgorithmName := GetAlgorithmName();
end;

constructor TSortManager.CreateAndInit(AOwner: TComponent;
  APaintBox: TPaintBox; ASortAlgorithm: TSortAlgorithm);
begin
  inherited Create(AOwner);
  Init(APaintBox, ASortAlgorithm);
end;

procedure TSortManager.DependeciesGuard;
begin
  if (SortAlgorithm = saNone) then
    raise Exception.Create('Dependecies Guard Error!');
end;

destructor TSortManager.Destroy;
begin
  if FView<>nil then
    FView.Free;
  inherited;
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
