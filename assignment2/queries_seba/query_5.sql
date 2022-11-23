(SELECT DISTINCT title,
                 CAST(won / tot as numeric(36, 2)) as "success-rate"
 FROM (SELECT title,
              cast(sum(CASE WHEN result = 'won' THEN 1 ELSE 0 END) as float) as won,
              cast(count(*) as float)                                        as tot
       FROM movieawards
       GROUP BY title, year) as tmp)
 UNION
 (SELECT DISTINCT title, -1.0
  FROM movies
  WHERE (title, year) NOT IN (SELECT title, year FROM movieawards));


