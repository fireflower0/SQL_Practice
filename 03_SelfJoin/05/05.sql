CREATE TABLE Products (
  name VARCHAR(16) NOT NULL,
  price INTEGER NOT NULL
);

INSERT INTO Products
VALUES ('りんご',	50),
       ('みかん',	100),
       ('ぶどう',	50),
       ('スイカ',	80),
       ('レモン',	30),
       ('いちご',	100),
       ('バナナ',	100);

-- 同じ値段だけど、商品名が違うレコードを検索するSQL
SELECT DISTINCT P1.name, P1.price
FROM Products P1
INNER JOIN Products P2
  ON P1.price = P2.price
  ANd P1.name <> P2.name
ORDER BY P1.price;

-- 練習問題 : 相関サブクエリで上記を同じことをやる
SELECT P1.name, P1.price
FROM Products P1
WHERE EXISTS (
  SELECT * FROM Products P2
  WHERE P1.price = P2.price
  AND P1.name <> P2.name
)
ORDER BY P1.price;

DROP TABLE Products;
