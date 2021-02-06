CREATE TABLE Products (
  id SERIAL, -- PostgreSQL12以降ではWITH OIDSは廃止されてるようなので連番IDをつける
  name CHAR(16),
  price INTEGER
);

INSERT INTO Products (name, price)
VALUES ('りんご',  50),
       ('みかん', 100),
       ('みかん', 100),
       ('みかん', 100),
       ('バナナ',  80);

-- 重複行を削除する高速なクエリ2：補集合をNOT INで求める
DELETE FROM Products
WHERE id NOT IN (
  SELECT MAX(id) FROM Products
  GROUP BY name, price
);

SELECT * FROM Products;

DROP TABLE Products;
