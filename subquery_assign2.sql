--AdventureWorks2019
--Write queries for following scenarios
--1.      How many products can you find in the Production.Product table?
SELECT COUNT(ProductID)
FROM Production.Product

--test_COUNT()
SELECT ProductID
FROM Production.Product

--2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.

SELECT COUNT(ProductSubcategoryID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL


--3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.

--ProductSubcategoryID CountedProducts

-------------------- ---------------

SELECT COUNT(ProductSubcategoryID)
FROM Production.ProductSubcategory




--4.      How many products that do not have a product subcategory.

SELECT COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

--5.      Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity) totalQuantity
FROM Production.ProductInventory


--6.    Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.

              --ProductID    TheSum

              -----------        ----------

SELECT ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity < 100
GROUP BY ProductID


--7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100

    --Shelf      ProductID    TheSum

    ----------   -----------        -----------

SELECT Shelf, ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity < 100
GROUP BY Shelf, ProductID


--8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.

SELECT LocationID, AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY LocationID

--tester locationID=10
SELECT *
FROM Production.ProductInventory
WHERE LocationID = 10;


---9.    Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory

    --ProductID   Shelf      TheAvg

    ----------- ---------- -----------

SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf


--10.  Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory

    --ProductID   Shelf      TheAvg

    ----------- ---------- -----------

SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE Shelf IS NOT NULL
GROUP BY ProductID, Shelf



--11.  List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.

    --Color                        Class              TheCount          AvgPrice

    -------------- - -----    -----------            ---------------------


SELECT Color, Class,  AVG(ListPrice) AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class


--Joins:

--12.   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.

    --Country                        Province

    ---------                          ----------------------
SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.StateProvince sp
JOIN Person.CountryRegion cr ON cr.CountryRegionCode = sp.CountryRegionCode


--tester
SELECT *
FROM Person.CountryRegion
WHERE Name = 'Germany'

SELECT *
FROM Person.StateProvince

--13.  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.

 

    --Country                        Province

    ---------                          ----------------------
SELECT cr.Name AS Country, sp.Name  AS Province
FROM Person.StateProvince sp
JOIN Person.CountryRegion cr ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name = 'Germany' 
OR cr.Name = 'Canada'

--tester
SELECT *
FROM Person.CountryRegion
WHERE Name = 'Germany'

 --Using Northwnd Database: (Use aliases for all the Joins)

USE Northwind
GO

---14.  List all Products that has been sold at least once in last 26 years.

SELECT od.ProductID, p.ProductName
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON o.OrderID = od.OrderID
JOIN dbo.Products p ON p.ProductID = od.ProductID
WHERE od.ProductID IN (
    SELECT DISTINCT(.ProductID)
    FROM dbo.Orders
)
AND o.OrderDate >= DATEADD (year,-26,GETDATE())


SELECT od.ProductID, p.ProductName
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON o.OrderID = od.OrderID
JOIN dbo.Products p ON p.ProductID = od.ProductID
WHERE o.OrderDate >= DATEADD (year,-26,GETDATE())

--DATEADD (year,-1,GETDATE()) a year ago

--tester
SELECT *
FROM dbo.Products

SELECT *
FROM dbo.[Order Details]

SELECT *
FROM dbo.Orders


--15.  List top 5 locations (Zip Code) where the products sold most.
--most popular products, quantity
SELECT TOP 5 o.ShipPostalCode, od.ProductID
FROM dbo.Orders o
JOIN dbo.[Order Details] od ON od.OrderID = o.OrderID
WHERE od.ProductID IN (
    SELECT ProductID, SUM(Quantity) SumQuantity
    FROM dbo.[Order Details] od
    JOIN dbo.Orders o ON od.OrderID = o.OrderID
    GROUP BY ProductID
    --ORDER BY SumQuantity DESC
) 
ORDER BY SUM(od.Quantity) DESC

--tester
    SELECT ProductID, SUM(Quantity) SumQuantity
    FROM dbo.[Order Details] od
    JOIN dbo.Orders o ON od.OrderID = o.OrderID
    GROUP BY ProductID
    ORDER BY SumQuantity DESC

--16.  List top 5 locations (Zip Code) where the products sold most in last 26 years.
--NOT SURE HOW TO DO



--17.   List all city names and number of customers in that city.     
SELECT c.City, COUNT(c.CustomerID) numCustomers
FROM dbo.Customers c
GROUP BY c.City

--tester
SELECT c.City, c.CustomerID
FROM dbo.Customers c

