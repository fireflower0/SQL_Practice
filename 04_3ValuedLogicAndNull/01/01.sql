CREATE TABLE Students (
  name CHAR(16) PRIMARY KEY,
  age INTEGER
);

INSERT INTO Students
VALUES ('ブラウン', 22),
       ('ラリー', 19),
       ('ジョン', NULL),
       ('ボギー', 21);

-- 年齢が20歳か、20歳でない生徒を選択せよ
SELECT * FROM Students
WHERE age = 20
OR age <> 20;

-- 第三の条件を追加 : 年齢が20歳か、20歳でないか、または年齢がわからない
SELECT * FROM Students
WHERE age = 20
OR age <> 20
OR age IS NULL;

DROP TABLE Students;
