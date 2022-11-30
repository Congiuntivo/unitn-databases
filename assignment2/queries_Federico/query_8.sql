WITH aw AS (SELECT DISTINCT title, year
            FROM movieawards
            WHERE award LIKE 'Oscar%'
              AND result = 'won'
              AND movieawards.year >= 1980
              AND movieawards.year < 1990),
     t AS (SELECT COUNT(year) AS total
           FROM movies
           WHERE year >= 1980
             AND year < 1990)
SELECT DISTINCT CASE
                    WHEN COUNT(year) = 0 THEN -1
                    ELSE ROUND(ROUND((SELECT COUNT(aw.year) FROM aw), 2) / (SELECT total FROM t), 2)
                    END AS feature
FROM aw;