-- Migration Script: Add authentication and new fields
-- This script UPDATES your existing database without losing data

BEGIN;

-- ============================
-- 1. CREATE USER SYSTEM
-- ============================

-- Create user_role enum if not exists
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('ADMIN', 'OPERADOR', 'VIEWER');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Create users table if not exists
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255),
    rol user_role NOT NULL DEFAULT 'OPERADOR',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP
);

-- Create index if not exists
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Insert default users (only if they don't exist)
INSERT INTO users (email, password_hash, nombre, apellido, rol, activo, created)
VALUES 
    ('admin@pingulab.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Administrator', NULL, 'ADMIN', TRUE, NOW()),
    ('operador@pingulab.com', '6ca8a22e2505b0f287869f82fb146d30b98e37c1bdb30ad8d9e97dea2de55936', 'Operador', 'Principal', 'OPERADOR', TRUE, NOW()),
    ('viewer@pingulab.com', '2c2da6f8f7ef82fd0c32b57a6f09c5d8cc0a6908b0cfe5b5d97dfa96c09f27e4', 'Visualizador', 'Test', 'VIEWER', TRUE, NOW())
ON CONFLICT (email) DO NOTHING;

-- ============================
-- 2. UPDATE PRINTERS TABLE
-- ============================

-- Add purchase_cost column if it doesn't exist
DO $$ BEGIN
    ALTER TABLE printers ADD COLUMN purchase_cost DOUBLE PRECISION NOT NULL DEFAULT 0.0;
EXCEPTION
    WHEN duplicate_column THEN null;
END $$;

-- Update existing printers with purchase costs (based on your data)
UPDATE printers SET purchase_cost = 5549.00 WHERE name LIKE '%A1 Mini%' AND purchase_cost = 0;
UPDATE printers SET purchase_cost = 12000.00 WHERE name LIKE '%Bambu Lab A1%' AND name NOT LIKE '%Mini%' AND purchase_cost = 0;

-- ============================
-- 3. UPDATE QUOTES TABLE
-- ============================

-- Add new columns to quotes table
DO $$ BEGIN
    ALTER TABLE quotes ADD COLUMN quantity INTEGER NOT NULL DEFAULT 1;
EXCEPTION
    WHEN duplicate_column THEN null;
END $$;

DO $$ BEGIN
    ALTER TABLE quotes ADD COLUMN depreciation_cost DOUBLE PRECISION NOT NULL DEFAULT 0.0;
EXCEPTION
    WHEN duplicate_column THEN null;
END $$;

DO $$ BEGIN
    ALTER TABLE quotes ADD COLUMN created_by INTEGER REFERENCES users(id);
EXCEPTION
    WHEN duplicate_column THEN null;
END $$;

DO $$ BEGIN
    ALTER TABLE quotes ADD COLUMN updated_by INTEGER REFERENCES users(id);
EXCEPTION
    WHEN duplicate_column THEN null;
END $$;

-- Create indexes for quote tracking
CREATE INDEX IF NOT EXISTS idx_quotes_created_by ON quotes(created_by);
CREATE INDEX IF NOT EXISTS idx_quotes_updated_by ON quotes(updated_by);

-- Update existing quotes to have admin as creator (first user)
DO $$
DECLARE
    admin_user_id INTEGER;
BEGIN
    SELECT id INTO admin_user_id FROM users WHERE email = 'admin@pingulab.com' LIMIT 1;
    
    IF admin_user_id IS NOT NULL THEN
        UPDATE quotes 
        SET created_by = admin_user_id 
        WHERE created_by IS NULL;
    END IF;
END $$;

-- ============================
-- 4. SUMMARY
-- ============================

SELECT '✅ Migration completed successfully!' as status;
SELECT 
    (SELECT COUNT(*) FROM users) as users_count,
    (SELECT COUNT(*) FROM printers) as printers_count,
    (SELECT COUNT(*) FROM filaments) as filaments_count,
    (SELECT COUNT(*) FROM extra_supplies) as supplies_count,
    (SELECT COUNT(*) FROM customers) as customers_count,
    (SELECT COUNT(*) FROM quotes) as quotes_count;

-- Verify new columns
SELECT 
    column_name, 
    data_type 
FROM information_schema.columns 
WHERE table_name = 'quotes' 
    AND column_name IN ('quantity', 'depreciation_cost', 'created_by', 'updated_by')
ORDER BY column_name;

SELECT 
    column_name, 
    data_type 
FROM information_schema.columns 
WHERE table_name = 'printers' 
    AND column_name = 'purchase_cost';

COMMIT;

-- Show sample data
SELECT 'Users:' as info;
SELECT id, email, nombre, rol, activo FROM users;

SELECT 'Printers with purchase cost:' as info;
SELECT id, name, power_consumption_watts, purchase_cost, available FROM printers;

SELECT 'Quotes with new fields:' as info;
SELECT id, name, quantity, depreciation_cost, created_by FROM quotes LIMIT 5;
