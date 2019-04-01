unit Main.GenericCollection;

interface

procedure Execute_GenericCollectionDemo;

implementation

uses
  System.Variants,
  System.SysUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  DataModule.CenericCollection,
  Helper.TDataSet;

type
  TShipmentWarning = (swGreen, swYellow, swRed);

  TOrder = class
    OrderID: Integer;
    CustomerID: String;
    EmployeeID: Integer;
    EmployeeName: String;
    OrderDate: TDateTime;
    RequiredDate: TDateTime;
    ShippedDate: Variant;
    ShipVia: Integer;
    Freight: Currency;
    function IsShipped: boolean;
    function ShipmentWarnng: TShipmentWarning;
  end;

  TOrderList = class(TObjectList<TOrder>)
    function GetOrdersExpectedToShip: TList<TOrder>;
  end;

function TOrder.IsShipped: boolean;
begin
  Result := ShippedDate <> Null;
end;

function TOrder.ShipmentWarnng: TShipmentWarning;
var
  dt: TDateTime;
begin
  dt := Now;
  if IsShipped then
    Result := swGreen
  else if RequiredDate >= dt + 7 then
    Result := swGreen
  else if RequiredDate >= dt then
    Result := swYellow
  else
    Result := swRed;
end;

function TOrderList.GetOrdersExpectedToShip: TList<TOrder>;
var
  Order: TOrder;
begin
  Result := TList<TOrder>.Create();
  for Order in Self do
    if Order.ShipmentWarnng = swRed then
      Result.Add(Order);
end;

procedure Execute_GenericCollectionDemo;
var
  dm: TDataModule1;
  Orders: TOrderList;
  OrdersForShipment: TList<TOrder>;
  Order: TOrder;
  ResverShippedDateComparer: IComparer<TOrder>;
begin
  dm := TDataModule1.Create(nil);
  Orders := TOrderList.Create();
  dm.dsOrders.Open;
  dm.dsOrders.FetchAll;
  dm.dsOrders.WhileNotEof(
    procedure()
    var
      Order: TOrder;
    begin
      Order := TOrder.Create;
      Order.OrderID := dm.dsOrdersOrderID.Value;
      Order.CustomerID := dm.dsOrdersCustomerID.AsString;
      Order.EmployeeID := dm.dsOrdersEmployeeID.Value;
      Order.EmployeeName := dm.dsOrdersEmployeeName.AsString;
      Order.OrderDate := dm.dsOrdersOrderDate.Value;
      Order.RequiredDate := dm.dsOrdersRequiredDate.Value;
      Order.ShippedDate := dm.dsOrdersShippedDate.AsVariant;
      Orders.Add(Order);
    end);
  OrdersForShipment := Orders.GetOrdersExpectedToShip;
  Writeln('Total orders: ', Orders.Count);
  Writeln('Orders for shippment: ', OrdersForShipment.Count);

  // -----------------------------------------------------------------
  // Sortowanie kolekcji zamówieñ
  // -----------------------------------------------------------------
  ResverShippedDateComparer := TComparer<TOrder>.Construct(
    function(const Left, Right: TOrder): Integer
    begin
      Result := Round(Int(Right.RequiredDate) - Int(Left.RequiredDate));
    end);
  OrdersForShipment.Sort(ResverShippedDateComparer);
  // -----------------------------------------------------------------

  for Order in OrdersForShipment do
    Writeln('  ', Order.OrderID, ' ', Order.CustomerID, ' ',
      DateToStr(Order.OrderDate), ' ', DateToStr(Order.RequiredDate));

  Orders.Free;
  OrdersForShipment.Free;
  dm.Free;
end;

end.
