SELECT (CASE
            WHEN tot > 0
                THEN ROUND(won / tot, 2)
            ELSE -1 END) as percentage
FROM (SELECT CAST(COUNT(*) as DECIMAL) as won
      FROM movieawards
      WHERE year IN (1980, 1989)
        AND result = 'won'
        AND award LIKE '%Oscar%') as tmp1,
     (SELECT CAST(COUNT(*) as DECIMAL) as tot
      FROM movies
      WHERE year IN (1980, 1989)) as temp2;
