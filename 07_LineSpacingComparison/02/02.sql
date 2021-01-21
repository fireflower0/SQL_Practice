CREATE TABLE Sales2 (
  year INTEGER NOT NULL , 
  sale INTEGER NOT NULL , 
  PRIMARY KEY (year)
);

INSERT INTO Sales2
VALUES (1990, 50),
       (1992, 50),
       (1993, 52),
       (1994, 55),
       (1997, 55);

-- 直近の年と同じ年商の年を選択する：その1 相関サブクエリ
SELECT year, sale
FROM Sales2 S1
WHERE sale = (
  SELECT sale FROM Sales2 S2
  WHERE S2.year = (
    SELECT MAX(year) -- 条件2：条件1を満たす年度の中で最大
    FROM Sales2 S3
    WHERE S1.year > S3.year -- 条件1：自分より過去である
  )
);

-- 直近の年と同じ年商の年を選択する：その2 ウィンドウ関数
SELECT year, current_sale
FROM (
  SELECT year, sale AS current_sale,
         SUM(sale) OVER (
           ORDER BY year
           ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
         ) AS pre_sale
  FROM Sales2
) TMP
WHERE current_sale = pre_sale
ORDER BY year;

DROP TABLE Sales2;
