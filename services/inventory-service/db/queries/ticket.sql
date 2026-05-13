-- name: GetAvailableTicketForUpdate :one
SELECT id, event_id, seat_number, price, status
FROM tickets
WHERE event_id = $1 AND status = 'AVAILABLE'
LIMIT 1
FOR UPDATE NOWAIT;

-- name: UpdateTicketStatus :exec
UPDATE tickets
SET status = $2, reserved_by = $3, updated_at = CURRENT_TIMESTAMP
WHERE id = $1;
