CREATE TABLE Teams (
  member CHAR(12) NOT NULL PRIMARY KEY,
  team_id INTEGER  NOT NULL,
  status CHAR(8)  NOT NULL
);

INSERT INTO Teams
VALUES ('ジョー', 1, '待機'),
       ('ケン', 1, '出動中'),
       ('ミック', 1, '待機'),
       ('カレン', 2, '出動中'),
       ('キース', 2, '休暇'),
       ('ジャン', 3, '待機'),
       ('ハート', 3, '待機'),
       ('ディック', 3, '待機'),
       ('ベス', 4, '待機'),
       ('アレン', 5, '出動中'),
       ('ロバート', 5, '休暇'),
       ('ケーガン', 5, '待機');

-- 全称文を述語で表現する
SELECT team_id, member
FROM Teams T1
WHERE NOT EXISTS(
  SELECT * FROM Teams T2
  WHERE T1.team_id = T2.team_id
  AND status <> '待機'
);

-- 全称文を述語で表現する：その1
SELECT team_id
FROM Teams
GROUP BY team_id
HAVING COUNT(*) = SUM(
  CASE WHEN status = '待機' THEN 1 ELSE 0 END
);

-- 全称文を述語で表現する：その2
SELECT team_id
FROM Teams
GROUP BY team_id
HAVING MAX(status) = '待機' AND MIN(status) = '待機';

-- 総員スタンバイかどうかをチームごとに一覧表示
SELECT team_id,
       CASE WHEN MAX(status) = '待機' AND MIN(status) = '待機'
            THEN '総員スタンバイ'
            ELSE '隊長！メンバーが足りません'
            END AS status
FROM Teams
GROUP BY team_id;

DROP TABLE Teams;
