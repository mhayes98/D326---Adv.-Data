INSERT INTO summary (
    SELECT 
        staff_id,
        staff_name,
        to_char(current_date, 'MM-YYYY')::TEXT,
        COUNT(*),
        SUM(rental_rate)
    FROM
        detailed
    GROUP BY
        staff_id
)
