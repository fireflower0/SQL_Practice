CREATE TABLE Digits ( digit INTEGER PRIMARY KEY );

INSERT INTO Digits
VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE SeqTbl ( seq INTEGER PRIMARY KEY );

INSERT INTO SeqTbl
VALUES (1), (2), (4), (5), (6), (7), (8), (11), (12);

CREATE VIEW Sequence (seq) AS
SELECT D1.digit + (D2.digit * 10) + (D3.digit * 100)
FROM Digits D1
CROSS JOIN Digits D2
CROSS JOIN Digits D3;

-- NOT EXISTSバージョン
SELECT seq FROM Sequence N
WHERE seq BETWEEN 1 AND 12
AND NOT EXISTS (
  SELECT * FROM SeqTbl S
  WHERE N.seq = S.seq
);

-- 外部結合バージョン
SELECT N.seq
FROM Sequence N
LEFT OUTER JOIN SeqTbl S ON N.seq = S.seq
WHERE N.seq BETWEEN 1 AND 12
AND S.seq IS NULL;

DROP VIEW Sequence;
DROP TABLE SeqTbl;
DROP TABLE Digits;
