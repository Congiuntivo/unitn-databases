(SELECT DISTINCT title,
                 year,
                 (CASE
                      WHEN won = 0 THEN 0.00
                      WHEN won = tot THEN 1.00
                      ELSE CAST(won / tot as numeric(36, 2)) END) as "success-rate"
 FROM (SELECT title,
              year,
              cast(sum(CASE WHEN result = 'won' THEN 1 ELSE 0 END) as float) as won,
              cast(count(*) as float)                                        as tot
       FROM movieawards
       GROUP BY title, year) as tmp)
UNION
(SELECT DISTINCT title, year, -1.0
 FROM movies
 WHERE (title, year) NOT IN (SELECT title, year FROM movieawards));


