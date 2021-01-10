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

-- 過去の直近の日付
SELECT sample_date AS cur_date,
       MIN(sample_date) OVER (
         ORDER BY sample_date ASC
         ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
       ) AS latest_date
FROM LoadSample;

-- 無名ウィンドウ構文
SELECT sample_date AS cur_date,
       load_val AS cur_load,
       MIN(sample_date) OVER (
         ORDER BY sample_date ASC
         ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
       ) AS latest_date,
       MIN(load_val) OVER (
         ORDER BY sample_date ASC
         ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
       ) AS latest_load
FROM LoadSample;

-- 名前付きウィンドウ構文
SELECT sample_date AS cur_date,
       load_val AS cur_load,
       MIN(sample_date) OVER W AS latest_date,
       MIN(load_val) OVER W AS latest_load
FROM LoadSample
WINDOW W AS (
  ORDER BY sample_date ASC
  ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
);

DROP TABLE LoadSample;
