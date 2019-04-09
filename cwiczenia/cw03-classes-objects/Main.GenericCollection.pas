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
begin
  Result := TList<TOrder>.Create();
  // -----------------------------------------------------------
  // TODO: Stw�rz now� list� zam�wie� i przenie� na ni� tylko te
  //   zam�wienia, kt�re: ShipmentWarnng = swRed
  // -----------------------------------------------------------
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
  // -----------------------------------------------------------
  // TODO: dm.dsOrders ==> Orders
  // -----------------------------------------------------------
  OrdersForShipment := Orders.GetOrdersExpectedToShip;
  Writeln('Total orders: ', Orders.Count);
  Writeln('Orders for shippment: ', OrdersForShipment.Count);
  // -----------------------------------------------------------
  // TODO: Posortuj wybrane zam�wienia (OrdersForShipment) wg
  //   daty wysy�ki (odwrotnie)
  // -----------------------------------------------------------
  // TODO: Wy�wietl wybrane zam�wienia OrdersForShipment
  // -----------------------------------------------------------
  Orders.Free;
  OrdersForShipment.Free;
  dm.Free;
end;

end.
