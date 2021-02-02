CREATE TABLE Tbl_A (
  keycol CHAR(1) PRIMARY KEY,
  col_1 INTEGER , 
  col_2 INTEGER, 
  col_3 INTEGER
);

CREATE TABLE Tbl_B (
  keycol CHAR(1) PRIMARY KEY,
  col_1 INTEGER, 
  col_2 INTEGER, 
  col_3 INTEGER
);

-- ##################################################
-- ### 等しいテーブル同士のケース
INSERT INTO Tbl_A
VALUES ('A', 2, 3, 4), ('B', 0, 7, 9), ('C', 5, 1, 6);

INSERT INTO Tbl_B
VALUES ('A', 2, 3, 4), ('B', 0, 7, 9), ('C', 5, 1, 6);

-- クエリ結果が Tbl_A と Tbl_B 行数と一致すれば、両者は等しいテーブル
SELECT COUNT(*) AS row_cnt
FROM (
  SELECT * FROM Tbl_A UNION SELECT * FROM Tbl_B
) TMP;

-- ##################################################
-- ###「B」の行が相違するケース
DELETE FROM Tbl_A;
INSERT INTO Tbl_A
VALUES ('A', 2, 3, 4), ('B', 0, 7, 9), ('C', 5, 1, 6);

DELETE FROM Tbl_B;
INSERT INTO Tbl_B
VALUES('A', 2, 3, 4), ('B', 0, 7, 8), ('C', 5, 1, 6);

-- クエリ結果が Tbl_A と Tbl_B 行数と一致すれば、両者は等しいテーブル
SELECT COUNT(*) AS row_cnt
FROM (
  SELECT * FROM Tbl_A UNION SELECT * FROM Tbl_B
) TMP;

-- ##################################################
-- ### NULLを含むケース（等しい）
DELETE FROM Tbl_A;
INSERT INTO Tbl_A
VALUES ('A', NULL, 3, 4), ('B', 0, 7, 9), ('C', NULL, NULL, NULL);

DELETE FROM Tbl_B;
INSERT INTO Tbl_B
VALUES ('A', NULL, 3, 4), ('B', 0, 7, 9), ('C', NULL, NULL, NULL);

-- クエリ結果が Tbl_A と Tbl_B 行数と一致すれば、両者は等しいテーブル
SELECT COUNT(*) AS row_cnt
FROM (
  SELECT * FROM Tbl_A UNION SELECT * FROM Tbl_B
) TMP;

-- ##################################################
-- ### NULLを含むケース（「C」の行が異なる）
DELETE FROM Tbl_A;
INSERT INTO Tbl_A
VALUES ('A', NULL, 3, 4), ('B', 0, 7, 9), ('C', NULL, NULL, NULL);

DELETE FROM Tbl_B;
INSERT INTO Tbl_B
VALUES ('A', NULL, 3, 4), ('B', 0, 7, 9), ('C', 0, NULL, NULL);

-- クエリ結果が Tbl_A と Tbl_B 行数と一致すれば、両者は等しいテーブル
SELECT COUNT(*) AS row_cnt
FROM (
  SELECT * FROM Tbl_A UNION SELECT * FROM Tbl_B
) TMP;

DROP TABLE Tbl_A;
DROP TABLE Tbl_B;
