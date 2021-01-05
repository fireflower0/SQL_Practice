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

SELECT CASE pref_name
       WHEN '徳島' THEN '四国'
       WHEN '香川' THEN '四国'
       WHEN '愛媛' THEN '四国'
       WHEN '高知' THEN '四国'
       WHEN '福岡' THEN '九州'
       WHEN '佐賀' THEN '九州'
       WHEN '長崎' THEN '九州'
       ELSE 'その他' END AS district,
       SUM(population)
FROM PopTbl
GROUP BY district;

DROP TABLE PopTbl;
