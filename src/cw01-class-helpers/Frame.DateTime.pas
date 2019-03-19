unit Frame.DateTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrameDateTime = class(TFrame)
    Memo1: TMemo;
  private
    procedure LogClear ();
    procedure LogSection (const title: string);
    procedure Log (const code: string; const result:string);
  public
    procedure ExecuteDemo ();
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.DateUtils,
  Helper.TDateTime;

{ TFrameDateTime }

procedure TFrameDateTime.ExecuteDemo;
var
  T1: TDateTime;
  T2: TDateTime;
  s: string;
  years: Integer;
begin
  LogClear ();
  LogSection ('TDateTimeHelper');
  // Set date to 14 marca 2018
  T1 := TDateTime.Create(2018, 3, 14);
  Log('TDateTime.Create(2018, 3 14)', T1.ToString() );
  // Set date to today's date
  T1 := TDateTime.Today;
  Log('TDateTime.Today', T1.ToString() );
  // Set T2 to 1 year, 3 months and 10 days ahead of T1.
  T2 := T1.AddYears(1).AddMonths(3).AddDays(10);
  Log('T2 = T1.AddYears(1).AddMonths(3).AddDays(10); T2', T2.ToString() );
  s := IfThen(T2.IsInLeapYear,'jest','nie jest');
  Log('T2.IsInLeapYear',Format('%d %s przestêpny', [T2.Year,s]));
  // Delphi's birthday:  1995-02-14
  years := TDateTime.Create(1995, 2, 14).YearsBetween(Now);
  Log ('TDateTime.Create(1995, 2, 14).YearsBetween(Now)', years.ToString);
  Log ('Delphi is', years.ToString+' years old');
  s:= TDateTime.Create(1995, 2, 14).ToString('dd mmmm yyyy');
  Log ('TDateTime.Create(1995, 2, 14).ToString(''dd mmmm yyyy'')',s);
end;

procedure TFrameDateTime.Log(const code, result: string);
begin
  Memo1.Lines.Add('  '+code+' = '+result);
end;

procedure TFrameDateTime.LogClear;
begin
  Memo1.Clear;
end;

procedure TFrameDateTime.LogSection(const title: string);
begin
  Memo1.Lines.Add(title);
end;

end.
