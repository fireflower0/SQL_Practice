CREATE TABLE Reservations (
  reserver VARCHAR(30) PRIMARY KEY,
  start_date DATE  NOT NULL,
  end_date DATE  NOT NULL
);

INSERT INTO Reservations
VALUES ('木村', '2018-10-26', '2018-10-27'),
       ('荒木', '2018-10-28', '2018-10-31'),
       ('堀', '2018-10-31', '2018-11-01'),
       ('山本', '2018-11-03', '2018-11-04'),
       ('内田', '2018-11-03', '2018-11-05'),
       ('水谷', '2018-11-06', '2018-11-06');

-- オーバーラップする期間を求める：その1 相関サブクエリの利用
SELECT reserver, start_date, end_date
FROM Reservations R1
WHERE EXISTS (
  SELECT * FROM Reservations R2
  WHERE R1.reserver <> R2.reserver -- 自分意外の客と比較する
  AND (
    -- 条件(1)：開始日が他の期間内にある
    R1.start_date BETWEEN R2.start_date AND R2.end_date
    OR
    -- 条件(2)：終了日が他の期間内にある
    R1.end_date BETWEEN R2.start_date AND R2.end_date
  )
);

-- オーバーラップする期間を求める：その2 ウィンドウ関数の利用
SELECT reserver, next_reserver
FROM (
  SELECT reserver, start_date, end_date,
         MAX(start_date) OVER (
           ORDER BY start_date ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING
         ) AS next_start_date,
         MAX(reserver) OVER (
           ORDER BY start_date ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING
         ) AS next_reserver
  FROM Reservations
) TMP
WHERE next_start_date BETWEEN start_date AND end_date;

DROP TABLE Reservations;
