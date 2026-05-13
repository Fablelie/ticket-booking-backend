-- name: CreateOrder :one
INSERT INTO orders (user_id, event_id, ticket_id, total_amount, status)
VALUES ($1, $2, $3, $4, 'PENDING')
RETURNING id, user_id, event_id, ticket_id, total_amount, status, created_at;

-- name: UpdateOrderStatus :exec
UPDATE orders
SET status = $2, updated_at = CURRENT_TIMESTAMP
WHERE id = $1;
