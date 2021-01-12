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
WHERE EXISTS (
  SELECT * FROM Products P2
  WHERE P1.name = P2.name
  AND P1.price = P2.price
  AND P1.oid < P2.oid
);

SELECT * FROM Products;

DROP TABLE Products;
