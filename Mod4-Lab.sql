-- Query #1: Using a join to retrieve data from two tables
SELECT C.CompanyName, O.OrderDate
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID;

-- Query #2: Left Join to show all of the customers, (even with no orders)
SELECT C.CustomerID, C.CompanyName, O.OrderID, O.OrderDate
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID;

-- Query #3: Using Built in functions
SELECT OrderID, ROUND( SUM( UnitPrice * Quantity * (1-Discount)), 2) AS TotalValue, 
COUNT(*) AS NumberOfItems
FROM [Order Details] 
GROUP BY OrderID       
ORDER BY TotalValue DESC;

-- Query #4: Group records to get the number of times each product is ordered, 
--           then filter using HAVING to only get products ordered more than 10 times
SELECT P.ProductID, P.ProductName, COUNT(od.OrderID) AS TimesOrdered
FROM Products P
JOIN [Order Details] AS od ON P.ProductID = od.ProductID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(od.OrderID) > 10
ORDER BY TimesOrdered DESC;

-- Query #5: Use a subquery to get the avere price of a product,
--           then display the product info for products where the price is average.
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice) FROM Products
)
ORDER BY UnitPrice;

-- Query #6: Joing three tables together
SELECT O.OrderID, O.OrderDate, P.ProductName, OD.Quantity, OD.UnitPrice
FROM Orders AS O
JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID
WHERE O.OrderID = 10248
ORDER BY P.ProductName;

--Query #7: Get average product price by category
SELECT C.CategoryName, ROUND(AVG(P.UnitPrice), 2) AS AveragePrice
FROM Categories As C
JOIN Products AS P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName
ORDER BY AveragePrice DESC;

-- Query #8: Count orders by employee
SELECT E.EmployeeID, E.FirstName + ' ' + E.LastName AS EmplyeeName, COUNT(O.OrderID) AS NumberOfOrders
FROM Employees AS E
JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY NumberOfOrders DESC;