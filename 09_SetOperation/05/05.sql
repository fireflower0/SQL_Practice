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

-- 重複行を削除する高速なクエリ１：補集合をexceptで求める
DELETE FROM Products
WHERE id IN (
  SELECT id FROM Products -- 全体のid
  EXCEPT -- 引く
  SELECT MAX(id) FROM Products -- 残すべきid
  GROUP BY name, price
);

SELECT * FROM Products;

DROP TABLE Products;
