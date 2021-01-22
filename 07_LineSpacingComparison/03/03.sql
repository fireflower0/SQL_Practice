CREATE TABLE Shohin (
  shohin_id VARCHAR(4) PRIMARY KEY,
  shohin_mei VARCHAR(30) NOT NULL,
  shohin_bunrui VARCHAR(30) NOT NULL,
  hanbai_tanka INTEGER NOT NULL
);

INSERT INTO Shohin
VALUES ('0001', 'Tシャツ', '衣服', 1000),
       ('0002', '穴あけパンチ', '事務用品', 500),
       ('0003', 'カッターシャツ', '衣服', 4000),
       ('0004', '包丁', 'キッチン用品', 3000),
       ('0005', '圧力鍋', 'キッチン用品', 6800),
       ('0006', 'フォーク', 'キッチン用品', 500),
       ('0007', 'おろしがね', 'キッチン用品', 880),
       ('0008', 'ボールペン', '事務用品', 100);

-- 平均単価より高い商品を選択する：相関サブクエリ
SELECT shohin_bunrui, shohin_mei, hanbai_tanka
FROM Shohin S1
WHERE hanbai_tanka > (
  SELECT AVG(hanbai_tanka)
  FROM Shohin S2
  WHERE S1.shohin_bunrui = S2.shohin_bunrui
  GROUP BY shohin_bunrui
);

-- 平均単価より高い商品を選択する：ウィンドウ関数
SELECT shohin_mei, shohin_bunrui, hanbai_tanka
FROM (
  SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
         AVG(hanbai_tanka) OVER (
           PARTITION BY shohin_bunrui
         ) AS avg_tanka
  FROM Shohin
) TMP
WHERE hanbai_tanka > avg_tanka;

DROP TABLE Shohin;
