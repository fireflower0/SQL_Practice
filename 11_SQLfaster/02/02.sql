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

/*
UNION, INTERSECT, EXCEPTといった集合演算子は普通に使うと
必ず重複排除のためのソートを行う
*/
SELECT * FROM Class_A
UNION
SELECT * FROM Class_B;

/*
重複を気にしなくて良い場合、または重複が発生しないことが事前に明らかな場合は、
UNIONの代わりにUNION ALLを使えばソートは発生しない
*/
SELECT * FROM Class_A
UNION ALL
SELECT * FROM Class_B;

DROP TABLE Class_A;
DROP TABLE Class_B;
