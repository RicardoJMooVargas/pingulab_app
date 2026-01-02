-- Migration: Add users table, update printers table, update quotes table
-- Date: 2026-01-01

-- Create user_role enum
CREATE TYPE user_role AS ENUM ('ADMIN', 'OPERADOR', 'VIEWER');

-- Create users table
CREATE TABLE users (
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

-- Add purchase_cost column to printers table
ALTER TABLE printers 
ADD COLUMN purchase_cost DOUBLE PRECISION NOT NULL DEFAULT 0.0;

-- Add new columns to quotes table
ALTER TABLE quotes
ADD COLUMN quantity INTEGER NOT NULL DEFAULT 1,
ADD COLUMN depreciation_cost DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN created_by INTEGER REFERENCES users(id),
ADD COLUMN updated_by INTEGER REFERENCES users(id);

-- Create index for user email lookups
CREATE INDEX idx_users_email ON users(email);

-- Create indexes for quote tracking
CREATE INDEX idx_quotes_created_by ON quotes(created_by);
CREATE INDEX idx_quotes_updated_by ON quotes(updated_by);

-- Create default admin user (password: admin123 - CHANGE THIS IN PRODUCTION!)
-- Password hash is SHA256 of 'admin123'
INSERT INTO users (email, password_hash, nombre, rol, activo, created)
VALUES (
    'admin@pingulab.com', 
    '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
    'Administrator',
    'ADMIN',
    TRUE,
    CURRENT_TIMESTAMP
);

-- Add comment for password
COMMENT ON COLUMN users.password_hash IS 'SHA256 hash of password';
COMMENT ON TABLE users IS 'User authentication and authorization';
COMMENT ON COLUMN quotes.depreciation_cost IS 'Printer depreciation cost based on usage';
COMMENT ON COLUMN quotes.quantity IS 'Number of pieces to produce';
COMMENT ON COLUMN quotes.created_by IS 'User ID who created the quote';
COMMENT ON COLUMN quotes.updated_by IS 'User ID who last updated the quote';
COMMENT ON COLUMN printers.purchase_cost IS 'Purchase cost of printer for depreciation calculation';
