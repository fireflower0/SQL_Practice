CREATE TABLE Accounts (
  prc_date DATE NOT NULL, 
  prc_amt INTEGER NOT NULL, 
  PRIMARY KEY (prc_date)
);

INSERT INTO Accounts
VALUES ('2018-10-26', 12000),
       ('2018-10-28', 2500),
       ('2018-10-31', -15000),
       ('2018-11-03', 34000),
       ('2018-11-04', -5000),
       ('2018-11-06', 7200),
       ('2018-11-11', 11000);

-- レコード数が3行未満の場合は結果をNULLとする

-- ウィンドウ関数
SELECT prc_date, prc_amt,
       CASE WHEN cnt < 3 THEN NULL ELSE mvg_avg END AS mvg_avg
FROM (
  SELECT prc_date, prc_amt,
         AVG(prc_amt) OVER(
           ORDER BY prc_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
         ) mvg_avg,
         COUNT(*) OVER(
           ORDER BY prc_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
         ) AS cnt
  FROM Accounts
) TMP;

-- 相関サブクエリ
SELECT prc_date, A1.prc_amt,
       (
         SELECT AVG(prc_amt) FROM Accounts A2
         WHERE A1.prc_date >= A2.prc_date
         AND (
           SELECT COUNT(*) FROM Accounts A3
           WHERE A3.prc_date BETWEEN A2.prc_date AND A1.prc_date
         ) <= 3
         HAVING COUNT(*) = 3
       ) AS mvg_sum -- 3行未満は非表示
FROM Accounts A1
ORDER BY prc_date;

DROP TABLE Accounts;
