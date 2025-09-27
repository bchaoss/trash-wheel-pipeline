{% set numeric_cols_to_cast = [
    'weight',
    'volume',
    'plastic_bottles',
    'polystyrene',
    'cigarette_butts',
    'glass_bottles',
    'plastic_bags',
    'wrappers',
    'sports_balls',
    'homes_powered'
] %}

SELECT
    dumpster_id
    , wheel_id
    , date
    {% for col in numeric_cols_to_cast %}
    , CAST(REPLACE(REPLACE({{ col }}, ' ', ''), ',', '') AS DECIMAL) AS {{ col }}
    {% if not loop.last %}, {% endif %}
    {% endfor %}
FROM
    {{ ref('stg_trash_unique') }}
