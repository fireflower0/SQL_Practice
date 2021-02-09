CREATE TABLE Digits ( digit INTEGER PRIMARY KEY );

INSERT INTO Digits
VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

-- シーケンスビューを作る (0 〜 999までをカバー)
CREATE VIEW Sequence (seq) AS
SELECT D1.digit + (D2.digit * 10) + (D3.digit * 100)
FROM Digits D1
CROSS JOIN Digits D2
CROSS JOIN Digits D3;

CREATE TABLE SeqTbl ( seq INTEGER PRIMARY KEY );

INSERT INTO SeqTbl
VALUES (1), (2), (4), (5), (6), (7), (8), (11), (12);

-- EXCEPTバージョン
SELECT seq FROM Sequence WHERE seq BETWEEN 1 AND 12
EXCEPT
SELECT seq FROM SeqTbl;

-- NOT INバージョン
SELECT seq FROM Sequence
WHERE seq BETWEEN 1 AND 12
AND seq NOT IN (
  SELECT seq FROM SeqTbl
);

-- 連番の範囲を動的に決定するクエリ
SELECT seq FROM Sequence
WHERE seq BETWEEN ( SELECT MIN(seq) FROM SeqTbl )
              AND ( SELECT MAX(seq) FROM SeqTbl )
EXCEPT
SELECT seq FROM SeqTbl;

DROP VIEW Sequence;
DROP TABLE Digits;
DROP TABLE SeqTbl;
