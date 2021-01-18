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

SELECt * FROM Projects P1
WHERE '◯' = ALL(
  SELECT CASE WHEN step_nbr <= 1 AND status = '完了' THEN '◯'
              WHEN step_nbr > 1  AND status = '待機' THEN '◯'
              ELSE '☓' END
  FROM Projects P2
  WHERE P1.project_id = P2.project_id
);

DROP TABLE Projects;
