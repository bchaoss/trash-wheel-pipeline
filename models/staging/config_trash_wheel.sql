SELECT
  SUBSTRING(trash_wheel_name, 1, 1) AS wheel_id
  , trash_wheel_name
  , full_name
  , source_google_sheet_id
  , '{{ var('source_google_sheet_link') }}' || '/export?format=csv&gid=' || source_google_sheet_id AS source_csv_link
FROM
  {{ ref('trash_wheel_info') }}
