CREATE TABLE Digits ( digit INTEGER PRIMARY KEY );

INSERT INTO Digits
VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

-- 連番を求める：その1 0 〜 99
SELECT D1.digit + (D2.digit * 10) AS seq
FROM Digits D1
CROSS JOIN Digits D2
ORDER BY seq;

-- 連番を求める：その2 1 〜 542を求める
SELECT D1.digit + (D2.digit * 10) + (D3.digit * 100) AS seq
FROM Digits D1
CROSS JOIN Digits D2
CROSS JOIN Digits D3
WHERE D1.digit + (D2.digit * 10) + (D3.digit * 100) BETWEEN 1 AND 542
ORDER BY seq;

-- シーケンスビューを作る (0 〜 999までをカバー)
CREATE VIEW Sequence (seq) AS
SELECT D1.digit + (D2.digit * 10) + (D3.digit * 100)
FROM Digits D1
CROSS JOIN Digits D2
CROSS JOIN Digits D3;

-- シーケンスビューから1 〜 100まで取得
SELECT seq FROM Sequence
WHERE seq BETWEEN 1 AND 100
ORDER BY seq;

DROP VIEW Sequence;
DROP TABLE Digits;
