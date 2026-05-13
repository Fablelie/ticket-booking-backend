-- สร้าง ENUM สำหรับควบคุมสถานะตั๋วอย่างเข้มงวด
CREATE TYPE ticket_status AS ENUM ('AVAILABLE', 'HOLD', 'SOLD');

CREATE TABLE tickets (
    id BIGSERIAL PRIMARY KEY,
    event_id BIGINT NOT NULL,
    seat_number VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    status ticket_status NOT NULL DEFAULT 'AVAILABLE',
    version INT NOT NULL DEFAULT 1, -- สำหรับทำ Optimistic Locking (ถ้าต้องการใช้ควบคู่)
    reserved_by BIGINT,             -- เก็บ User ID ที่จองชั่วคราว
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- สร้าง Composite Index เพื่อให้ค้นหาตั๋วที่ยังว่างของคอนเสิร์ตนั้นๆ ได้เร็วที่สุด
CREATE INDEX idx_tickets_event_status ON tickets(event_id, status);

-- สร้าง Unique Constraint ป้องกันที่นั่งซ้ำในคอนเสิร์ตเดียวกัน
ALTER TABLE tickets ADD CONSTRAINT unique_event_seat UNIQUE (event_id, seat_number);
