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

SELECT key,
       CASE WHEN x > y
            THEN x
            ELSE y
            END AS greatest
FROM Greatests;

SELECT key,
       CASE WHEN x > y
            THEN ( CASE WHEN x > z THEN x ELSE z END )
            ELSE ( CASE WHEN y > z THEN y ELSE z END )
            END AS greatest
FROM Greatests;

DROP TABLE Greatests;
