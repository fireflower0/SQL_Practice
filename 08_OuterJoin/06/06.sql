CREATE TABLE Class_A (
  id char(1), 
  name varchar(30), 
  PRIMARY KEY(id)
);

CREATE TABLE Class_B (
  id char(1), 
  name varchar(30), 
  PRIMARY KEY(id)
);

INSERT INTO Class_A (id, name)
VALUES ('1', '田中'), ('2', '鈴木'), ('3', '伊集院');

INSERT INTO Class_B (id, name)
VALUES ('1', '田中'), ('2', '鈴木'), ('4', '西園寺');

-- 外部結合で差集合を求める A - B
SELECT A.id AS id, A.name AS A_name
FROM Class_A A
LEFT OUTER JOIN Class_B B ON A.id = B.id
WHERE B.name IS NULL;

-- 外部結合で差集合を求める B - A
SELECT B.id AS id, B.name AS B_name
FROM Class_A A
RIGHT OUTER JOIN Class_B B ON A.id = B.id
WHERE A.name IS NULL;

-- 完全外部結合で排他的和集合を求める
SELECT COALESCE(A.id, B.id) AS id,
       COALESCE(A.name, B.name) AS name
FROM Class_A A
FULL OUTER JOIN Class_B B ON A.id = B.id
WHERE A.name IS NULL OR B.name IS NULL;

DROP TABLE Class_A;
DROP TABLE Class_B;
