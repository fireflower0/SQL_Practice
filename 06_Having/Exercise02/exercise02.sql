CREATE TABLE Students (
  student_id INTEGER PRIMARY KEY,
  dpt VARCHAR(16) NOT NULL,
  sbmt_date DATE
);

INSERT INTO Students
VALUES (100, '理学部', '2018-10-10'),
       (101, '理学部', '2018-09-22'),
       (102, '文学部', NULL),
       (103, '文学部', '2018-09-10'),
       (200, '文学部', '2018-09-22'),
       (201, '工学部', NULL),
       (202, '経済学部', '2018-09-25');

-- 全員が9月中に提出済みの学部を選択
SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = SUM(
  CASE WHEN sbmt_date BETWEEN '2018-09-01' AND '2018-09-30'
       THEN 1 ELSE 0 END
);

-- 全員が9月中に提出済みの学部を選択：別解
SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = SUM(
  CASE WHEN EXTRACT( YEAR FROM sbmt_date ) = 2018
            AND EXTRACT(MONTH FROM sbmt_date) = 09
       THEN 1 ELSE 0 END
);

DROP TABLE Students;
