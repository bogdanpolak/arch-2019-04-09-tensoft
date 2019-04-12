unit Service.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Web.WebReq, IdHTTPWebBrokerBridge;

type
  TService1 = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
   LServer: TIdHTTPWebBrokerBridge;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  Service1: TService1;

implementation

{$R *.dfm}

uses
  System.Win.Registry,
  WebModule.Main;

{* --------------------------------------------------------------------
 * Default service routines
 * --------------------------------------------------------------------}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

{* --------------------------------------------------------------------
 * Daniele Teti Windows Service template
 * --------------------------------------------------------------------}


procedure TService1.ServiceAfterInstall(Sender: TService);
var
  Reg: System.Win.Registry.TRegistry;
  ServiceDescription: string;
begin
  ShowMessage( ParamStr(0) );
  Self.DisplayName := 'REST Service 1.0';
  ServiceDescription := 'El Fantastico REST Servisio';
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + name, false) then
    begin
      Reg.WriteString('Description', ServiceDescription);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TService1.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  Continued := True;
end;

procedure TService1.ServicePause(Sender: TService; var Paused: Boolean);
begin
  Paused := True;
end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  LServer.DefaultPort := 8080;
  LServer.Active := True;
  Started := True;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  FreeAndNil(LServer);
  Stopped := True;
end;

procedure TService1.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(false);
    TThread.Sleep(500);
  end;
end;


end.
