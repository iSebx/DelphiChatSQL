---Ejercicios de ejemplo de curso
-- 1. La organización necesita saber quién es 
----- su mejor cliente (El que más dinero ha generado en ventas), 
----- cree un script que devuelva esta información. 

select TOP 1 c.CustomerID, c.CompanyName, SUM (od.Quantity*od.UnitPrice) as Gasto
from Customers as c INNER JOIN Orders as o on (o.CustomerID=c.CustomerID)
				    INNER JOIN [Order Details] as od on (od.OrderID=o.OrderID)
group by c.CustomerID, c.CompanyName
order by Gasto desc

--2. Cree script al que se le ingrese el número de orden y la elimine, 
----- tenga en cuenta que existe una relación entre el detalle de órdenes y la orden. 
select * from Orders
go
create proc del_orden (@num int)
as
begin
	delete from [Order Details] where [Order Details].OrderID=10248
	delete from Orders where Orders.OrderID=10248
end	

--3. Cree un script que elimine todas las ordenes donde se compró el producto 23 


begin transaction

delete from o
from [Order Details] as od INNER JOIN Orders as o on (o.OrderID=od.OrderID)
where od.ProductID=23

--4.  Cree un script que muestre todos los clientes que no han realizado una orden. 
select distinct c.CompanyName
from Customers as c INNER JOIN Orders as o on (o.CustomerID=c.CustomerID)

--5.  En estados Unidos se ha agregado un nuevo impuesto a partir de 1998, 
----- por lo que se necesita aumentar el precio de todos los productos en las ventas 
----- a partir de ese año, por lo que debe actualizar estas ventas en un 5% 

----- Ver todas las ordenes provenientes de estados unidos y mostrar el campo precio comun y otro 
----- actualizando un 5%
select c.CompanyName, c.ContactName, o.OrderID, SUM(od.Quantity*od.UnitPrice) as [Precio Anterior],
	cast ((SUM(od.Quantity*od.UnitPrice))*1.05 as money) as [Precio Nuevo]
from Customers as c INNER JOIN Orders as o on (c.CustomerID=o.CustomerID)
					INNER JOIN [Order Details] as od on (o.OrderID=od.OrderID)
group by c.CompanyName, c.ContactName, o.OrderID
order by c.CompanyName


---6. Cree un script que devuelva la cantidad de unidades vendidas del producto 23. 
select SUM(od.Quantity)
from [Order Details] as od 
where od.ProductID=23

---7. Cree un script que devuelva todos los clientes que han comprado productos de Estados Unidos, 
----- teniendo en cuenta que la procedencia del producto es en base al proveedor. 
select distinct c.CompanyName, COUNT(od.OrderID) as [Cantidad de Ordenes]
from Customers as c INNER JOIN Orders as o on (o.CustomerID=c.CustomerID)
					INNER JOIN [Order Details] as od on (o.OrderID=od.OrderID)
where od.ProductID in (select p.ProductID
					   from Products as p INNER JOIN Suppliers as s on (p.SupplierID=s.SupplierID)
					   where (s.Country='USA'))
group by c.CompanyName

---8. Cree un script al que se le ingrese el código del producto a través de asignar el valor 
----- a una variable y devuelva los clientes que han solicitado este producto. 

declare @producto int
set @producto = 55

select distinct c.CompanyName
from Customers as c INNER JOIN Orders as o on (c.CustomerID=o.CustomerID)
					INNER JOIN [Order Details] as od on (od.OrderID=o.OrderID)
where od.ProductID = @producto

--9.  Escriba un script que permita obtener el total de ventas de los clientes de México. 
select SUM (od.Quantity*od.UnitPrice) as Ventas_Mexico
from Customers as c INNER JOIN Orders as o on (c.CustomerID=o.CustomerID)
					INNER JOIN [Order Details] as od on (o.OrderID=od.OrderID)
where c.Country='MEXICO'

--10. Cree una consulta que muestre la unión de las tablas “Customers” y “Suppliers” 
---- (unión horizontal) uso solo los campos “Companyname” y “Country”. 
select c.CompanyName
from Customers as c
UNION
select s.Country
from Suppliers as s

--11. Muestre los 10 productos mas caros de la tabla “Products”.
select TOP 10 p.CategoryID, p.ProductName, p.UnitPrice
from Products as p
order by p.UnitPrice desc

--12. Escriba una consulta usando la tabla “Employees” que devuelva nombre y apellido 
----- del empleado junto con el nombre y apellido del jefe. 
select emp.FirstName+' '+emp.LastName as Empleado, jefe.FirstName+' '+jefe.LastName as Jefe
from Employees as emp LEFT JOIN Employees as jefe on (emp.ReportsTo=jefe.EmployeeID)
order by Empleado

