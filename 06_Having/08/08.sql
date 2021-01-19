CREATE TABLE Materials (
  center CHAR(12) NOT NULL,
  receive_date DATE NOT NULL,
  material CHAR(12) NOT NULL,
  PRIMARY KEY(center, receive_date)
);

INSERT INTO Materials
VALUES ('東京', '2018-4-01', '錫'),
       ('東京', '2018-4-12', '亜鉛'),
       ('東京', '2018-5-17', 'アルミニウム'),
       ('東京', '2018-5-20', '亜鉛'),
       ('大阪', '2018-4-20', '銅'),
       ('大阪', '2018-4-22', 'ニッケル'),
       ('大阪', '2018-4-29', '鉛'),
       ('名古屋', '2018-3-15', 'チタン'),
       ('名古屋', '2018-4-01', '炭素鋼'),
       ('名古屋', '2018-4-24', '炭素鋼'),
       ('名古屋', '2018-5-02', 'マグネシウム'),
       ('名古屋', '2018-5-10', 'チタン'),
       ('福岡', '2018-5-10', '亜鉛'),
       ('福岡', '2018-5-28', '錫');

-- 資材のダブっている拠点を選択する 1
SELECT center
FROM Materials
GROUP BY center
HAVING COUNT(material) <> COUNT(DISTINCT material);

-- 資材のダブっている拠点を選択する 2
SELECT center,
       CASE WHEN COUNT(material) <> COUNT(DISTINCT material)
            THEN 'ダブリ有り'
            ELSE 'ダブリ無し'
            END AS status
FROM Materials
GROUP BY center;

-- ダブリのある集合：EXISTSの利用
SELECT center, material
FROM Materials M1
WHERE EXISTS (
  SELECT * FROM Materials M2
  WHERE M1.center = M2.center
  AND M1.receive_date <> M2.receive_date
  AND M1.material = M2.material
);

DROP TABLE Materials;
