SELECT DISTINCT title,
                year,
                (CASE
                     WHEN tot = 0 THEN -1
                     ELSE ROUND(won / tot, 2) END) as "success-rate"
FROM (SELECT m.title,
             m.year,
             cast(sum(CASE WHEN result = 'won' THEN 1 ELSE 0 END) as DECIMAL)     as won,
             cast(sum(CASE WHEN result IS NOT NULL THEN 1 ELSE 0 END) as DECIMAL) as tot
      FROM movieawards a
               RIGHT OUTER JOIN movies m on a.title = m.title and a.year = m.year
      GROUP BY m.title, m.year) as tmp;




