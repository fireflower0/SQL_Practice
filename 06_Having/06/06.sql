CREATE TABLE TestResults (
  student_id CHAR(12) NOT NULL PRIMARY KEY,
  class   CHAR(1)  NOT NULL,
  sex     CHAR(1)  NOT NULL,
  score   INTEGER  NOT NULL
);

INSERT INTO TestResults
VALUES ('001', 'A', '男', 100),
       ('002', 'A', '女', 100),
       ('003', 'A', '女',  49),
       ('004', 'A', '男',  30),
       ('005', 'B', '女', 100),
       ('006', 'B', '男',  92),
       ('007', 'B', '男',  80),
       ('008', 'B', '男',  80),
       ('009', 'B', '女',  10),
       ('010', 'C', '男',  92),
       ('011', 'C', '男',  80),
       ('012', 'C', '女',  21),
       ('013', 'D', '女', 100),
       ('014', 'D', '女',   0),
       ('015', 'D', '女',   0);

-- クラスの75%以上の生徒が80点以上のクラス
SELECT class
FROM TestResults
GROUP BY class
HAVING COUNT(*) * 0.75 <= SUM(
  CASE WHEN score >= 80 THEN 1 ELSE 0 END
);

-- 50点以上を取った生徒のうち、男子の数が女子の数より多いクラス
SELECT class
FROM TestResults
GROUP BY class
HAVING SUM( CASE WHEN score >= 50 AND sex = '男' THEN 1 ELSE 0 END )
       >
       SUM( CASE WHEN score >= 50 AND sex = '女' THEN 1 ELSE 0 END );

-- 女子の平均点が、男子の平均点より高いクラス
--- 男子と女子の平均点を比較するクエリ：その1 空集合に対する平均を0で返す
SELECT class
FROM TestResults
GROUP BY class
HAVING AVG( CASE WHEN sex = '男' THEN score ELSE 0 END )
       <
       AVG( CASE WHEN sex = '女' THEN score ELSE 0 END );

--- 男子と女子の平均点を比較するクエリ：その2 空集合に対する平均をNULLで返す
SELECT class
FROM TestResults
GROUP BY class
HAVING AVG( CASE WHEN sex = '男' THEN score ELSE NULL END )
       <
       AVG( CASE WHEN sex = '女' THEN score ELSE NULL END );

DROP TABLE TestResults;
