CREATE TABLE Personnel (
  employee varchar(32), 
  child_1 varchar(32), 
  child_2 varchar(32), 
  child_3 varchar(32), 
  PRIMARY KEY(employee)
);

INSERT INTO Personnel
VALUES ('赤井', '一郎', '二郎', '三郎'),
       ('工藤', '春子', '夏子', NULL),
       ('鈴木', '夏子', NULL,   NULL),
       ('吉田', NULL,   NULL,   NULL);

-- 列から行への変換：UNION ALLの利用
SELECT employee, child_1 AS child FROM Personnel
UNION ALL
SELECT employee, child_2 AS child FROM Personnel
UNION ALL
SELECT employee, child_3 AS child FROM Personnel;

-- 子供の一覧を保持するビュー（子供マスタ）
CREATE VIEW Children(child)
AS
SELECT child_1 FROM Personnel
UNION
SELECT child_2 FROM Personnel
UNION
SELECT child_3 FROM Personnel;

-- 子供マスタ確認
SELECT * FROM Children;

-- 社員の子どもリストを得るSQL（子供のいない社員も出力する）
SELECT EMP.employee, Children.child
FROM Personnel EMP
LEFT OUTER JOIN Children ON Children.child IN (
  EMP.child_1, EMP.child_2, EMP.child_3
);

DROP VIEW Children;
DROP TABLE Personnel;
