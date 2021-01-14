CREATE TABLE Addresses (
  name VARCHAR(32),
  family_id INTEGER,
  address VARCHAR(32),
  PRIMARY KEY(name, family_id)
);

INSERT INTO Addresses
VALUES('前田 義明', '100', '東京都港区虎ノ門3-2-29'),
      ('前田 由美', '100', '東京都港区虎ノ門3-2-92'),
      ('加藤 茶', '200', '東京都新宿区西新宿2-8-1'),
      ('加藤 勝', '200', '東京都新宿区西新宿2-8-1'),
      ('ホームズ', '300', 'ベーカー街221B'),
      ('ワトソン', '400', 'ベーカー街221B');

-- 同じ家族だけど、住所が違うレコードを検索するSQL
SELECT DISTINCT A1.name, A1.address
FROM Addresses A1
INNER JOIN Addresses A2
ON A1.family_id = A2.family_id
AND A1.address <> A2.address;

DROP TABLE Addresses;
