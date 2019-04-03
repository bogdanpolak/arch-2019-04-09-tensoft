unit Thread.FileWriter;

interface

uses
  System.Classes, System.SyncObjs, System.SysUtils; //, System.IOUtils;

type
  TThreadHelper = class helper for TThread
  public
    function WaitForEx(ATimeout: Cardinal): LongWord; platform;
  end;

  TFileWriterThread = class(TThread)
  private
    FStreamWriter: TStreamWriter;
  protected
    procedure Execute; override;
  public
    constructor Create(AStreamWriter: TStreamWriter);
  end;

implementation

{$IF Defined(MSWINDOWS)}
uses
  Winapi.Windows;
{$IFEND}

constructor TFileWriterThread.Create(AStreamWriter: TStreamWriter);
begin
  FStreamWriter := AStreamWriter;
  inherited Create(False);
end;

procedure TFileWriterThread.Execute;
var
  I: Integer;
  NumLines: Integer;
begin
  inherited;
  NumLines := 11 + Random(50);
  for I := 1 to NumLines do
  begin
    TThread.Sleep(200);
    //here we are locking the shared resource
    TMonitor.Enter(FStreamWriter);
    try
      FStreamWriter.WriteLine(Format('THREAD %5d - ROW %2d', [TThread.CurrentThread.ThreadID, I]));
    finally
      //unlock the shared resource
      TMonitor.Exit(FStreamWriter);
    end;
    if Terminated then
      Break;
  end;
end;

function TThreadHelper.WaitForEx(ATimeout: Cardinal): LongWord;
begin
{$IF Defined(MSWINDOWS)}
  Result := WaitForSingleObject(Handle, ATimeout);
{$ELSE}
  raise Exception.Create('Available only on MS Windows');
{$IFEND}
end;

initialization

Randomize; // we'll use Random function in the thread

end.

