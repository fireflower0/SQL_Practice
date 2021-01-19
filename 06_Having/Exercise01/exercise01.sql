CREATE TABLE SeqTbl (
  seq INTEGER NOT NULL PRIMARY KEY
);

-- ### 歯抜けなし：開始値が1
INSERT INTO SeqTbl
VALUES (1), (2), (3), (4), (5);

SELECT CASE WHEN COUNT(*) <> MAX(seq)
            THEN '歯抜け有り'
            ELSE '歯抜け無し'
            END AS gap
FROM SeqTbl;

-- ##################################################

-- ### 歯抜けあり：開始値が1
DELETE FROM SeqTbl;
INSERT INTO SeqTbl
VALUES (1), (2), (4), (5), (8);

SELECT CASE WHEN COUNT(*) <> MAX(seq)
            THEN '歯抜け有り'
            ELSE '歯抜け無し'
            END AS gap
FROM SeqTbl;

-- ##################################################

-- ### 歯抜けなし：開始値が1ではない
DELETE FROM SeqTbl;
INSERT INTO SeqTbl
VALUES (3), (4), (5), (6), (7);

SELECT CASE WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1
            THEN '歯抜け有り'
            ELSE '歯抜け無し'
            END AS gap
FROM SeqTbl;

-- ##################################################

-- ### 歯抜けあり：開始値が1ではない
DELETE FROM SeqTbl;
INSERT INTO SeqTbl
VALUES (3), (4), (7), (8), (10);

SELECT CASE WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1
            THEN '歯抜け有り'
            ELSE '歯抜け無し'
            END AS gap
FROM SeqTbl;

-- ##################################################

DROP TABLE SeqTbl;
