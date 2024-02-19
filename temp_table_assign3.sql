--Write queries for following scenarios
--All scenarios are based on Database NORTHWIND.

--1.      List all cities that have both Employees and Customers.
SELECT DISTINCT(e.City)
FROM dbo.Employees e
JOIN dbo.Customers c ON e.City = c.City



--tester
SELECT *
FROM dbo.Employees

SELECT *
FROM dbo.Customers


--2.      List all cities that have Customers but no Employee.

--a.      Use sub-query
SELECT c.City
FROM dbo.Customers c
WHERE c.City NOT IN (
    SELECT e.City
    FROM dbo.Employees e
) 

--tester
SELECT *
FROM dbo.Employees


--b.      Do not use sub-query
SELECT DISTINCT(c.City)
FROM dbo.Customers c
LEFT JOIN dbo.Employees e ON e.City = c.City
WHERE e.City IS NULL -- no right table at all




--3.      List all products and their total order quantities throughout all orders.
SELECT ProductID, SUM(Quantity) tolQuantity
FROM dbo.[Order Details] od
GROUP BY ProductID




--4.      List all Customer Cities and total products ordered by that city.
SELECT c.City, SUM(Quantity) tolProductsOrdered
FROM dbo.Customers c
JOIN dbo.Orders o On o.CustomerID = c.CustomerID
JOIn dbo.[Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.City

--tester
SELECT *
FROM dbo.Orders

SELECT
    c.City,
    SUM(od.Quantity) AS TotalProductsOrdered
FROM
    Customers c
JOIN
    Orders o ON c.CustomerID = o.CustomerID
JOIN
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY
    c.City;


--5.      List all Customer Cities that have at least two customers.

--a.      Use union
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(*) >= 2; --amount of row >= 2

--tester
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(*) >= 2; --amount of row >= 2


SELECT City, CustomerID
FROM Customers

--b.      Use sub-query and no union
SELECT DISTINCT(City)
FROM Customers
WHERE City IN (
    SELECT City
    FROM Customers
    GROUP BY City
    HAVING COUNT(*) >= 2  --amount of row >= 2
)




--6.      List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, od.ProductID
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE (od.ProductID) >= 2


--7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT c.CustomerID, c.City, o.ShipCity, o.OrderID
FROM Customers c 
JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE c.City != o.ShipCity

--tester
SELECT *
FROM Orders

SELECT *
FROM Customers


--8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
SELECT TOP 5 od.ProductID, AVG(od.UnitPrice) averagePrice, c.City  
FROM [Order Details] od
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY od.ProductID, c.City 
ORDER BY SUM(od.Quantity) DESC


--tester
SELECT od.ProductID, AVG(od.UnitPrice) averagePrice, c.City, SUM(od.Quantity) mostQuantity  
FROM [Order Details] od
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY od.ProductID, c.City 
ORDER BY SUM(od.Quantity) DESC

SELECT * 
FROM [Order Details] od 

--9.      List all cities that have never ordered something but we have employees there.

--a.      Use sub-query
SELECT e.City
FROM Employees e
WHERE e.City NOT IN (
    SELECT o.ShipCity
    FROM Orders o
)

--b.      Do not use sub-query
SELECT e.City
FROM Employees e
LEFT JOIN Orders o ON o.ShipCity = e.City
WHERE o.OrderID IS NULL --never ordered in this city

--tester
--wrong
SELECT DISTINCT(e.City)
FROM Employees e
LEFT JOIN Orders o ON o.EmployeeID = e.EmployeeID
WHERE o.ShipCity IS NULL

SELECT * 
FROM Orders


--10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
SELECT TOP 1 o.ShipCity, COUNT(o.OrderID) TolNumOrders, SUM(Quantity) TolQuantity
FROM Orders o
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY o.ShipCity
ORDER BY COUNT(o.OrderID) DESC, TolQuantity DESC





--not sure
SELECT
    (
        SELECT TOP 1
            e.City
        FROM
            Employees e
        JOIN
            Orders o ON e.EmployeeID = o.EmployeeID
        GROUP BY
            e.City
        ORDER BY
            COUNT(*) DESC
    ) AS CityWithMostOrdersSold,
    (
        SELECT TOP 1
            o.ShipCity
        FROM
            Orders o
        JOIN
            [Order Details] od ON o.OrderID = od.OrderID
        GROUP BY
            o.ShipCity
        ORDER BY
            SUM(od.Quantity) DESC
    ) AS CityWithMostTotalQuantity;

--tester

        SELECT e.City, COUNT(*) what
        FROM Employees e
        JOIN Orders o ON e.EmployeeID = o.EmployeeID
        GROUP BY e.City
        ORDER BY COUNT(*) DESC

        SELECT e.City, COUNT(*) what
        FROM Orders o 
        JOIN Employees e ON e.EmployeeID = o.EmployeeID
        GROUP BY e.City
        ORDER BY COUNT(*) DESC
SELECT ShipCity
FROM Orders
WHERE ShipCity = 'Seattle'

SELECT o.ShipCity, COUNT(o.OrderID) TolNumOrders, SUM(Quantity) TolQuantity
FROM Orders o
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY o.ShipCity
ORDER BY COUNT(o.OrderID) DESC, TolQuantity DESC



--11. How do you remove the duplicates record of a table?

--DISTINCT clause