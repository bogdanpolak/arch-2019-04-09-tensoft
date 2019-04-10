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
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    EnableSorting: Boolean;
    SwapCounter: Integer;
  public
    { Public declarations }
  end;



var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Thread.Sort, Thread.BubbleSort, Thread.QuickSort;

procedure TForm1.Button1Click(Sender: TObject);
var
  ItemsToSort: Integer;
begin
  ItemsToSort := PaintBox1.Width div 6;
  TBubleThread.Create(ItemsToSort, PaintBox1);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ItemsToSort: Integer;
begin
  ItemsToSort := PaintBox2.Width div 6;
  TQuickThread.Create(ItemsToSort, PaintBox2);
end;

{
procedure TForm1.InsertionSort  (var data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
  mini: Integer;
  minv: Integer;
begin
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data)-1 do begin
    mini := i;  minv := data[i];
    for j := i+1 to Length(data)-1 do begin
      if data[j] < minv then begin
        mini := j;  minv := data[j];
      end;
    end;
    if mini<>i then
      swap( i, mini, data );
    if not(EnableSorting) then
      break;
  end;
  DrawResults (SwapPaintBox, 'InsertionSort', Length(data), sw.Elapsed, SwapCounter );
end;
}

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  EnableSorting := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button1.Enabled := not BubbleSortIsWorking;
  Button2.Enabled := not QuickSortIsWorking;
end;

end.
