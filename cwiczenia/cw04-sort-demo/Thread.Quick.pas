unit Thread.Quick;

interface

uses
  System.Classes,
  Vcl.ExtCtrls;

type

  TQuickThread = class(TThread)
  private
    FSwapPaintBox: TPaintBox;
//    procedure GenerateData(items: Integer);
//    procedure qsort(i, j: Integer);
//    procedure DrawItem(paintbox: TPaintBox; index, value: integer);
    { Private declarations }
  protected
    procedure Execute; override;
  public
    SwapCounter: Integer;
    data: TArray<Integer>;
//    constructor Create(Count: Integer; ASwapPaintBox: TPaintBox);
  end;

implementation

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure TQuickThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ TQuickThread }

procedure TQuickThread.Execute;
begin
  { Place thread code here }
end;

end.
