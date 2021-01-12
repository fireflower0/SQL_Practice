CREATE TABLE Shohin (
  shohin_id CHAR(4) NOT NULL,
  shohin_mei VARCHAR(100) NOT NULL,
  shohin_bunrui VARCHAR(32) NOT NULL,
  hanbai_tanka INTEGER,
  shiire_tanka INTEGER,
  torokubi DATE,
  PRIMARY KEY (shohin_id)
);

INSERT INTO Shohin
VALUES ('0001', 'Tシャツ' ,'衣服', 1000, 500, '2009-09-20'),
       ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11'),
       ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL),
       ('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20'),
       ('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15'),
       ('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20'),
       ('0007', 'おろしがね', 'キッチン用品', 880, 790, '2008-04-28'),
       ('0008', 'ボールペン', '事務用品', 100, NULL, '2009-11-11');


EXPLAIN
SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG(hanbai_tanka) OVER (
         ORDER BY shohin_id
         ROWS BETWEEN 2 PRECEDING
         AND CURRENT ROW
       ) AS moving_avg
FROM Shohin;

DROP TABLE Shohin;
