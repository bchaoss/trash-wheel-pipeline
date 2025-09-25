SELECT 
  CONCAT(SUBSTRING(b.sheet_name, 1, 1), dumpster) AS dumpster_id
  , CASE WHEN CAST(date AS VARCHAR) LIKE '00%'
         THEN CAST(CONCAT('20', SUBSTRING(CAST(date AS VARCHAR), 3)) AS DATE)
    ELSE date END AS date
  , a.* EXCLUDE (dumpster, _month, _year, date, filename) 
from {{ ref('ingest_trash_wheel') }} a
  left join main.files_to_read b on a.filename=b.csv_link

