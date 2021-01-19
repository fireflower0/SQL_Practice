CREATE TABLE Graduates (
  name VARCHAR(16) PRIMARY KEY,
  income INTEGER NOT NULL
);

INSERT INTO Graduates
VALUES ('サンプソン', 400000),
       ('マイク', 30000),
       ('ホワイト', 20000),
       ('アーノルド', 20000),
       ('スミス', 20000),
       ('ロレンス', 15000),
       ('ハドソン', 15000),
       ('ケント', 10000),
       ('ベッカー', 10000),
       ('スコット', 10000);

-- 最頻値を求めるSQL：その1 ALL述語の利用
SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM Graduates
  GROUP BY income
);

-- 最頻値を求めるSQL：その2 極値関数の利用
SELECT income, COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= (
  SELECT MAX(cnt)
  FROM (
    SELECT COUNT(*) AS cnt
    FROM Graduates
    GROUP BY income
  ) TMP
);

DROP TABLE Graduates;
