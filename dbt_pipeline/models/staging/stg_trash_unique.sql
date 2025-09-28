SELECT 
  -- CONCAT(wheel_id, dumpster) AS dumpster_id
  CONCAT(
    wheel_id,
    CASE
      WHEN wheel_id = 'G' THEN ROW_NUMBER() OVER (PARTITION BY wheel_id ORDER BY date)
      ELSE dumpster
    END
    ) AS dumpster_id  
  , * EXCLUDE (dumpster)
FROM 
  {{ ref('stg_trash_format') }}