# Prosty przykład - FireDAC in Action

* Usunięcie tabeli (z opcją ignorowania błędu: tabela nie istnieje)
* Stworzenie tabeli
* Dodanie danych do tabeli
* Wyświetlenie tabeli

```pascal
const
  Data : array of string = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Etiam sit amet ante sollicitudin, tincidunt elit in, efficitur metus. Nam cursus commodo nulla, quis ullamcorper sapien pretium a.',
    'Nam dapibus diam non massa malesuada, ac feugiat felis euismod. Suspendisse et ipsum nec diam tristique aliquet dapibus quis magna.',
    'Pellentesque aliquam arcu non lorem tincidunt placerat quis nec quam.',
    'Praesent luctus sagittis lorem, eget tempor lacus scelerisque quis.',
    'Nulla a lectus quis leo interdum consectetur.',
    'Sed id malesuada elit.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Fusce a turpis eu diam maximus elementum.',
    'Praesent cursus eu orci in scelerisque.',
    'Donec feugiat vulputate tellus ac feugiat.',
    'Sed lacus leo, aliquet ut tempor vel, convallis ut diam.',
    'Morbi a mi ac velit condimentum porttitor.',
    'Proin blandit pretium metus sit amet egestas.',
    'Curabitur vulputate ultricies ullamcorper.',
    'Etiam varius arcu elit, at efficitur ex sollicitudin vel.',
    'Suspendisse maximus rhoncus suscipit.',
    'Cras fermentum nunc sit amet lacus fringilla, ut ullamcorper ex placerat.',
    'Proin fringilla eros metus.',
    'Donec lobortis eros id tortor convallis rutrum.'
  ];



  FDConnection1.ExecSQL('DROP TABLE Report', True);
  FDConnection1.ExecSQL('CREATE TABLE Report (Lp INT, Value VARCHAR[200])');
  FDQuery1.Open('SELECT Lp, Value FROM Report ORDER BY lp');
  for i := 0 to High(Data) do
    FDQuery1.AppendRecord([i+1,Data[i]]);
  FDQuery1.First;
  dbg := Vcl.DBGrids.TDBGrid.Create(self);
  dbg.Align := alClient;
  dbg.AlignWithMargins := True;
  dbg.DataSource := TDataSource.Create(self);
  dbg.DataSource.DataSet := FDQuery1;
  dbg.Parent := Self;
```