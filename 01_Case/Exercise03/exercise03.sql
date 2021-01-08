CREATE TABLE Greatests (
  key VARCHAR(1) PRIMARY KEY,
  x INTEGER,
  y INTEGER,
  z INTEGER
);

INSERT INTO Greatests
VALUES ('A', 1, 2, 3),
       ('B', 5, 5, 2),
       ('C', 4, 7, 1),
       ('D', 3, 3, 8);

SELECT key FROM Greatests ORDER BY key;

SELECT key
FROM Greatests
ORDER BY (
  CASE WHEN key = 'B' THEN key ELSE NULL END,
  CASE WHEN key = 'A' THEN key ELSE NULL END,
  CASE WHEN key = 'D' THEN key ELSE NULL END,
  CASE WHEN key = 'C' THEN key ELSE NULL END
);

DROP TABLE Greatests;
