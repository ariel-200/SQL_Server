-- Create the Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE
);

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT, --FK
    PublicationYear INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Insert data in the authors table
INSERT INTO Authors (AuthorID, FirstName, LastName, BirthDate)
VALUES (1, 'Jane', 'Austen', '12-16-1775'),
(2, 'George', 'Orwell', '06-25-1903'),
(3, 'J.K.', 'Rowling', '07-21-1965'),
(4, 'Ernest', 'Hemingway', '07-21-1899'),
(5, 'Virginia', 'Woolf', '01-25-1882');

-- Insert data in the books table
INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, Price)
VALUES (1, 'Pride and Predjudice', 1, 1813, 12.99),
(2, '1984', 2, 1949, 10.99),
(3, 'Harry Potter and the Philosopher''s Stone', 3, 1997, 15.99),
(4, 'The Old Man and the Sea', 4, 1952, 11.99),
(5, 'To the Lighthouse', 5, 1927, 13.99);

-- Create a view that combines info from books and authors tables
CREATE VIEW BooksDetails AS
SELECT b.BookID, b.Title, a.FirstName + ' ' + a.LastName AS AuthorName,
    b.PublicationYear, b.Price 
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID;

-- Create a view that filters based on the PublicationYear
CREATE VIEW RecentBooks AS
    SELECT BookID, Title, PublicationYear, Price
    FROM Books
    WHERE PublicationYear > 1990;

SELECT * FROM BooksDetails;
SELECT * FROM RecentBooks;

-- Create agrregate query that shows avg price of books for each author
CREATE VIEW AuthorStats AS
    SELECT a.AuthorID, a.FirstName + ' ' + a.LastName AS AuthorName,
    COUNT(b.BookID) AS BookCount, 
    AVG(b.Price) AS AverageBookPrice
    FROM Authors a
    LEFT JOIN Books b ON a.AuthorID = b.AuthorID
    GROUP BY a.AuthorID, a.FirstName, a.LastName;

-- Insert a second book for George Orwell
INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, Price)
VALUES (6, 'Animal Farm', 2, 1960, 55.00);

SELECT * FROM AuthorStats;

-- Create an updatable view
CREATE VIEW AuthorContactInfo AS
    SELECT AuthorID, FirstName, LastName
    FROM Authors;

-- Update the authors name with the view
UPDATE AuthorContactInfo
SET FirstName = 'Joanne'
WHERE AuthorID = 3;

SELECT * FROM AuthorContactInfo;
SELECT * FROM Authors;

-- Create the Audit Table 
CREATE TABLE BookPriceAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    OldPrice DECIMAL(10,2),
    NewPrice DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);

-- Create a trigger to add data to the audit table when the boook price is changed
CREATE TRIGGER trg_BookPriceChange
ON Books
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Price)
    BEGIN
        INSERT INTO BookPriceAudit (BookID, OldPrice, NewPrice)
            SELECT i.BookID, d.Price, i.Price
            FROM inserted i
            JOIN deleted d ON i.BookID = d.BookID
    END
END;

-- Update a book's price
UPDATE Books
SET Price = 14.99
WHERE BookID = 1;

SELECT * FROM BookPriceAudit;