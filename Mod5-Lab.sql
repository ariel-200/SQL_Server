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