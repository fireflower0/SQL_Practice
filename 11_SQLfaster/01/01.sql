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

-- Class_AテーブルからClass_Bテーブルにも存在する受講生を選択する

-- 遅い
SELECT * FROM Class_A
WHERE id IN(
  SELECT id FROM Class_B
);

-- 速い
SELECT * FROM Class_A A
WHERE EXISTS(
  SELECT * FROM Class_B B
  WHERE A.id = B.id
);

-- INを結合で代用
SELECT A.id, A.name
FROM Class_A A
INNER JOIN Class_B B ON A.id = B.id;

DROP TABLE Class_A;
DROP TABLE Class_B;
