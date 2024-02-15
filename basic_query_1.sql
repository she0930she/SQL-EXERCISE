USE  AdventureWorks2019

--1. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
SELECT p.productID, p.name, p.color, p.listPrice
FROM Production.Product AS p


--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
SELECT p.productID, p.name, p.color, p.listPrice
FROM Production.Product AS p
WHERE p.listPrice != 0



--3. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
SELECT p.productID, p.name, p.color, p.listPrice
FROM Production.Product AS p
WHERE p.color is NULL




--4. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
SELECT p.productID, p.name, p.color, p.listPrice
FROM Production.Product AS p
WHERE p.color is NOT NULL 



--5. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
SELECT p.productID, p.name, p.color, p.listPrice
FROM Production.Product AS p
WHERE p.color is NOT NULL
AND p.listPrice > 0

--6. Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
SELECT p.name + ' '+ p.color AS " name and color"
FROM Production.Product AS p
WHERE p.color is NOT NULL



--7. Write a query that generates the following result set  from Production.Product:
--NAME: LL Crankarm  --  COLOR: Black
--NAME: ML Crankarm  --  COLOR: Black
--NAME: HL Crankarm  --  COLOR: Black
--NAME: Chainring Bolts  --  COLOR: Silver
--NAME: Chainring Nut  --  COLOR: Silver
--NAME: Chainring  --  COLOR: Black

SELECT 'NAME: '+ p.name + ' -- COLOR: ' + p.color
FROM Production.Product AS p
WHERE p.color is NOT NULL


--Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
--Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
--Write a query to get a result set on products that begins with the letter S. 
--Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
--Name                                               ListPrice
--Seat Lug                                              0,00
--Seat Post                                             0,00
--Seat Stays                                            0,00
--Seat Tube                                            0,00
--Short-Sleeve Classic Jersey, L           53,99
--Short-Sleeve Classic Jersey, M          53,99
 --Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
--Name                                               ListPrice
--Adjustable Race                                   0,00
--All-Purpose Bike Stand                       159,00
--AWC Logo Cap                                      8,99
--Seat Lug                                                 0,00
--Seat Post                                                0,00
--Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
--Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
--Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
