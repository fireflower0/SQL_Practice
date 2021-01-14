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

CREATE TABLE Products_NoRedundant
AS
SELECT ROW_NUMBER() OVER (
  PARTITION BY name, price
  ORDER BY name
) AS row_num,
name, price
FROM Products;

DELETE FROM Products_NoRedundant
WHERE row_num > 1;

SELECT * FROM Products_NoRedundant;

DROP TABLE Products;
DROP TABLE Products_NoRedundant;
