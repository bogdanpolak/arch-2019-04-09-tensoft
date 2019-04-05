unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdUDPServer,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdGlobal, IdSocketHandle;

type
  TForm1 = class(TForm)
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Button2Click(Sender: TObject);
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
  IdStack;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines := IdStack.GStack.LocalAddresses;
  Memo1.Lines.Add('----------------');
  IdUDPServer1.DefaultPort := 10123;
  // Binding := IdUDPServer1.Bindings.Add;
  // Binding.IP := ...;
  // Binding.Port := ...;
  IdUDPServer1.Active := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  IdUDPClient1.Broadcast ('Zażółć! рождаются',10123,'',
    IdGlobal.IndyTextEncoding_UTF8);
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s: string;
begin
  s := BytesToString(AData, IndyTextEncoding_UTF8);
  // s := TEncoding.UTF8.GetString(AData);
  Memo1.Lines.Add (s);
end;

end.
