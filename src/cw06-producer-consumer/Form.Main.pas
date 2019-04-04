unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Types,
  System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls
  ;

type
  TForm1 = class(TForm)
    tmrReader: TTimer;
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    btnAddWriterThread: TButton;
    procedure FormCreate(Sender: TObject);
    procedure tmrReaderTimer(Sender: TObject);
    procedure btnAddWriterThreadClick(Sender: TObject);
  private
    FQueue: TThreadedQueue<String>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ * --------------------------------------------------------------
  * TWriterThread - w¹tek roboczy - zapisuje dane z kolejki
  * -------------------------------------------------------------- }

type
  TWriterThread = class(TThread)
  private
    FQueue: TThreadedQueue<String>;
    FWriterName: string;
  protected
    procedure Execute; override;
  public
    constructor Create(const aWriterName:string; aQueue: TThreadedQueue<String>);
  end;

constructor TWriterThread.Create(const aWriterName:string;
  aQueue: TThreadedQueue<String>);
begin
  inherited Create(false);
  FWriterName := aWriterName;
  FQueue := aQueue;
end;

procedure TWriterThread.Execute;
begin
  while not Terminated do
  begin
    TThread.Sleep(100 + Random(600));
    FQueue.PushItem(Format('%s(%d)',[FWriterName,Random(256)]));
  end;
end;

{ * --------------------------------------------------------------
  * Aplikacja g³ówna
  * -------------------------------------------------------------- }


function generateThreadName(btn:TButton): string;
var
  ch: Char;
begin
  ch := chr(ord('A') + btn.Tag);
  btn.Tag := btn.Tag + 1;
  Result := ch + ch;
end;


procedure TForm1.btnAddWriterThreadClick(Sender: TObject);
var
  n: string;
begin
  n := GenerateThreadName(btnAddWriterThread);
  TWriterThread.Create(n,FQueue);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FQueue := TThreadedQueue<String>.Create();
end;

procedure TForm1.tmrReaderTimer(Sender: TObject);
var
  s: string;
  itemCounter: Integer;
begin
  itemCounter:=FQueue.QueueSize;
  while FQueue.QueueSize>0 do
    s := s + FQueue.PopItem() +', ';
  ListBox1.Items.Add(Format('%2d items | ',[itemCounter])+s);
  ListBox1.ItemIndex := ListBox1.Items.Count-1;
end;

end.
