-- Question 1 Achieving 1NF (First Normal Form)

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
VALUES (101, 'John Doe'),
       (102, 'Jane Smith'),
       (103, 'Emily Clark');


CREATE TABLE OrderedProduct(
OrderID INT PRIMARY KEY,
ProductName VARCHAR(100)
);

INSERT INTO OrderedProduct (OrderID, ProductName)
VALUES (101, 'Laptop'),
       (101, 'Mouse'),
       (102, 'Tablet'),
       (102, 'Keyboard'),
       (102, 'Mouse'),
       (103, 'Phone');


-- Question 2 Achieving 2NF (Second Normal Form)
-- first create unnormalized form
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
    (101, 'John Doe', 'Laptop', 2),
    (101, 'John Doe', 'Mouse', 1),
    (102, 'Jane Smith', 'Tablet', 3),
    (102, 'Jane Smith', 'Keyboard', 1),
    (102, 'Jane Smith', 'Mouse', 2),
    (103, 'Emily Clark', 'Phone', 1);


-- create the first stable with only customer name/ no partial dependency
    CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


-- create table that fully depends on composite key
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

