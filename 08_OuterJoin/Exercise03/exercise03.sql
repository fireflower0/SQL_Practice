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
VALUES ('1', '田中'), ('2', '内海'), ('4', '西園寺');

-- PostgreSQLではMERGEが無いため、CONFLICTを使用
INSERT INTO Class_A
SELECT * FROM Class_B
ON CONFLICT (id)
DO UPDATE SET name = excluded.name;

-- 結果表示
SELECT * FROM Class_A;

DROP TABLE Class_A;
DROP TABLE Class_B;
