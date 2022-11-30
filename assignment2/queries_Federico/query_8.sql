WITH oscars AS (SELECT DISTINCT CAST(COUNT(aw.title) AS DECIMAL) AS won
                FROM movieawards AS aw
                WHERE aw.year BETWEEN 1980 AND 1989
                  AND aw.award LIKE '%Oscar%'
                  AND aw.result = 'won'),
     films AS (SELECT CAST(COUNT(title) AS DECIMAL) AS total
               FROM movies
               WHERE year BETWEEN 1980 AND 1989)
SELECT (CASE WHEN total = 0 THEN -1 ELSE ROUND(won / total, 2) END) AS feature
FROM oscars,
     films;