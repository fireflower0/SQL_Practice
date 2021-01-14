CREATE TABLE Products (
  name VARCHAR(16) NOT NULL,
  price INTEGER NOT NULL
);

INSERT INTO Products
VALUES ('りんご', 100),
       ('みかん', 50),
       ('バナナ', 80);

SELECT DISTINCT P1.name name_1, P2.name name_2
FROM Products P1
INNER JOIN Products P2 ON P1.name >= P2.name;

DROP TABLE Products;
