{% macro get_csv_list() %}
    -- Execute a query to get the list of links as a string array
    {% set query %}
        SELECT
            list(csv_link)
        FROM
            main.files_to_read
    {% endset %}

    {% set results = run_query(query) %}
    

    {% if execute and results %}
        -- Get the first column of the first row, which is the array string (e.g., ['file1.csv', 'file2.csv'])
        {% set csv_list_array_string = results.columns[0].values()[0] %}
        -- {{ log(csv_list_array_string, info=True) }}
        {{ return(csv_list_array_string) }}
    {% else %}
        -- Fallback for parsing/compilation
        {{ return("[]") }}
    {% endif %}
{% endmacro %}