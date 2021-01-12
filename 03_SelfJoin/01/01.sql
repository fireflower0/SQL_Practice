CREATE TABLE Products (
  name VARCHAR(16) PRIMARY KEY,
  price INTEGER NOT NULL
);

INSERT INTO Products
VALUES ('りんご',	100),
       ('みかん',	50),
       ('バナナ',	80);

-- 重複順列を得るSQL
SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1
CROSS JOIN Products P2;

-- CROSS JOINは以下のような表記でも記述できる
SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1, Products P2;

SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1
INNER JOIN Products P2 ON P1.name <> P2.name;

SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1, Products P2
WHERE P1.name <> P2.name;

SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1
INNER JOIN Products P2 ON P1.name > P2.name;

SELECT P1.name AS name_1, P2.name AS name_2, P3.name AS name_3
FROM Products P1
INNER JOIN Products P2 ON P1.name > P2.name
INNER JOIN Products P3 ON P2.name > P3.name;

DROP TABLE Products;
