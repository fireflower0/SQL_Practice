CREATE TABLE Items (
  item_no INTEGER PRIMARY KEY,
  item VARCHAR(32) NOT NULL
);

INSERT INTO Items
VALUES (10, 'FD'),
       (20, 'CD-R'),
       (30, 'MO'),
       (40, 'DVD');

CREATE TABLE SalesHistory (
  sale_date DATE NOT NULL,
  item_no INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  PRIMARY KEY(sale_date, item_no)
);

INSERT INTO SalesHistory
VALUES ('2018-10-01', 10, 4),
       ('2018-10-01', 20, 10),
       ('2018-10-01', 30, 3),
       ('2018-10-03', 10, 32),
       ('2018-10-03', 30, 12),
       ('2018-10-04', 20, 22),
       ('2018-10-04', 30, 7);

-- 答え：その1 結合の前に集約することで、一対一の関係を作る
SELECT I.item_no, SH.total_qty
FROM Items I
LEFT OUTER JOIN (
  SELECT item_no, SUM(quantity) AS total_qty
  FROM SalesHistory
  GROUP BY item_no
) SH
ON I.item_no = SH.item_no;

-- 答え：その2 集約の前に1対多の結合を行なう
SELECT I.item_no, SUM(SH.quantity) AS total_qty
FROM Items I
LEFT OUTER JOIN SalesHistory SH ON I.item_no = SH.item_no -- 一対多の結合
GROUP BY I.item_no;

DROP TABLE Items;
