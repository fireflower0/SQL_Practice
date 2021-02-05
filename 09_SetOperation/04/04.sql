CREATE TABLE SupParts (
  sup CHAR(32) NOT NULL,
  part CHAR(32) NOT NULL,
  PRIMARY KEY(sup, part)
);

INSERT INTO SupParts
VALUES ('A', 'ボルト'), ('A', 'ナット'), ('A', 'パイプ'),
       ('B', 'ボルト'), ('B', 'パイプ'),
       ('C', 'ボルト'), ('C', 'ナット'), ('C', 'パイプ'),
       ('D', 'ボルト'), ('D', 'パイプ'),
       ('E', 'ヒューズ'), ('E', 'ナット'), ('E', 'パイプ'),
       ('F', 'ヒューズ');

-- 業者の組み合わせを作る
SELECT SP1.sup AS s1, SP2.sup AS s2
FROM SupParts SP1, SupParts SP2
WHERE SP1.sup < SP2.sup
GROUP BY SP1.sup, SP2.sup;

SELECT SP1.sup AS s1, SP2.sup AS s2
FROM SupParts SP1, SupParts SP2
WHERE SP1.sup < SP2.sup  -- 業者の組み合わせを作る
AND SP1.part = SP2.part -- 条件1：同じ種類の部品を扱う
GROUP BY SP1.sup, SP2.sup
HAVING COUNT(*) = (
  -- 条件2：同数の部品を扱う
  SELECT COUNT(*) FROM SupParts SP3 WHERE SP3.sup = SP1.sup
) AND COUNT(*) = (
  SELECT COUNT(*) FROM SupParts SP4 WHERE SP4.sup = SP2.sup
);

DROP TABLE SupParts;
