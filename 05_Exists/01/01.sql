CREATE TABLE Meetings (
  meeting CHAR(32) NOT NULL,
  person  CHAR(32) NOT NULL,
  PRIMARY KEY (meeting, person)
);

INSERT INTO Meetings
VALUES ('第１回', '伊藤'),
       ('第１回', '水島'),
       ('第１回', '坂東'),
       ('第２回', '伊藤'),
       ('第２回', '宮田'),
       ('第３回', '坂東'),
       ('第３回', '水島'),
       ('第３回', '宮田');

-- 全員が皆勤した場合の集合を求める
SELECT DISTINCT M1.meeting, M2.person
FROM Meetings M1
CROSS JOIN Meetings M2;

-- 欠席者だけを求めるクエリ : その１ 存在量化の応用
SELECT DISTINCT M1.meeting, M2.person
FROM Meetings M1
CROSS JOIN Meetings M2
WHERE NOT EXISTS (
  SELECT * FROM Meetings M3
  WHERE M1.meeting = M3.meeting
  AND M2.person = M3.person
);

-- 欠席者だけを求めるクエリ : その２ 差集合演算の利用
SELECT M1.meeting, M2.person
FROM Meetings M1, Meetings M2
EXCEPT
SELECT meeting, person
FROM Meetings;

DROP TABLE Meetings;
