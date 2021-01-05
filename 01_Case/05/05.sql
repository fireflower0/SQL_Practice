CREATE TABLE Personnel (
  name text,
  salary integer
);

INSERT INTO Personnel
VALUES ('相田', 300000),
       ('神埼', 270000),
       ('木村', 220000),
       ('斉藤', 290000);

SELECT * FROM Personnel FOR UPDATE;

UPDATE Personnel
SET salary = CASE WHEN salary >= 300000 THEN salary * 0.9
                  WHEN salary >= 250000 AND salary < 280000 THEN salary * 1.2
                  ELSE salary END;

SELECT * FROM Personnel;

DROP TABLE Personnel;
