-- Add a new customer to the customers table
INSERT INTO Customers (CustomerID, CompanyName, ContactName, Country)
VALUES ('STUDE', 'Student Company', 'Ariel Blackwell', 'USA');

-- Verify the insertion by running this query:
SELECT * FROM Customers 
WHERE CustomerID = 'STUDE';

-- Create a new order for the new customer
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipCountry)
VALUES ('STUDE', 1, GETDATE(), 'USA');

-- Verify the insertion by running this query:
SELECT * FROM Orders
WHERE CustomerID = 'STUDE';

-- Change contact name for our customer
UPDATE Customers
SET ContactName = 'New Contact Name'
WHERE CustomerID = 'STUDE';

-- Change the shipping country for our order
UPDATE Orders
SET ShipCountry = 'New Country'
WHERE CustomerID = 'STUDE';

-- Delete the order for the new customer
DELETE FROM Orders WHERE CustomerID = 'STUDE';

-- Delete the test customer
DELETE FROM Customers WHERE CustomerID = 'STUDE';

-- Add first suppliers to the database 
INSERT INTO Suppliers (CompanyName, ContactName, ContactTitle, Country)
VALUES ('Pop-up Foods', 'Ariel Blackwell', 'Owner', 'USA');

-- Check your work:
SELECT * FROM Suppliers WHERE CompanyName = 'Pop-up Foods';

-- Insert into products table
INSERT INTO Products (ProductName, SupplierID, CategoryID, UnitPrice, UnitsInStock)
VALUES ('House Special Pizza', 30, 2, 15.99, 50);

-- Verify changes
SELECT * FROM Products WHERE SupplierID = 30;

-- Update product price
UPDATE Products SET UnitPrice = 12.99
WHERE ProductName = 'House Special Pizza';

-- Update units in stock and price of product
UPDATE Products SET UnitsInStock = 25, UnitPrice = 17.99
WHERE ProductName = 'House Special Pizza';

-- Delete the new product
DELETE FROM Products
WHERE ProductName = 'House Special Pizza';

-- Create your own product
INSERT INTO Products (ProductName, SupplierID, CategoryID, UnitPrice, UnitsInStock)
VALUES ('Frozen Chicken Wings', 30, 6, 10.99, 50);

-- Verify product was created
SELECT * FROM Products 
WHERE ProductName = 'Frozen Chicken Wings';

-- Update product price and inventory
UPDATE Products SET UnitsInStock = 42, UnitPrice = 15.99
WHERE ProductName = 'Frozen Chicken Wings';

-- Delete the product
DELETE FROM Products
WHERE ProductName = 'Frozen Chicken Wings';
