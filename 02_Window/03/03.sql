CREATE TABLE LoadSample (
  sample_date DATE PRIMARY KEY,
  load_val INTEGER NOT NULL
);

INSERT INTO LoadSample
VALUES ('2018-02-01', 1024),
       ('2018-02-02', 2366),
       ('2018-02-05', 2366),
       ('2018-02-07', 985),
       ('2018-02-08', 780),
       ('2018-02-12', 1000);

-- フレームは前だけでなく「後ろ」にも移動させることができる
SELECT sample_date AS cur_date,
       load_val AS cur_load,
       MIN(sample_date) OVER W AS next_date,
       MIN(load_val) OVER W AS next_load
FROM LoadSample
WINDOW W AS (
  ORDER BY sample_date ASC
  ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING
);

-- これでも結果はMINと同じ
SELECT sample_date AS cur_date,
       load_val AS cur_load,
       MAX(sample_date) OVER W AS latest_date,
       MAX(load_val) OVER W AS latest_load
FROM LoadSample
WINDOW W AS (
  ORDER BY sample_date ASC
  ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
);

-- 行ではなく「1日前」や「2日前」のように列の値に基づいたフレーム設定もできる
-- PostgreSQLではまだRANGEが実装されてない模様
-- なので、以下を実行すると「RANGE PRECEDING is only supported with UNBOUNDED」というエラーがでる
SELECT sample_date AS cur_date,
       load_val AS cur_load,
       MIN(sample_date) OVER W AS day1_before,
       MIN(load_val) OVER W AS load_day1_before
FROM LoadSample
WINDOW W AS (
  ORDER BY sample_date ASC
  RANGE BETWEEN interval '1' day PRECEDING AND interval '1' day PRECEDING
);

-- 行間比較の一般化
SELECT sample_date AS cur_date,
       MIN(sample_date) OVER (
         ORDER BY sample_date ASC
         ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
       ) AS latest_1,
       MIN(sample_date) OVER (
         ORDER BY sample_date ASC
         ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING
       ) AS latest_2,
       MIN(sample_date) OVER (
         ORDER BY sample_date ASC
         ROWS BETWEEN 3 PRECEDING AND 3 PRECEDING
       ) AS latest_3
FROM LoadSample;

DROP TABLE LoadSample;
