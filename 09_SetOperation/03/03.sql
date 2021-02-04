CREATE TABLE Skills (
  skill VARCHAR(32),
  PRIMARY KEY(skill)
);

CREATE TABLE EmpSkills (
  emp VARCHAR(32), 
  skill VARCHAR(32),
  PRIMARY KEY(emp, skill)
);

INSERT INTO Skills
VALUES ('Oracle'), ('UNIX'), ('Java');

INSERT INTO EmpSkills
VALUES ('相田', 'Oracle'),
       ('相田', 'UNIX'),
       ('相田', 'Java'),
       ('相田', 'C#'),
       ('神崎', 'Oracle'),
       ('神崎', 'UNIX'),
       ('神崎', 'Java'),
       ('平井', 'UNIX'),
       ('平井', 'Oracle'),
       ('平井', 'PHP'),
       ('平井', 'Perl'),
       ('平井', 'C++'),
       ('若田部', 'Perl'),
       ('渡来', 'Oracle');

-- 差集合で関係除算（剰余を持った除算）
SELECT DISTINCT emp FROM EmpSkills ES1
WHERE NOT EXISTS (
  SELECT skill FROM Skills
  EXCEPT
  SELECT skill FROM EmpSkills ES2 WHERE ES1.emp = ES2.emp
);

DROP TABLE Skills;
DROP TABLE EmpSkills;
