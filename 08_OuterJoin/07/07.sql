CREATE TABLE Items (item VARCHAR(16) PRIMARY KEY);
 
CREATE TABLE ShopItems (
  shop VARCHAR(16),
  item VARCHAR(16),
  PRIMARY KEY(shop, item)
);

INSERT INTO Items
VALUES ('ビール'), ('紙オムツ'), ('自転車');

INSERT INTO ShopItems
VALUES ('仙台', 'ビール'),
       ('仙台', '紙オムツ'),
       ('仙台', '自転車'),
       ('仙台', 'カーテン'),
       ('東京', 'ビール'),
       ('東京', '紙オムツ'),
       ('東京', '自転車'),
       ('大阪', 'テレビ'),
       ('大阪', '紙オムツ'),
       ('大阪', '自転車');

-- 外部結合で関係除算：差集合の応用
SELECT DISTINCT shop
FROM ShopItems SI1
WHERE NOT EXISTS (
  SELECT I.item
  FROM Items I
  LEFT OUTER JOIN ShopItems SI2 ON I.item = SI2.item
  AND SI1.shop = SI2.shop
  WHERE SI2.item IS NULL
);

DROP TABLE Items;
DROP TABLE ShopItems;
