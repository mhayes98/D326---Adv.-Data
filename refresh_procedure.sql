CREATE PROCEDURE refresh_tables()
    TRUNCATE TABLE detailed, summary

    INSERT INTO detailed (
    SELECT
        rental.staff_id as staff_id, 
        get_staff_full_name(staff.first_name, staff.last_name) as full_name,
        film.film_id as film_id,
        film.title as film_title,
        timestamp_to_date_conversion(rental.rental_date) as rental_date,
        timestamp_to_date_conversion(rental.return_date) as return_date, 
        calculate_rental_length(rental.return_date, rental.rental_date) as rental_length,
        film.rental_rate as rental_rate
    FROM
        rental
    INNER JOIN
        inventory ON rental.inventory_id = inventory.inventory_id
    INNER JOIN
        film ON inventory.film_id = film.film_id
    INNER JOIN
        staff ON rental.staff_id = staff.staff_id
    WHERE
        -- 6 = EXTRACT(MONTH FROM rental.rental_date)
        EXTRACT(MONTH FROM current_timestamp) = EXTRACT(MONTH FROM rental.rental_date)
    ORDER BY
        rental_date, film_title, staff_id
);