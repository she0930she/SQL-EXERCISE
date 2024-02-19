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

--b.      Use sub-query and no union





--6.      List all Customer Cities that have ordered at least two different kinds of products.

--7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.

--8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

--9.      List all cities that have never ordered something but we have employees there.

--a.      Use sub-query

--b.      Do not use sub-query

--10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)

--11. How do you remove the duplicates record of a table?

