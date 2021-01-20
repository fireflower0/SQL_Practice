CREATE TABLE Sales (
  year INTEGER NOT NULL , 
  sale INTEGER NOT NULL ,
  PRIMARY KEY (year)
);

INSERT INTO Sales
VALUES (1990, 50),
       (1991, 51),
       (1992, 52),
       (1993, 52),
       (1994, 50),
       (1995, 50),
       (1996, 49),
       (1997, 55);

-- 前年と年商が同じ年度を求める：その1 相関サブクエリの利用
SELECT year, sale
FROM Sales S1
WHERE sale = (
  SELECT sale FROM Sales S2
  WHERE S2.year = S1.year - 1
);

-- 前年と年商が同じ年度を求める：その2 ウィンドウ関数の利用
-- 注：PostgreSQLではVersion 11以降でないとRANGEがサポートされてないのでエラーになる
-- 自分の環境ではVersion 12.5なのになぜかエラーになった・・・何故だ・・・？
SELECT year, current_sale
FROM (
  SELECT year, sale AS current_sale,
         SUM(sale) OVER (
           ORDER BY year
           RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING
         ) AS pre_sale
  FROM Sales
) TMP
WHERE current_sale = pre_sale
ORDER BY year;

-- ウィンドウ関数のみで実行してみる
SELECT year, sale AS current_sale,
       SUM(sale) OVER (
         ORDER BY year
         RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING
       ) AS pre_sale
FROM Sales;

-- 成長、後退、現状維持を一度に求める：その1 相関サブクエリの利用
SELECT year, current_sale AS sale,
       CASE WHEN current_sale = pre_sale THEN '→'
            WHEN current_sale > pre_sale THEN '↑'
            WHEN current_sale < pre_sale THEN '↓'
            ELSE '-' END AS var
FROM (
  SELECT year,
         sale AS current_sale,
         (
           SELECT sale
           FROM Sales S2
           WHERE S2.year = S1.year - 1
         ) AS pre_sale
  FROM Sales S1
) TMP
ORDER BY year;

-- 成長、後退、現状維持を一度に求める：その2 Window関数の利用
SELECT year, current_sale AS sale,
       CASE WHEN current_sale = pre_sale THEN '→'
            WHEN current_sale > pre_sale THEN '↑'
            WHEN current_sale < pre_sale THEN '↓'
            ELSE '-' END AS var
FROM (
  SELECT year,
         sale AS current_sale,
         SUM(sale) OVER (
           ORDER BY year
           RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING
         ) AS pre_sale
  FROM Sales S1
) TMP
ORDER BY year;

DROP TABLE Sales;
