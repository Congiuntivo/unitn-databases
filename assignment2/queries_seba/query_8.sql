SELECT (CASE
            WHEN tot > 0
                THEN (CAST(CAST(won as float) / CAST(tot as float) as numeric(36, 2)))
            ELSE -1 END) as percentage
FROM (SELECT count(*)            as tot,
             sum(CASE
                     WHEN result = 'won'
                         AND award LIKE '%Oscar%' THEN 1
                     ELSE 0 END) as won
      FROM movieawards
      WHERE year IN (1980, 1989)) as tot;
