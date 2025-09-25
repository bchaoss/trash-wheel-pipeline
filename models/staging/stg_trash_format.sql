SELECT 
  CONCAT(SUBSTRING(b.sheet_name, 1, 1), dumpster) AS dumpster_id
  , CASE WHEN CAST(date AS VARCHAR) LIKE '00%'
         THEN CAST(CONCAT('20', SUBSTRING(CAST(date AS VARCHAR), 3)) AS DATE)
    ELSE date END AS date
  , weight_tons AS weight
  , volume_cubic_yards AS volume
  , a.* EXCLUDE (dumpster, filename, _month, _year, date, weight_tons, volume_cubic_yards)
from {{ ref('ingest_trash_wheel') }} a
  left join main.files_to_read b on a.filename=b.csv_link
