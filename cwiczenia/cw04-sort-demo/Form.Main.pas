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
  private
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
  TBubbleThread.Create(ItemsInArray(PaintBox1), PaintBox1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TQuickThread.Create(ItemsInArray(PaintBox2), PaintBox2);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TInsertionThread.Create(ItemsInArray(PaintBox3), PaintBox3);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button1.Enabled := not BubbleSortIsWorking;
  Button2.Enabled := not QuickSortIsWorking;
  Button3.Enabled := not TInsertionThread.IsWorking;
end;

end.
