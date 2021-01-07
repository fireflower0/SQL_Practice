CREATE TABLE StudentClub (
  std_id  INTEGER,
  club_id INTEGER,
  club_name VARCHAR(32),
  main_club_flg CHAR(1),
  PRIMARY KEY (std_id, club_id)
);

INSERT INTO StudentClub
VALUES (100, 1, '野球', 'Y'),
       (100, 2, '吹奏楽', 'N'),
       (200, 2, '吹奏楽', 'N'),
       (200, 3, 'バドミントン', 'Y'),
       (200, 4, 'サッカー', 'N'),
       (300, 4, 'サッカー', 'N'),
       (400, 5, '水泳', 'N'),
       (500, 6, '囲碁', 'N');

-- 条件1：1つのクラブに専念している学生を選択
SELECT std_id, MAX(club_id) AS main_club
FROM StudentClub
GROUP BY std_id
HAVING COUNT(*) = 1;

-- 条件2：クラブをかけ持ちしている学生を選択
SELECT std_id, club_id AS main_club
FROM StudentClub
WHERE main_club_flg = 'Y';

-- CASE式を使う
SELECT std_id,
       CASE WHEN COUNT(*) = 1 -- 1つのクラブに専念する学生の場合
            THEN MAX(club_id)
            ELSE MAX(
              CASE WHEN main_club_flg = 'Y'
                   THEN club_id
                   ELSE NULL END
            )
            END AS main_club
FROM StudentClub
GROUP BY std_id;

DROP TABLE StudentClub;
