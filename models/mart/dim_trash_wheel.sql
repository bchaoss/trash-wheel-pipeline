SELECT
  SUBSTRING(trash_wheel_name, 1, 1) AS wheel_id
  , *
FROM {{ ref('trash_wheel_info') }}
