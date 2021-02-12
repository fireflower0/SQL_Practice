CREATE TABLE Seats2 (
  seat INTEGER NOT NULL PRIMARY KEY,
  line_id CHAR(1) NOT NULL,
  status CHAR(2) NOT NULL CHECK (status IN ('空', '占'))
); 

INSERT INTO Seats2
VALUES (1, 'A', '占'),
       (2, 'A', '占'),
       (3, 'A', '空'),
       (4, 'A', '空'),
       (5, 'A', '空'),
       (6, 'B', '占'),
       (7, 'B', '占'),
       (8, 'B', '空'),
       (9, 'B', '空'),
       (10,'B', '空'),
       (11,'C', '空'),
       (12,'C', '空'),
       (13,'C', '空'),
       (14,'C', '占'),
       (15,'C', '空');

-- 人数分の空席を探す：ラインの折り返しも考慮する NOT EXISTS
SELECT S1.seat AS start_seat, '~', S2.seat AS end_seat
FROM Seats2 S1, Seats2 S2
WHERE S2.seat = S1.seat + (3 - 1) -- 始点と終点を決める
AND NOT EXISTS (
  SELECT * FROM Seats2 S3
  WHERE S3.seat BETWEEN S1.seat AND S2.seat
  AND ( S3.status <> '空' OR S3.line_id <> S1.line_id )
);

-- 人数分の空席を探す：行の折り返しも考慮する ウィンドウ関数
SELECT seat, '~', seat + (3 - 1)
FROM (
  SELECT seat,
         MAX(seat) OVER(
           PARTITION BY line_id
           ORDER BY seat
           ROWS BETWEEN (3 - 1) FOLLOWING AND (3 - 1) FOLLOWING
         ) AS end_seat
  FROM Seats2
  WHERE status = '空'
) TMP
WHERE end_seat - seat = (3 - 1);

DROP TABLE Seats2;
