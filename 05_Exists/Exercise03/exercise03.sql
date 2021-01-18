CREATE TABLE Digits (
  digit INTEGER NOT NULL
);

INSERT INTO Digits
VALUES (0), (1), (2), (3), (4),
       (5), (6), (7), (8), (9);

-- 1〜100の数を持つNumbersビューを作る
CREATE VIEW Numbers (num)
AS
SELECT D1.digit + (D2.digit * 10) + 1
FROM Digits D1, Digits D2;

-- 被除数の集合
CREATE VIEW Dividend (num)
AS
SELECT D1.digit + (D2.digit * 10) + 1
FROM Digits D1, Digits D2;

-- 除数の集合
CREATE VIEW Divisor (num)
AS
SELECT D1.digit + (D2.digit * 10) + 1
FROM Digits D1, Digits D2;

-- 確認用
-- SELECT * FROM Numbers ORDER BY num;
-- SELECT * FROM Dividend ORDER BY num;
-- SELECT * FROM Divisor ORDER BY num;

SELECT num AS prime
FROM Numbers Dividend
WHERE num > 1
AND NOT EXISTS(
  SELECT * FROM Numbers Divisor
  WHERE Divisor.num <= Dividend.num / 2
  AND Divisor.num <> 1
  AND MOD(Dividend.num, Divisor.num) = 0
)
ORDER BY prime;

DROP VIEW Numbers;
DROP VIEW Dividend;
DROP VIEW Divisor;
DROP TABLE Digits;
