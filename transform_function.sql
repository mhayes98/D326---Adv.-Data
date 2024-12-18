CREATE FUNCTION timestamp_to_date_conversion(full_timestamp TIMESTAMP)
    RETURNS VARCHAR(10) AS $$
        SELECT to_char(full_timestamp::date, 'MM-DD-YYYY')::TEXT
    $$ LANGUAGE sql;


CREATE FUNCTION calculate_rental_length(return_date TIMESTAMP, rental_date TIMESTAMP)
    RETURNS VARCHAR(3) AS $$
        SELECT CONCAT((return_date::date - rental_date::date)::TEXT, 'd')
    $$ LANGUAGE sql;

CREATE FUNCTION get_staff_full_name(first_name TEXT, last_name TEXT)
    RETURNS VARCHAR(25) AS $$
        SELECT CONCAT(first_name, ' ', last_name)::TEXT
    $$ LANGUAGE sql;