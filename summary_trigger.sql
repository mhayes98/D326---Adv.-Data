CREATE TRIGGER summary_trigger
     AFTER INSERT ON detailed
     FOR EACH ROW
     EXECUTE FUNCTION update_summary_table(NEW);

