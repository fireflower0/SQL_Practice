CREATE TABLE CourseMaster (
  course_id   INTEGER PRIMARY KEY,
  course_name VARCHAR(32) NOT NULL
);

CREATE TABLE OpenCourses (
  month       INTEGER ,
  course_id   INTEGER ,
  PRIMARY KEY (month, course_id)
);

INSERT INTO CourseMaster
VALUES (1, '経理入門'),
       (2, '財務知識'),
       (3, '簿記検定'),
       (4, '税理士');

INSERT INTO OpenCourses
VALUES (202106, 1),
       (202106, 3),
       (202106, 4),
       (202107, 4),
       (202108, 2),
       (202108, 4);

-- IN述語の利用
SELECT course_name,
       CASE WHEN course_id IN (
         SELECT course_id FROM OpenCourses WHERE month = 202106
       ) THEN '◯' ELSE '☓' END AS "6月",
       CASE WHEN course_id IN (
         SELECT course_id FROM OpenCourses WHERE month = 202107
       ) THEN '◯' ELSE '☓' END AS "7月",
       CASE WHEN course_id IN (
         SELECT course_id FROM OpenCourses WHERE month = 202108
       ) THEN '◯' ELSE '☓' END AS "8月"
FROM CourseMaster;

-- EXISTS述語の利用
SELECT CM.course_name,
       CASE WHEN EXISTS (
         SELECT course_id
         FROM OpenCourses OC
         WHERE month = 202106
         AND OC.course_id = CM.course_id
       ) THEN '◯' ELSE '☓' END AS "6月",
       CASE WHEN EXISTS (
         SELECT course_id
         FROM OpenCourses OC
         WHERE month = 202107
         AND OC.course_id = CM.course_id
       ) THEN '◯' ELSE '☓' END AS "7月",
       CASE WHEN EXISTS (
         SELECT course_id
         FROM OpenCourses OC
         WHERE month = 202108
         AND OC.course_id = CM.course_id
       ) THEN '◯' ELSE '☓' END AS "8月"
FROM CourseMaster CM;

DROP TABLE CourseMaster;
DROP TABLE OpenCourses;
