SELECT DISTINCT title,
                year,
                (CASE
                     WHEN tot = 0.00 THEN -1
                     ELSE ROUND(won / tot, 2) END) AS "success-rate"
FROM (SELECT m.title,
             m.year,
             CAST(SUM(CASE WHEN result = 'won' THEN 1 ELSE 0 END) AS DECIMAL)     AS won,
             CAST(SUM(CASE WHEN result IS NOT NULL THEN 1 ELSE 0 END) AS DECIMAL) AS tot
      FROM movieawards AS aw
               RIGHT OUTER JOIN movies AS m ON aw.title = m.title AND aw.year = m.year
      GROUP BY m.title, m.year) AS tmp;
