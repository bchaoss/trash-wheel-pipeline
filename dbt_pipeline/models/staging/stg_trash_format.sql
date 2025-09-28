SELECT 
  dumpster
  , b.wheel_id AS wheel_id
  , CASE 
      WHEN CAST(date AS VARCHAR) LIKE '00%' THEN CAST(CONCAT('20', SUBSTRING(CAST(date AS VARCHAR), 3)) AS DATE)
    ELSE date END AS date
  , weight_tons AS weight
  , volume_cubic_yards AS volume
  , a.* EXCLUDE (filename, _month, _year, dumpster, date, weight_tons, volume_cubic_yards)
FROM 
  {{ ref('ingest_trash_wheel') }} a
LEFT JOIN 
  {{ ref('config_trash_wheel') }} b
  ON a.filename = b.source_csv_link
