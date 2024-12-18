CREATE FUNCTION update_summary_table()
    RETURNS trigger AS $$
    BEGIN
        IF EXISTS (SELECT 1 FROM summary WHERE staff_id = NEW.staff_id) THEN
            UPDATE summary  
            SET
                total_rentals = total_rentals + 1,
                total_rental_rate = total_rental_rate + NEW.rental_rate
            WHERE
                staff_id = NEW.staff_id;
            ELSE
                INSERT INTO summary (staff_id, staff_name, month, total_rentals, total_rental_rate)
                VALUES (NEW.staff_id, NEW.staff_name, to_char(current_date, 'MM-YYYY')::TEXT, 1, NEW.rental_rate);
        END IF;
        RETURN NULL;
    END    
    $$ LANGUAGE plpgsql;
