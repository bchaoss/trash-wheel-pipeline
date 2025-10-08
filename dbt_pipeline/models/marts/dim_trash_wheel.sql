SELECT
  wheel_id
  , trash_wheel_name
  , full_name
FROM
  {{ ref('config_trash_wheel') }}
