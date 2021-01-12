CREATE TABLE Products (
  name VARCHAR(16) NOT NULL,
  price INTEGER NOT NULL
) WITH OIDS;

INSERT INTO Products
VALUES ('りんご', 50),
       ('みかん', 100),
       ('みかん', 100),
       ('みかん', 100),
       ('バナナ', 80);

DELETE FROM Products P1
WHERE oid < (
  SELECT MAX(P2.oid)
  FROM Products P2
  WHERE P1.name = P2.name
  AND P1.price = P2.price
);

SELECT * FROM Products;

DROP TABLE Products;
