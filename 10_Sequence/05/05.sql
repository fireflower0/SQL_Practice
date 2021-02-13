CREATE TABLE MyStock (
  deal_date DATE PRIMARY KEY,
  price INTEGER
);

INSERT INTO MyStock
VALUES ('2018-01-06', 1000),
       ('2018-01-08', 1050),
       ('2018-01-09', 1050),
       ('2018-01-12', 900),
       ('2018-01-13', 880),
       ('2018-01-14', 870),
       ('2018-01-16', 920),
       ('2018-01-17', 1000),
       ('2018-01-18', 2000);

-- 前回取引から上昇したかどうかを判断する
SELECT deal_date, price,
       CASE SIGN(
              price - MAX(price) OVER(
                ORDER BY deal_date
                ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
              )
            )
            WHEN 1 THEN 'UP'
            WHEN 0 THEN 'STAY'
            WHEN -1 THEN 'DOWN'
            ELSE NULL
       END AS diff
FROM MyStock;

-- 「UP」のレコードだけに限定して、昇順の連番を振ったViewを作っておく
CREATE VIEW MyStockUpSeq(deal_date, price, row_num)
AS
SELECT deal_date, price, row_num
FROM (
  SELECT deal_date, price,
         CASE SIGN(
                price - MAX(price) OVER(
                  ORDER BY deal_date
                  ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
                )
              )
              WHEN 1 THEN 'UP'
              WHEN 0 THEN 'STAY'
              WHEN -1 THEN 'DOWN'
              ELSE NULL
         END AS diff,
         ROW_NUMBER() OVER( ORDER BY deal_date ) AS row_num
  FROM MyStock
) TMP
WHERE diff = 'UP';

-- MyStockupSeqの確認
SELECT * FROM MyStockUpSeq;

-- 自己結合でシーケンスをグループ化
SELECT MIN(deal_date) AS start_date, '~', MAX(deal_date) AS end_date
FROM (
  SELECT M1.deal_date, COUNT(M2.row_num) - MIN(M1.row_num) AS gap
  FROM MyStockUpSeq M1
  INNER JOIN MyStockUpSeq M2 ON M2.row_num <= M1.row_num
  GROUP BY M1.deal_date
) TMP
GROUP BY gap;

-- サブクエリ内部の自己結合の結果を表示してみる
SELECT M1.deal_date,
       COUNT(M2.row_num) cnt,
       MIN(M1.row_num) min_row_num,
       COUNT(M2.row_num) - MIN(M1.row_num) AS gap
FROM MyStockUpSeq M1
INNER JOIN MyStockUpSeq M2 ON M2.row_num <= M1.row_num
GROUP BY M1.deal_date;

DROP VIEW MyStockUpSeq;
DROP TABLE MyStock;
