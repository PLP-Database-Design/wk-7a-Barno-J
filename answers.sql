-- Question 1 Achieving 1NF (First Normal Form)

DROP TABLE IF EXISTS NormalizedProductDetail;

CREATE TABLE NormalizedProductDetail(
OrderID INT,
CustomerName VARCHAR(100),
Product VARCHAR(100),
PRIMARY KEY (OrderID, Product)
);

INSERT INTO NormalizedProductDetail (OrderID, CustomerName, Product)
VALUES (101, 'John Doe','Laptop'),
       (101, 'John Doe','Mouse'),
       (102, 'Jane Smith','Tablet'),
       (102, 'Jane Smith','Keyboard'),
       (103, 'Emily Clark','Mouse'),
       (103, 'Emily Clark','Phone');


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


-- create the first table with only customer name/ no partial dependency
    CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


-- create table that fully depends on composite key
CREATE TABLE OrderItems (
    ProductID INT AUTO_INCREMENT,
    Product VARCHAR(100),
    Quantity INT,
    OrderID INT,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (Product, Quantity, OrderID)
SELECT Product, Quantity, OrderID
FROM OrderDetails;

