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

-- ビールと紙オムツと自転車を全て置いている店舗を検索する：間違ったSQL
SELECT DISTINCT shop
FROM ShopItems
WHERE item IN (
  SELECT item FROM Items
);

-- ビールと紙オムツと自転車をすべて置いている店舗を検索する：正しい SQL
SELECT SI.shop
FROM ShopItems SI
INNER JOIN Items I ON SI.item = I.item
GROUP BY SI.shop
HAVING COUNT(SI.item) = (
  SELECT COUNT(item) FROM Items
);

-- COUNT(I.item)はもはや 3とは限らない
SELECT SI.shop, COUNT(SI.item), COUNT(I.item)
FROM ShopItems SI
INNER JOIN Items I ON SI.item = I.item
GROUP BY SI.shop;

-- 厳密な関係除算：外部結合と COUNT関数の利用
SELECT SI.shop
FROM ShopItems SI
LEFT OUTER JOIN Items I ON SI.item = I.item
GROUP BY SI.shop
HAVING COUNT(SI.item) = ( SELECT COUNT(item) FROM Items ) -- 条件 1 
AND COUNT(I.item) = ( SELECT COUNT(item) FROM Items ); -- 条件 2

DROP TABLE Items;
DROP TABLE ShopItems;
