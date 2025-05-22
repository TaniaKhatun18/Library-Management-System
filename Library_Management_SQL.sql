-- ===============================
--    Library Management System 
-- ===============================

-- 1.Create a Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 2.Create Tables
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    JoinDate DATE
);

CREATE TABLE Borrowing (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    Fine DECIMAL(10, 2),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 3.Insert Data
-- Insert into Authors
INSERT INTO Authors (Name, Country) VALUES
('Rose Smith', 'United States'),
('Anne Brown', 'United Kingdom'),
('Kiki Jones', 'Canada'),
('Kanyakumari Devi', 'India'),
('Emma Watson', 'Australia'),
('Sophia Lopez', 'Mexico'),
('Isabella Chen', 'China'),
('Mia Kim', 'South Korea'),
('Olivia Johnson', 'South Africa'),
('Alice', 'Spain');

-- Insert into Books

INSERT INTO Books (Title, AuthorID, Category, Price) VALUES
('Mystery of the Ocean', 1, 'Mystery', 14.99),
('Adventures in Space', 2, 'Sci-Fi', 19.99),
('Romance in Paris', 3, 'Romance', 9.99),
('Legends of Kanyakumari', 4, 'History', 24.99),
('Dreams of Tomorrow', 5, 'Fantasy', 29.99),
('The Last Detective', 6, 'Mystery', 18.50),
('Secrets of the Orient', 7, 'Adventure', 15.50),
('Courage in Chaos', 8, 'Drama', 12.75),
('Life of the Wild', 9, 'Nature', 11.99),
('Cooking with Passion', 10, 'Cooking', 21.00);

-- Insert into Members
INSERT INTO Members (Name, JoinDate) VALUES
('Rose', '2025-01-01'),
('Anne', '2025-01-10'),
('Kiki', '2025-01-15'),
('Kanyakumari', '2025-01-20'),
('Emma', '2024-12-01'),
('Sophia', '2024-11-20'),
('Isabella', '2023-10-05'),
('Mia', '2023-09-15'),
('Olivia', '2023-08-30'),
('Alice', '2023-07-25');

-- Insert into Borrowing
INSERT INTO Borrowing (MemberID, BookID, BorrowDate, ReturnDate) VALUES
(1, 1, '2025-01-10', '2025-01-18'),
(2, 2, '2025-01-12', '2025-01-20'),
(3, 3, '2025-01-15', '2025-01-25'),
(4, 4, '2025-01-18', '2025-01-28'),
(5, 5, '2024-12-05', '2024-12-15'),
(6, 6, '2024-11-25', '2024-12-05'),
(7, 7, '2023-10-10', '2023-10-20'),
(8, 8, '2023-09-20', '2023-09-30'),
(9, 9, '2023-08-25', '2023-09-05'),
(10, 10, '2023-07-30', '2023-08-10');

show tables;
-- 4. Queries
-- 1. List all books and their authors
SELECT Books.Title, Authors.Name AS Author
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID;

-- 2. Find all books borrowed by "Alice"
SELECT Books.Title
FROM Borrowing
JOIN Members ON Borrowing.MemberID = Members.MemberID
JOIN Books ON Borrowing.BookID = Books.BookID
WHERE Members.Name = 'Alice';

-- 3. Find all books that cost more than $20
SELECT Title, Price
FROM Books
WHERE Price > 20;

-- 5. Bonus
-- 1. Add a column Fine in the Borrowing table
ALTER TABLE Borrowing ADD Fine DECIMAL(10, 2);

select * from borrowing;

UPDATE Borrowing
SET Fine = CASE 
    WHEN DATEDIFF(ReturnDate, BorrowDate) > 7 THEN (DATEDIFF(ReturnDate, BorrowDate) - 7) * 2
    ELSE 0
END;

-- 2. Find the most expensive book in the library
SELECT Title, Price
FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 3. Calculate the total revenue generated if all books were sold
SELECT SUM(Price) AS TotalRevenue
FROM Books;

-- 4. Find the total number of books in each category
SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

-- 5. Calculate the average price of books in each category
SELECT Category, AVG(Price) AS AveragePrice
FROM Books
GROUP BY Category;

-- 6. Find the total fine collected for late returns
SELECT SUM(Fine) AS TotalFineCollected
FROM Borrowing;

-- 7. List all members who joined the library in 2025
SELECT Name, JoinDate
FROM Members
WHERE YEAR(JoinDate) = 2025;

-- 8. Find which category generates the highest revenue
SELECT Category, SUM(Price) AS TotalRevenue
FROM Books
GROUP BY Category
ORDER BY TotalRevenue DESC
LIMIT 1;

-- 1. JOINS
-- a. List all books with their authors
SELECT B.Title, A.Name AS Author
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID;

-- b. Show all books borrowed along with the member’s name
SELECT Br.BorrowID, M.Name AS Member, B.Title AS Book
FROM Borrowing Br
JOIN Members M ON Br.MemberID = M.MemberID
JOIN Books B ON Br.BookID = B.BookID;

-- c. Find members who have borrowed Fantasy books
SELECT DISTINCT M.Name AS Member
FROM Members M
JOIN Borrowing Br ON M.MemberID = Br.MemberID
JOIN Books B ON Br.BookID = B.BookID
WHERE B.Category = 'Fantasy';

-- 2. INDEXING FOR OPTIMIZATION
-- a. Create an index on AuthorID in the Books table
CREATE INDEX idx_authorid ON Books(AuthorID);

-- b. Create an index on BookID in Borrowing
CREATE INDEX idx_bookid_borrowing ON Borrowing(BookID);

--  3. VIEWS
-- a. Create a view to display borrowed books and their members
CREATE VIEW BorrowedBooksView AS
SELECT Br.BorrowID, M.Name AS MemberName, B.Title AS BookTitle, Br.BorrowDate, Br.ReturnDate
FROM Borrowing Br
JOIN Members M ON Br.MemberID = M.MemberID
JOIN Books B ON Br.BookID = B.BookID;

-- b. Query the view
SELECT * FROM BorrowedBooksView;

select * from Books;

select * from Authors;


--  4. STORED PROCEDURE
-- a. Create a procedure to list books by category
DELIMITER //

CREATE PROCEDURE GetBooksByCategory(IN category_name VARCHAR(50))
BEGIN
    SELECT Title, Price 
    FROM Books 
    WHERE Category = category_name;
END //

DELIMITER ;

-- Call the procedure
CALL GetBooksByCategory('Fantasy');

--  5. USER-DEFINED FUNCTION
-- a. Create a function to calculate late fine (₹5 per day after 7 days)

DELIMITER //

CREATE FUNCTION CalculateFine(borrowDate DATE, returnDate DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE days_late INT;
    DECLARE fine DECIMAL(10,2);

    SET days_late = DATEDIFF(returnDate, borrowDate) - 7;

    IF days_late > 0 THEN
        SET fine = days_late * 5;
    ELSE
        SET fine = 0;
    END IF;

    RETURN fine;
END //

DELIMITER ;

--  6. TRIGGER
-- a. Create a trigger to update Fine when a book is returned

DELIMITER //

CREATE TRIGGER UpdateFineAfterReturn
BEFORE UPDATE ON Borrowing
FOR EACH ROW
BEGIN
    IF NEW.ReturnDate IS NOT NULL THEN
        SET NEW.Fine = CalculateFine(NEW.BorrowDate, NEW.ReturnDate);
    END IF;
END //

DELIMITER ;

-- Test the trigger

-- Assume book was borrowed on 2025-01-01 and returned on 2025-01-15 (8 days late)
UPDATE Borrowing
SET ReturnDate = '2025-01-15'
WHERE BorrowID = 1;

-- Check the fine updated:
SELECT BorrowID, BorrowDate, ReturnDate, Fine FROM Borrowing WHERE BorrowID = 1;

