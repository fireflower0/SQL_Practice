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

SELECT SI.shop,
       COUNT(SI.item) AS my_item_cnt,
       ( SELECT COUNT(item) FROM Items ) - COUNT(SI.item) AS diff_cnt
FROM ShopItems SI
INNER JOIN Items I ON SI.item = I.item
GROUP BY SI.shop;

DROP TABLE Items;
DROP TABLE ShopItems;
