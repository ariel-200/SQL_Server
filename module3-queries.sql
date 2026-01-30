-- Show all suppliers from Germany
SELECT CompanyName, City FROM suppliers
WHERE Country = 'Germany';

-- Find all products under $20
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice < 20;

-- Find customers in London
SELECT CompanyName, ContactName, Phone FROM Customers
WHERE City = 'London';