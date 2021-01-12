CREATE TABLE ServerLoadSample (
  server CHAR(1) NOT NULL,
  sample_date DATE NOT NULL,
  load_val INTEGER NOT NULL
);

INSERT INTO ServerLoadSample
VALUES ('A', '2018-02-01', 1024),
       ('A', '2018-02-02', 2366),
       ('A', '2018-02-05', 2366),
       ('A', '2018-02-07', 985),
       ('A', '2018-02-08', 780),
       ('A', '2018-02-12', 1000),
       ('B', '2018-02-01', 54),
       ('B', '2018-02-02', 39008),
       ('B', '2018-02-03', 2900),
       ('B', '2018-02-04', 556),
       ('B', '2018-02-05', 12600),
       ('B', '2018-02-06', 7309),
       ('C', '2018-02-01', 1000),
       ('C', '2018-02-07', 2000),
       ('C', '2018-02-16', 500);

SELECT server, sample_date,
       SUM(load_val) OVER (
         PARTITION BY server
       ) AS sum_load
FROM ServerLoadSample;

DROP TABLE ServerLoadSample;
