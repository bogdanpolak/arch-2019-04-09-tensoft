unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdCustomTCPServer,
  IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdContext, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnConnect: TButton;
    btnSend: TButton;
    btnStartServer: TButton;
    GroupBoxSend: TGroupBox;
    Edit1: TEdit;
    Memo1: TMemo;
    pnServerStatus: TPanel;
    Shape1: TShape;
    GroupBoxParams: TGroupBox;
    edtPort: TEdit;
    Label1: TLabel;
    GroupBoxConnect: TGroupBox;
    Splitter1: TSplitter;
    Label2: TLabel;
    edtHost: TEdit;
    procedure btnSendClick(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure btnConnectClick(Sender: TObject);
    procedure btnStartServerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure IdTCPServer1Connect(AContext: TIdContext);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  IdGlobal,
  IdStack;

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  IdTCPClient1.Host := edtHost.Text;
  IdTCPClient1.Port := StrToIntDef(edtPort.Text,12321);
  IdTCPClient1.Connect;
  btnSend.Enabled := True;
end;

procedure TForm1.btnSendClick(Sender: TObject);
begin
  IdTCPClient1.IOHandler.WriteLnRFC(Edit1.Text,IdGlobal.IndyTextEncoding_UTF8);
end;

procedure TForm1.btnStartServerClick(Sender: TObject);
begin
  IdTCPServer1.DefaultPort := StrToIntDef(edtPort.Text,12321);
  IdTCPServer1.Active := True;
  IdTCPServer1.StartListening;
  Shape1.Brush.Color := RGB (128,255,128);
  Memo1.Lines.Add('Server started on port '+IdTCPServer1.DefaultPort.ToString);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    btnSendClick(btnSend);
    Edit1.Clear;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  btnSend.Enabled := False;
  Memo1.Lines.Clear;
  Shape1.Brush.Color := RGB (255,81,81);
end;

procedure TForm1.IdTCPServer1Connect(AContext: TIdContext);
begin
  Memo1.Lines.Add('Connected from: '+AContext.Binding.PeerIP+'  (name:'+
    IdStack.GStack.HostByAddress(AContext.Binding.PeerIP)+')');

end;

procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
var
  isMggEnd: Boolean;
  s: string;
begin
  // IndyUTF8Encoding
  s := AContext.Connection.IOHandler.ReadLnRFC(isMggEnd);
  Memo1.Lines.Add(s);
end;

end.
