CREATE TABLE Seats (
  seat INTEGER NOT NULL PRIMARY KEY,
  status CHAR(2) NOT NULL CHECK (status IN ('空', '占'))
); 

INSERT INTO Seats
VALUES (1,  '占'),
       (2,  '占'),
       (3,  '空'),
       (4,  '空'),
       (5,  '空'),
       (6,  '占'),
       (7,  '空'),
       (8,  '空'),
       (9,  '空'),
       (10, '空'),
       (11, '空'),
       (12, '占'),
       (13, '占'),
       (14, '空'),
       (15, '空');

-- 人数分の空席を探す：その1 NOT EXISTS
SELECT S1.seat AS start_seat, '~', S2.seat AS end_seat
FROM Seats S1, Seats S2
WHERE S2.seat = S1.seat + (3 - 1) -- 始点と終点を決める
AND NOT EXISTS (
  SELECT * FROM Seats S3
  WHERE S3.seat BETWEEN S1.seat AND S2.seat
  AND S3.status <> '空'
);

-- 人数分の空席を探す：その2 ウィンドウ関数
SELECT seat, '~', seat + (3 - 1)
FROM (
  SELECT seat,
         MAX(seat) OVER (
           ORDER BY seat
           ROWS BETWEEN (3 - 1) FOLLOWING AND (3 - 1) FOLLOWING
         ) AS end_seat
  FROM Seats
  WHERE status = '空'
) TMP
WHERE end_seat - seat = (3 - 1);

DROP TABLE Seats;
