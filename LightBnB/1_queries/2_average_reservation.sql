-- calculate average reseravation
SELECT
  AVG(end_date - start_date) as average_duration
FROM reservations;