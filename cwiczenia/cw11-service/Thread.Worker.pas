unit Thread.Worker;

interface

uses
  System.Classes;

type
  TWorkerThread = class(TThread)
  private
    FPaused: Boolean;
  protected
    procedure Execute; override;
  public
    procedure Pause;
    procedure Continue;
  end;

implementation

uses
  System.SysUtils;

procedure TWorkerThread.Continue;
begin
  FPaused := False;
end;

procedure TWorkerThread.Execute;
var
  Log: TStreamWriter;
  LogFileName: string;
begin
  FPaused := False;
  LogFileName := 'sample-log-file.txt';
  Log := TStreamWriter.Create(
    TFileStream.Create(LogFileName,
       fmCreate or fmShareDenyWrite));
  try
    while not Terminated do
    begin
      if not FPaused then
      begin
        Log.WriteLine('Message from thread: ' + TimeToStr(now));
      end;
      TThread.Sleep(1000);
    end;
  finally
    Log.Free;
  end;
end;

procedure TWorkerThread.Pause;
begin
  FPaused := True;
end;

end.
