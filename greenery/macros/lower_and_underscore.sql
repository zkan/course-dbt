{% macro lower_and_underscore(column_name) %}

    replace(replace(lower({{ column_name }}), '-', '_'), ' ', '_')

{% endmacro %}