SELECT *
FROM dbo.Customers


--18.  List city names which have more than 2 customers, and number of customers in that city
SELECT c.City, COUNT(c.CustomerID) numCustomers
FROM dbo.Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) > 2




--19.  List the names of customers who placed orders after 1/1/98 with order date.
SELECT o.CustomerID, o.OrderDate, c.ContactName
FROM dbo.Orders o
JOIN dbo.Customers c ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderDate > '1998-01-01'


--20.  List the names of all customers with most recent order dates
WITH TmpMaxOrderDate
AS (
    SELECT o.CustomerID, MAX(o.OrderDate) MostRecentOrderDate
    FROM dbo.Orders o 
    GROUP BY o.CustomerID
)
SELECT c.ContactName, tmo.MostRecentOrderDate
FROM dbo.Customers c 
JOIN TmpMaxOrderDate tmo ON tmo.CustomerID = c.CustomerID

--tester
WITH OrderCntCTE
AS(
     SELECT CustomerId, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
)
SELECT c.ContactName, c.City, c.Country, cte.TotalNumOfOrders
FROM Customers c LEFT JOIN OrderCntCTE cte ON  c.CustomerId = cte.CustomerId



--tester
    SELECT DISTINCT(o.CustomerID)
    FROM dbo.Orders o 



--21.  Display the names of all customers  along with the  count of products they bought
SELECT c.ContactName, COUNT(od.ProductID) numProducts
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON o.OrderID = od.OrderID
JOIN dbo.Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName


--tester
    SELECT *
    FROM dbo.[Order Details]

--22.  Display the customer ids who bought more than 100 Products with count of products.
SELECT o.CustomerID, COUNT(od.ProductID) numProducts
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON o.OrderID = od.OrderID
JOIN dbo.Customers c ON c.CustomerID = o.CustomerID
GROUP BY o.CustomerID
HAVING COUNT(od.ProductID)  > 100



--23.  List all of the possible ways that suppliers can ship their products. Display the results as below

    --Supplier Company Name                Shipping Company Name

    ---------------------------------            ----------------------------------
--NOT SURE HOW TO DO

SELECT s.CompanyName [Supplier Company Name], sh.CompanyName [Shipping Company Name]
FROM dbo.Suppliers s
JOIN dbo.Shippers sh ON s.SupplierID = s.SupplierID


--tester
SELECT s.CompanyName [Supplier Company Name]
FROM dbo.Suppliers s
UNION 
SELECT sh.CompanyName  [Shipping Company Name]
FROM dbo.Shippers sh

SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e1.Title [e1 title], e2.EmployeeID, e2.FirstName, e2.LastName, e2.Title [e2 title]
FROM dbo.Employees e1
JOIN dbo.Employees e2 ON e1.EmployeeID < e2.EmployeeID --nested pair
WHERE e1.Title = e2.Title


--24.  Display the products order each day. Show Order date and Product Name.
SELECT p.ProductName,  o.OrderDate
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON o.OrderID = od.OrderID
JOIN dbo.Products p ON p.ProductID = od.ProductID
ORDER BY o.OrderDate



--25.  Displays pairs of employees who have the same job title.
SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e1.Title [e1 title], e2.EmployeeID, e2.FirstName, e2.LastName, e2.Title [e2 title]
FROM dbo.Employees e1
JOIN dbo.Employees e2 ON e1.EmployeeID < e2.EmployeeID --nested pair
WHERE e1.Title = e2.Title

--if e1.ID != e2.ID, will see repeated pairs, n1 vs n2, then n2 vs n1


--26.  Display all the Managers who have more than 2 employees reporting to them.
--NOT SURE HOW TO DO
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM dbo.Employees e 
WHERE e.EmployeeID IN (
    SELECT e2.EmployeeID, e2.ReportsTo, COUNT(e2.ReportsTo) 
    FROM dbo.Employees e2

)



SELECT *
FROM dbo.Employees

SELECT EmployeeId, FirstName, ReportsTo
FROM Employees


--27.  Display the customers and suppliers by city. The results should have the following columns

--City

--Name

--Contact Name,

--Type (Customer or Supplier)

SELECT c.City, c.ContactName, 'Customer' AS Type
FROM dbo.Customers c
UNION ALL
SELECT s.City, s.ContactName, 'Supplier' AS Type
FROM dbo.Suppliers s

--tester
SELECT c.City, c.ContactName customerName, s.ContactName supplierName
FROM dbo.Customers c
JOIN dbo.Suppliers s ON s.City = c.City




