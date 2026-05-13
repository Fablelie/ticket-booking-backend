# run.ps1
param (
    [string]$action = ""
)

$DB_URL = "postgres://myuser:mypassword@localhost:5433/ticket_booking?sslmode=disable"

switch ($action) {
    "migrate-order-up" {
        migrate -path services/order-service/db/migrations -database $DB_URL -verbose up
    }
    "migrate-order-down" {
        migrate -path services/order-service/db/migrations -database $DB_URL -verbose down
    }
    "migrate-inventory-up" {
        migrate -path services/inventory-service/db/migrations -database $DB_URL -verbose up
    }
    "migrate-inventory-down" {
        migrate -path services/inventory-service/db/migrations -database $DB_URL -verbose down
    }
    "gen" {
        sqlc generate
        Write-Host "SQLC Code Generated Successfully!" -ForegroundColor Green
    }
    default {
        Write-Host "Invalid action. Use: migrate-order-up, migrate-order-down, migrate-inventory-up, migrate-inventory-down, or gen" -ForegroundColor Red
    }
}
