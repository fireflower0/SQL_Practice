CREATE TABLE TestScores (
  student_id INTEGER,
  subject VARCHAR(32) ,
  score INTEGER,
  PRIMARY KEY(student_id, subject)
);

INSERT INTO TestScores
VALUES (100, '算数', 100),
       (100, '国語', 80),
       (100, '理科', 80),
       (200, '算数', 80),
       (200, '国語', 95),
       (300, '算数', 40),
       (300, '国語', 90),
       (300, '社会', 55),
       (400, '算数', 80);

SELECT DISTINCT student_id
FROM TestScores TS1
WHERE NOT EXISTS (
  -- 以下の条件を満たす行が存在しない
  SELECT * FROM TestScores TS2
  WHERE TS2.student_id = TS1.student_id
  AND TS2.score < 50 -- 50点未満の教科
);

SELECT DISTINCT student_id
FROM TestScores TS1
WHERE subject IN ('算数', '国語')
AND NOT EXISTS (
  SELECT * FROM TestScores TS2
  WHERE TS2.student_id = TS1.student_id
  AND 1 = CASE WHEN subject = '算数' AND score < 80 THEN 1
               WHEN subject = '国語' AND score < 50 THEN 1
               ELSE 0 END
);

SELECT student_id
FROM TestScores TS1
WHERE subject IN ('算数', '国語')
AND NOT EXISTS (
  SELECT * FROM TestScores TS2
  WHERE TS2.student_id = TS1.student_id
  AND 1 = CASE WHEN subject = '算数' AND score < 80 THEN 1
               WHEN subject = '国語' AND score < 50 THEN 1
               ELSE 0 END
)
GROUP BY student_id
HAVING COUNT(*) = 2; -- 必ず2教科そろっていること

DROP TABLE TestScores;
