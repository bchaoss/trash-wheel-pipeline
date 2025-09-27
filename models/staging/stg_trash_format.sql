SELECT 
  CONCAT(b.wheel_id, dumpster) AS dumpster_id
  , b.wheel_id
  , CASE 
      WHEN CAST(date AS VARCHAR) LIKE '00%' THEN CAST(CONCAT('20', SUBSTRING(CAST(date AS VARCHAR), 3)) AS DATE)
    ELSE date END AS date
  , weight_tons AS weight
  , volume_cubic_yards AS volume
  , a.* EXCLUDE (dumpster, filename, _month, _year, date, weight_tons, volume_cubic_yards)
FROM 
  {{ ref('ingest_trash_wheel') }} a
LEFT JOIN 
  {{ ref('config_trash_wheel') }} b
  ON a.filename = b.source_csv_link
