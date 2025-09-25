SELECT 
  * EXCLUDE (homes_powered)
  , (CAST(weight AS DECIMAL) * 500 / 30) AS homes_powered
FROM 
  {{ ref('stg_trash_type') }} 

