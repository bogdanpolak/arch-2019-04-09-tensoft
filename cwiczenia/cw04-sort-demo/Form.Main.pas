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
  Vcl.StdCtrls,
  Component.SortManager;

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
    edtSwapTime: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSwapTimeChange(Sender: TObject);
  private
    BubbleManager: TSortManager;
    QuickManager: TSortManager;
    InsertionManager: TSortManager;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

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

procedure TForm1.edtSwapTimeChange(Sender: TObject);
var
  swapTime: Double;
begin
  if TryStrToFloat( edtSwapTime.Text, swapTime ) then
  begin
    BubbleManager.SwapTime := swapTime;
    QuickManager.SwapTime := swapTime;
    InsertionManager.SwapTime := swapTime;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BubbleManager := TSortManager.CreateAndInit(Self, PaintBox1, saBubbleSort);
  QuickManager := TSortManager.CreateAndInit(Self, PaintBox2, saQuickSort);
  InsertionManager := TSortManager.CreateAndInit(Self, PaintBox3,
    saInsertionSort);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button1.Enabled := not BubbleManager.IsBusy;
  Button2.Enabled := not QuickManager.IsBusy;
  Button3.Enabled := not InsertionManager.IsBusy;
end;

end.
