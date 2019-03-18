unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    btnTDateTimeHelper: TButton;
    procedure btnTDateTimeHelperClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Frame.DateTime;

var
  Frames: record
    DateTime :TFrameDateTime;
  end;

procedure TForm1.btnTDateTimeHelperClick(Sender: TObject);
begin
  if Assigned(Frames.DateTime) then begin
    Frames.DateTime.BringToFront()
  end
  else begin
    Frames.DateTime := TFrameDateTime.Create(self);
    with Frames.DateTime do begin
      Parent := self;
      Align := alClient;
    end;
  end;
  Frames.DateTime.ExecuteDemo;
end;

end.
