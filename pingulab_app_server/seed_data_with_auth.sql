-- Seed Data with Authentication
-- This script adds initial data including admin user

-- ============================
-- USERS (Authentication)
-- ============================

-- Insert admin user (password: admin123)
-- Password hash is SHA256 of 'admin123'
INSERT INTO users (email, password_hash, nombre, apellido, rol, activo, created)
VALUES (
    'admin@pingulab.com',
    '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
    'Administrator',
    NULL,
    'ADMIN',
    TRUE,
    NOW()
) ON CONFLICT (email) DO NOTHING;

-- Insert operator user (password: operator123)
-- Password hash is SHA256 of 'operator123'
INSERT INTO users (email, password_hash, nombre, apellido, rol, activo, created)
VALUES (
    'operador@pingulab.com',
    '6ca8a22e2505b0f287869f82fb146d30b98e37c1bdb30ad8d9e97dea2de55936',
    'Operador',
    'Principal',
    'OPERADOR',
    TRUE,
    NOW()
) ON CONFLICT (email) DO NOTHING;

-- Insert viewer user (password: viewer123)
-- Password hash is SHA256 of 'viewer123'
INSERT INTO users (email, password_hash, nombre, apellido, rol, activo, created)
VALUES (
    'viewer@pingulab.com',
    '2c2da6f8f7ef82fd0c32b57a6f09c5d8cc0a6908b0cfe5b5d97dfa96c09f27e4',
    'Visualizador',
    'Test',
    'VIEWER',
    TRUE,
    NOW()
) ON CONFLICT (email) DO NOTHING;

-- ============================
-- ELECTRICITY RATES
-- ============================

INSERT INTO electricity_rates (cost_per_kwh, active) VALUES
(0.15, TRUE)
ON CONFLICT DO NOTHING;

-- ============================
-- PRINTERS
-- ============================

-- Updated with purchase costs
INSERT INTO printers (name, power_consumption_watts, purchase_cost, available) VALUES
('Creality Ender 3 V2', 220, 250.00, TRUE),
('Prusa i3 MK3S+', 120, 999.00, TRUE),
('Artillery Sidewinder X2', 350, 399.00, TRUE),
('Anycubic Kobra Max', 400, 499.00, FALSE)
ON CONFLICT DO NOTHING;

-- ============================
-- FILAMENTS
-- ============================

INSERT INTO filaments (name, brand, material_type, spool_weight_kg, spool_cost) VALUES
('PLA Blanco 1kg', 'Creality', 'PLA', 1.0, 20.00),
('PLA Negro 1kg', 'Sunlu', 'PLA', 1.0, 22.00),
('PETG Transparente 1kg', 'eSUN', 'PETG', 1.0, 28.00),
('ABS Rojo 1kg', 'Hatchbox', 'ABS', 1.0, 25.00),
('TPU Flexible Azul 500g', 'NinjaFlex', 'TPU', 0.5, 35.00),
('PLA+ Gris 1kg', 'eSUN', 'PLA+', 1.0, 24.00)
ON CONFLICT DO NOTHING;

-- ============================
-- EXTRA SUPPLIES
-- ============================

INSERT INTO extra_supplies (name, cost) VALUES
('Tornillo M3 x 10mm', 0.10),
('Tuerca M3', 0.05),
('Pegamento Cianocrilato 3g', 2.50),
('Pintura Spray Negro', 5.00),
('Pintura Spray Blanco', 5.00),
('Lija Grano 220', 0.50),
('Masilla Epóxica 50g', 3.00)
ON CONFLICT DO NOTHING;

-- ============================
-- SHIPPING OPTIONS
-- ============================

INSERT INTO shippings (shipping_type, carrier_name, cost) VALUES
('Estándar', 'Correos Nacional', 5.00),
('Express', 'DHL', 15.00),
('Económico', 'Envío Local', 3.00),
('Internacional', 'FedEx', 45.00)
ON CONFLICT DO NOTHING;

-- ============================
-- CUSTOMERS
-- ============================

INSERT INTO customers (apodo, nombre, apellido, numero, direccion, notes, created) VALUES
('JuanP', 'Juan', 'Pérez', '+1234567890', 'Calle Principal 123, Ciudad', 'Cliente frecuente', NOW()),
('MariaG', 'María', 'García', '+0987654321', 'Av. Secundaria 456, Pueblo', 'Solicita envíos express', NOW()),
('TechCorp', 'Tech', 'Corporation', '+1122334455', 'Zona Industrial 789', 'Empresa - Factura mensual', NOW()),
('AnaTorres', 'Ana', 'Torres', '+5544332211', NULL, 'Proyectos personalizados', NOW())
ON CONFLICT DO NOTHING;

-- ============================
-- SAMPLE QUOTES
-- ============================

-- Get user ID for sample quotes
DO $$
DECLARE
    admin_id INTEGER;
    printer_id INTEGER;
    customer_id INTEGER;
    filament_id INTEGER;
BEGIN
    -- Get admin user ID
    SELECT id INTO admin_id FROM users WHERE email = 'admin@pingulab.com';
    
    -- Get first printer
    SELECT id INTO printer_id FROM printers LIMIT 1;
    
    -- Get first customer
    SELECT id INTO customer_id FROM customers LIMIT 1;
    
    -- Get first filament
    SELECT id INTO filament_id FROM filaments LIMIT 1;
    
    IF admin_id IS NOT NULL AND printer_id IS NOT NULL THEN
        -- Sample Quote 1: Simple PLA part
        INSERT INTO quotes (
            name, quantity, piece_weight_grams, print_hours, 
            post_processing_cost, measurements, filament_cost, 
            electricity_cost, supplies_cost, depreciation_cost,
            subtotal, margin_percent, total, status, 
            customer_id, printer_id, created_by
        ) VALUES (
            'Soporte para Monitor', 2, 150.0, 5.0,
            0.0, '200x100x50mm', 3.00,
            0.165, 0.0, 0.25,
            6.83, 0.30, 17.75, 'PENDIENTE',
            customer_id, printer_id, admin_id
        );
        
        -- Sample Quote 2: Complex part with post-processing
        INSERT INTO quotes (
            name, quantity, piece_weight_grams, print_hours,
            post_processing_cost, measurements, filament_cost,
            electricity_cost, supplies_cost, depreciation_cost,
            subtotal, margin_percent, total, status,
            customer_id, printer_id, created_by
        ) VALUES (
            'Carcasa Personalizada', 1, 300.0, 12.0,
            10.0, '150x150x75mm', 6.00,
            0.396, 8.50, 0.60,
            25.496, 0.40, 35.69, 'PROCESO',
            customer_id, printer_id, admin_id
        );
    END IF;
END $$;

-- ============================
-- SUMMARY
-- ============================

SELECT 'Seed data inserted successfully!' as status;
SELECT COUNT(*) as user_count FROM users;
SELECT COUNT(*) as printer_count FROM printers;
SELECT COUNT(*) as filament_count FROM filaments;
SELECT COUNT(*) as supply_count FROM extra_supplies;
SELECT COUNT(*) as customer_count FROM customers;
SELECT COUNT(*) as quote_count FROM quotes;

COMMIT;
