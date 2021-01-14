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
       ('バナナ',	50);

-- ランキング算出 : ウィンドウ関数の利用
SELECT name, price,
       RANK() OVER (
         ORDER BY price DESC
       ) AS rank_1,
       DENSE_RANK() OVER (
         ORDER BY price DESC
       ) AS rank_2
FROM Products;

-- ランキング１位からはじまる。同順位が続いた後は不連続
SELECT P1.name, P1.price,
       (
         SELECT COUNT(P2.price)
         FROM Products P2
         WHERE P2.price > P1.price
       ) + 1 AS rank_1
FROM Products P1
ORDER BY rank_1;

-- ランキング算出 : 自己結合の場合
SELECT P1.name,
       MAX(P1.price) AS price,
       COUNT(P2.name) + 1 AS rank_1
FROM Products P1
LEFT OUTER JOIN Products P2 ON P1.price < P2.price
GROUP BY P1.name
ORDER BY rank_1;

-- 非集約化して、集合の包含関係を調べる
SELECT P1.name, P2.name
FROM Products P1
LEFT OUTER JOIN Products P2 ON P1.price < P2.price
ORDER BY P1.price DESC;

DROP TABLE Products;
