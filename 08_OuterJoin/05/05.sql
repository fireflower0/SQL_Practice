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

-- 完全外部結合は情報を「完全」に保存する
SELECT COALESCE(A.id, B.id) AS id,
       A.name AS A_name,
       B.name AS B_name
FROM Class_A A
FULL OUTER JOIN Class_B B ON A.id = B.id;

-- 完全外部結合が使えない環境での代替方法
SELECT A.id AS id, A.name, B.name
FROM Class_A A
LEFT OUTER JOIN Class_B B ON A.id = B.id
UNION
SELECT B.id AS id, A.name, B.name
FROM Class_A A
RIGHT OUTER JOIN Class_B B ON A.id = B.id;

DROP TABLE Class_A;
DROP TABLE Class_B;
