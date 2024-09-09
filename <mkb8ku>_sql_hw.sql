-- World database 
-- #1 
SELECT name FROM country WHERE continent = 'South America'

-- #2
SELECT population FROM country WHERE name = 'Germany'

-- #3
SELECT name FROM city WHERE countrycode = (SELECT code FROM country WHERE name = 'Japan')

-- #4
SELECT country.Name, country.Population
FROM country 
WHERE country.Region = 'Africa'
ORDER BY country.Population DESC
LIMIT 3

-- #5
SELECT C.Name AS CountryName, C.LifeExpectancy
FROM Country AS C
WHERE C.Population BETWEEN 1000000 AND 5000000

-- #6
SELECT C.Name AS CountryName
FROM Country AS C
JOIN CountryLanguage AS CL ON C.Code = CL.CountryCode
WHERE CL.Language = 'French' AND CL.IsOfficial = 'T'

-- Chinook database
-- #7 
SELECT * FROM Album
JOIN Artist 
WHERE name = 'AC/DC'

-- #8
SELECT FirstName, LastName, Email FROM Customer WHERE country = 'Brazil'

-- #9 
SELECT * FROM Playlist

-- #10
SELECT Count(*) FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Rock' 

-- #11
SELECT FirstName, LastName FROM Employee
WHERE REportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy'AND LastName = 'Edwards')

-- #12
SELECT Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TotalSales
FROM Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId 
GROUP BY Customer.FirstName, Customer.LastName
ORDER BY TotalSales DESC;

-- Part 2 
-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Price DECIMAL(10, 2));

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100));

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    BookID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID));

-- Insert data into Books table
INSERT INTO Books (BookID, Title, Author, Price) VALUES
(1, '1984', 'George Orwell', 9.99),
(2, 'To Kill a Mockingbird', 'Harper Lee', 7.99),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 10.99),
(4, 'Pride and Prejudice', 'Jane Austen', 8.99),
(5, 'Moby-Dick', 'Herman Melville', 11.99);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES
(1, 'John', 'Doe', 'johndoe@example.com'),
(2, 'Jane', 'Smith', 'janesmith@example.com'),
(3, 'Alice', 'Johnson', 'alicejohnson@example.com'),
(4, 'Bob', 'Brown', 'bobbrown@example.com'),
(5, 'Charlie', 'Davis', 'charliedavis@example.com');

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, BookID, OrderDate) VALUES
(1, 1, 1, '2024-09-01'),
(2, 2, 3, '2024-09-02'),
(3, 3, 5, '2024-09-03'),
(4, 4, 4, '2024-09-04'),
(5, 5, 2, '2024-09-05');

-- Write queries 
SELECT O.OrderID, B.Title, O.OrderDate
FROM Orders AS O
JOIN Books AS B ON O.BookID = B.BookID
JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE C.FirstName = 'John' AND C.LastName = 'Doe';

SELECT B.Title, B.Price
FROM Books AS B
WHERE B.Price > 10;

SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;
