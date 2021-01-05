CREATE TABLE PopTbl (pref_name text, population integer);

INSERT INTO PopTbl
VALUES ('徳島', 100),
       ('香川', 200),
       ('愛媛', 150),
       ('高知', 200),
       ('福岡', 300),
       ('佐賀', 100),
       ('長崎', 200),
       ('東京', 400),
       ('群馬',  50);

SELECT CASE WHEN population < 100 THEN '01'
       WHEN population >= 100 AND population < 200 THEN '02'
       WHEN population >= 200 AND population < 300 THEN '03'
       WHEN population >= 300 THEN '04'
       ELSE NULL END AS pop_class,
       COUNT(*) AS cnt
FROM PopTbl
GROUP BY CASE WHEN population < 100 THEN '01'
         WHEN population >= 100 AND population < 200 THEN '02'
         WHEN population >= 200 AND population < 300 THEN '03'
         WHEN population >= 300 THEN '04'
         ELSE NULL END;

DROP TABLE PopTbl;
