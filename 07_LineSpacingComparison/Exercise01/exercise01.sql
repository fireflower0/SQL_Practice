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

-- カレント行と前2行を含む3行をウィンドウとする移動平均を求める

-- ウィンドウ関数による計算
SELECT prc_date, prc_amt,
       AVG(prc_amt) OVER (
         ORDER BY prc_date
         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       )
FROM Accounts;

-- 相関サブクエリによる計算
SELECT prc_date, A1.prc_amt,
       (
         SELECT AVG(prc_amt) FROM Accounts A2
         WHERE A1.prc_date >= A2.prc_date
         AND (
           SELECT COUNT(*) FROM Accounts A3
           WHERE A3.prc_date
           BETWEEN A2.prc_date AND A1.prc_date
         ) <= 3
       ) AS mvg_sum
FROM Accounts A1
ORDER BY prc_date;

-- 非グループ化して表示
SELECT A1.prc_date AS A1_date,
       A2.prc_date AS A2_date,
       A2.prc_amt AS amt
FROM Accounts A1, Accounts A2
WHERE A1.prc_date >= A2.prc_date
AND (
  SELECT COUNT(*) FROM Accounts A3
  WHERE A3.prc_date BETWEEN A2.prc_date AND A1.prc_date
) <= 3
ORDER BY A1_date, A2_date;

DROP TABLE Accounts;
