program WebbrokerREST;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Form.Main in 'Form.Main.pas' {Form1},
  WebModule.Main in 'WebModule.Main.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
