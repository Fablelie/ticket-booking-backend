-- สร้าง ENUM สำหรับควบคุมสถานะการจอง
CREATE TYPE order_status AS ENUM ('PENDING', 'CONFIRMED', 'CANCELLED', 'FAILED');

CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,
    ticket_id BIGINT NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    status order_status NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- สร้าง Index สำหรับสืบค้นประวัติการจองของ User
CREATE INDEX idx_orders_user_id ON orders(user_id);
-- สร้าง Index สำหรับเช็คสถานะออเดอร์ที่ค้างคา (เช่น เคลียร์ออเดอร์ที่หมดเวลาจ่ายเงิน)
CREATE INDEX idx_orders_status ON orders(status);
