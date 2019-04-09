unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    btnTDateTimeHelper: TButton;
    btnTDataSetAndDBGridHelper: TButton;
    procedure btnTDateTimeHelperClick(Sender: TObject);
    procedure btnTDataSetAndDBGridHelperClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Frame.DateTime, Helper.TWinControl, Frame.DataSet;

var
  Frames: record
    DateTime :TFrameDateTime;
    DataSet :TFrameDataSet;
  end;


procedure TForm1.btnTDataSetAndDBGridHelperClick(Sender: TObject);
begin
  self.HideAllChildFrames;
  if not Assigned(Frames.DataSet) then begin
    Frames.DataSet := TFrameDataSet.Create(self);
    with Frames.DataSet do begin
      Parent := self;
      Align := alClient;
    end;
  end;
  Frames.DataSet.Visible := True;
  Frames.DataSet.ExecuteDemo;

end;

procedure TForm1.btnTDateTimeHelperClick(Sender: TObject);
begin
  self.HideAllChildFrames;
  if not Assigned(Frames.DateTime) then begin
    Frames.DateTime := TFrameDateTime.Create(self);
    with Frames.DateTime do begin
      Parent := self;
      Align := alClient;
    end;
  end;
  Frames.DateTime.Visible := True;
  Frames.DateTime.ExecuteDemo;
end;

end.
