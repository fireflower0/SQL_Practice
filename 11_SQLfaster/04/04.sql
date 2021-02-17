CREATE TABLE Items (
  item_no INTEGER PRIMARY KEY,
  item VARCHAR(32) NOT NULL
);

INSERT INTO Items
VALUES (10, 'SDカード'),
       (20, 'CD-R'),
       (30, 'USBメモリ'),
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

-- これは全表検索が必要
SELECT MAX(item) FROM Items;

-- これはインデックスを利用できる
SELECT MAX(item_no) FROM Items;

DROP TABLE Items;
DROP TABLE SalesHistory;
