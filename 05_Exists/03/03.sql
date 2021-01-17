CREATE TABLE Projects (
  project_id VARCHAR(32),
  step_nbr INTEGER ,
  status VARCHAR(32),
  PRIMARY KEY(project_id, step_nbr)
);

INSERT INTO Projects
VALUES ('AA100', 0, '完了'),
       ('AA100', 1, '待機'),
       ('AA100', 2, '待機'),
       ('B200', 0, '待機'),
       ('B200', 1, '待機'),
       ('CS300', 0, '完了'),
       ('CS300', 1, '完了'),
       ('CS300', 2, '待機'),
       ('CS300', 3, '待機'),
       ('DY400', 0, '完了'),
       ('DY400', 1, '完了'),
       ('DY400', 2, '完了');

-- 工程1番まで完了のプロジェクトを選択 : 集合指向的な解答
SELECT project_id
FROM Projects
GROUP BY project_id
HAVING COUNT(*) = SUM(
  CASE WHEN step_nbr <= 1 AND status = '完了' THEN 1
       WHEN step_nbr > 1 AND status = '待機' THEN 1
       ELSE 0 END
);

-- 工程1番まで完了のプロジェクトを選択 : 述語論理的な解答
SELECT * FROM Projects P1
WHERE NOT EXISTS (
  SELECT status FROM Projects P2
  WHERE P1.project_id = P2.project_id  -- プロジェクトごとに条件を調べる
  AND status <> CASE WHEN step_nbr <= 1 -- 全称文を二重否定で表現する
                     THEN '完了'
                     ELSE '待機' END
);

DROP TABLE Projects;
