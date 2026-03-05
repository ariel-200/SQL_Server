-- Step 2: Create the Database
CREATE DATABASE PixelPizzaPalace;
GO

USE PixelPizzaPalace;
GO

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Price       DECIMAL(5,2),
    Stock       INT
);

CREATE TABLE Sales (
    SaleID    INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity  INT,
    SaleDate  DATETIME DEFAULT GETDATE()
);

INSERT INTO Products (ProductName, Price, Stock)
VALUES 
    ('Pepperoni Pizza', 12.99, 50),
    ('Cheese Pizza',    10.99, 50),
    ('Garlic Bread',     4.99, 75),
    ('Soda',             2.50, 200);

INSERT INTO Sales (ProductID, Quantity)
VALUES (1, 3), (2, 2), (3, 5);
GO

-- Step 3: Create Users with Different Permissions
-- Create logins at the server level
CREATE LOGIN Cashier WITH PASSWORD = 'Cash123!';
CREATE LOGIN Manager WITH PASSWORD = 'Mangr123!';
GO

USE PixelPizzaPalace;
GO

-- Create users inside the PixelPizzaPalace database
CREATE USER Cashier FOR LOGIN Cashier;
CREATE USER Manager FOR LOGIN Manager;
GO

-- Cashier can only read the menu and add new sales
GRANT SELECT ON Products TO Cashier;
GRANT SELECT, INSERT ON Sales TO Cashier;
GO

-- Manager can do everything on both tables
GRANT SELECT, INSERT, UPDATE, DELETE ON Products TO Manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Sales TO Manager;
GO

-- Step 4: Check User Permissions
SELECT dp.name AS UserName,
o.name AS TableName,
p.permission_name AS Permission
FROM sys.database_permissions p
JOIN sys.database_principals dp 
    ON p.grantee_principal_id = dp.principal_id
JOIN sys.objects o 
    ON p.major_id = o.object_id
WHERE dp.name IN ('Cashier', 'Manager')
ORDER BY UserName, TableName;
GO

-- Step 5: Monitor Database Size
SELECT name AS FileName,
size / 128 AS SizeMB
FROM sys.database_files;
GO

-- Step 6: Create a Backup
BACKUP DATABASE PixelPizzaPalace
TO DISK = '/var/opt/mssql/data/PixelPizzaPalace.bak'
WITH FORMAT;
GO

-- Step 7: Create an Index
-- Create an index so searches by ProductName are faster
CREATE NONCLUSTERED INDEX IX_Products_Name 
ON Products(ProductName);
GO

-- Verify the index was created by listing all indexes on Products
SELECT i.name AS IndexName,
i.type_desc AS IndexType,
COL_NAME(ic.object_id, ic.column_id) AS ColumnName
FROM sys.indexes i
JOIN sys.index_columns ic 
    ON i.object_id = ic.object_id 
    AND i.index_id = ic.index_id
WHERE i.object_id = OBJECT_ID('Products')
ORDER BY i.name;
GO
