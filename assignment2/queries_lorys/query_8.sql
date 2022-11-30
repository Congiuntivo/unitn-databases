WITH anni_80 AS
             (SELECT title, year FROM movies WHERE year >= 1980 AND year < 1990),
     n_anni_80 AS
             (SELECT count(title) as c FROM movies WHERE year >= 1980 AND year < 1990),
     vinti_80 AS
         (SELECT DISTINCT m.title, m.year
          FROM movieawards m
                   JOIN anni_80 m1 ON m.title = m1.title AND m.year = m1.year
          WHERE award LIKE 'Oscar%'
            AND result = 'won'),
     n_vinti_80 AS
         (SELECT count(*) as c1
          FROM vinti_80),
     unified AS
         (SELECT c, c1
          FROM n_anni_80
                   CROSS JOIN n_vinti_80)
SELECT CASE
           WHEN c isnull THEN -1
           ELSE round(c1 / c::numeric, 2)
           END as feature
FROM unified;