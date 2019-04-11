unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    btnStart: TButton;
    StringGrid1: TStringGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.StrUtils, System.Math;

{ * --------------------------------------------------------------
  * TWorkerThread - w¹tek roboczy - zapisuje do strumienia
  * -------------------------------------------------------------- }

type
  TWorkerThread = class(TThread)
  private
    FStreamWriter: TStreamWriter;
    FWorking: boolean;
    FLinesCounter: integer;
  protected
    procedure Execute; override;
  public
    constructor Create(AStreamWriter: TStreamWriter);
    function isRunning: boolean;
    function linesWritten: integer;
  end;

constructor TWorkerThread.Create(AStreamWriter: TStreamWriter);
begin
  FStreamWriter := AStreamWriter;
  inherited Create(False);
end;

procedure TWorkerThread.Execute;
var
  i: Integer;
  linesToWrite: Integer;
  line: string;
begin
  NameThreadForDebugging('worker');
  FWorking := true;
  try
    linesToWrite := 5 + Random(50);
    for i := 0 to linesToWrite-1 do
    begin
      TThread.Sleep(10+random(200));
      System.TMonitor.Enter(FStreamWriter);
      try
        line := Format('[%.5d] - wiersz: %2d', [ThreadID, i]);
        FStreamWriter.WriteLine(line);
      finally
        System.TMonitor.Exit(FStreamWriter);
      end;
      FLinesCounter:=i+1;
      if Terminated then
        Break;
    end;
  finally
    FWorking := False;
  end;
end;

function TWorkerThread.isRunning: boolean;
begin
  Result := FWorking;
end;

function TWorkerThread.linesWritten: integer;
begin
  Result := FLinesCounter;
end;

{ * --------------------------------------------------------------
  * Kolekcja w¹tków
  * -------------------------------------------------------------- }

type
  TThreadCollection = class (TComponent)
  private
    FThreadList: TObjectList<TWorkerThread>;
    FOutputFile: TStreamWriter;
    function GetCount: integer;
  public
    constructor Create(AOwner: TComponent; const FileName:string); reintroduce;
    destructor Destroy; override;
    procedure Start (numberOfWorkers: integer);
    function IsAllFinished: boolean;
    function GetThreadInfo (index: Integer): string;
    property Count: integer read GetCount;
  end;

constructor TThreadCollection.Create(AOwner: TComponent; const FileName:string);
begin
  inherited Create(AOwner);
  FThreadList := TObjectList<TWorkerThread>.Create;
  FOutputFile := TStreamWriter.Create(TFileStream.Create(FileName,
    fmCreate or fmShareDenyWrite));
end;

destructor TThreadCollection.Destroy;
var
  thread: TWorkerThread;
begin
  for thread in FThreadList do
    thread.Terminate;
  FThreadList.Free;
  FOutputFile.Free;
  inherited;
end;

function TThreadCollection.GetCount: integer;
begin
  Result := FThreadList.Count;
end;

procedure TThreadCollection.Start (numberOfWorkers: integer);
var
  i: Integer;
begin
  FThreadList.Clear;
  for i := 0 to numberOfWorkers-1 do
    FThreadList.Add( TWorkerThread.Create(FOutputFile) );
end;

function TThreadCollection.IsAllFinished: boolean;
var
  thread: TWorkerThread;
  finished: Boolean;
begin
  finished := True;
  for thread in FThreadList do
    finished := finished and not(thread.isRunning);
  Result := finished;
end;

function TThreadCollection.GetThreadInfo (index: Integer): string;
var
  thread: TWorkerThread;
begin
  thread := FThreadList[index];   
  Result := thread.ThreadID.ToString + sLineBreak +
      IfThen (thread.isRunning, 'w toku ...', 'zrobione!') + sLineBreak +
      thread.linesWritten.ToString;
end;


{ * --------------------------------------------------------------
  * Aplikacja g³ówna
  * -------------------------------------------------------------- }

var
  ThreadCollection1: TThreadCollection;
  
procedure TForm1.FormCreate(Sender: TObject);
begin
  StringGrid1.Rows[0].CommaText := 'W¹tek,Stan,Zapisano';
  StringGrid1.RowCount := 2;
  StringGrid1.ColWidths[1] := 92;
  ThreadCollection1 := TThreadCollection.Create(self,'OutputFile.txt');
end;

procedure TForm1.btnStartClick(Sender: TObject);
var
  num: Integer;
begin
  num := StrToIntDef(Edit1.Text, 10);
  ThreadCollection1.Start(num);
  Timer1.Enabled := true;
  btnStart.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  idx: Integer;
begin
  StringGrid1.RowCount := System.Math.Max(ThreadCollection1.Count,2);
  for idx := 0 to ThreadCollection1.Count-1 do
    StringGrid1.Rows[idx+1].Text := ThreadCollection1.GetThreadInfo(idx);
  if ThreadCollection1.IsAllFinished then
  begin
    Timer1.Enabled := false;
    btnStart.Enabled := true;
  end;
end;


end.
