CREATE TABLE PopTbl2 (
  pref_name VARCHAR(32),
  sex CHAR(1) NOT NULL,
  population INTEGER NOT NULL,
  PRIMARY KEY(pref_name, sex)
);

INSERT INTO PopTbl2
VALUES ('徳島', '1', 60),
       ('徳島', '2', 40),
       ('香川', '1', 100),
       ('香川', '2', 100),
       ('愛媛', '1', 100),
       ('愛媛', '2', 50),
       ('高知', '1', 100),
       ('高知', '2', 100),
       ('福岡', '1', 100),
       ('福岡', '2', 200),
       ('佐賀', '1', 20),
       ('佐賀', '2', 80),
       ('長崎', '1', 125),
       ('長崎', '2', 125),
       ('東京', '1', 250),
       ('東京', '2', 150);

SELECT
  CASE WHEN sex = '1' THEN '男' ELSE '女' END AS "性別",
  SUM(population) AS "全国",
  SUM( CASE WHEN pref_name = '徳島' THEN population ELSE 0 END ) AS "徳島",
  SUM( CASE WHEN pref_name = '香川' THEN population ELSE 0 END ) AS "香川",
  SUM( CASE WHEN pref_name = '愛媛' THEN population ELSE 0 END ) AS "愛媛",
  SUM( CASE WHEN pref_name = '高知' THEN population ELSE 0 END ) AS "高知",
  SUM(
    CASE WHEN pref_name = '徳島'
         OR pref_name = '香川'
         OR pref_name = '愛媛'
         OR pref_name = '高知'
         THEN population
         ELSE 0 END
  ) AS "四国"
FROM PopTbl2
GROUP BY sex;

DROP TABLE PopTbl2;
