-- Script para insertar datos de prueba en la base de datos

-- 1. Insertar tasa de electricidad activa
INSERT INTO electricity_rates (id, "costPerKwh", active) 
VALUES (1, 0.15, true)
ON CONFLICT (id) DO NOTHING;

-- 2. Insertar impresoras
INSERT INTO printers (id, name, "powerConsumptionWatts", available)
VALUES 
  (1, 'Ender 3 V2', 350, true),
  (2, 'Prusa i3 MK3S+', 120, true),
  (3, 'Creality CR-10', 400, false)
ON CONFLICT (id) DO NOTHING;

-- 3. Insertar filamentos
INSERT INTO filaments (id, name, brand, "materialType", "spoolWeightKg", "spoolCost")
VALUES 
  (1, 'PLA Negro', 'Creality', 'PLA', 1.0, 25.00),
  (2, 'PLA Blanco', 'Sunlu', 'PLA', 1.0, 22.00),
  (3, 'ABS Rojo', 'Esun', 'ABS', 1.0, 30.00),
  (4, 'PETG Transparente', 'Overture', 'PETG', 1.0, 28.00),
  (5, 'TPU Flexible', 'Sunlu', 'TPU', 0.5, 35.00)
ON CONFLICT (id) DO NOTHING;

-- 4. Insertar insumos extra
INSERT INTO extra_supplies (id, name, cost)
VALUES 
  (1, 'Pegamento', 5.00),
  (2, 'Lija 400', 2.50),
  (3, 'Pintura Spray', 15.00),
  (4, 'Tornillos M3', 3.00),
  (5, 'Resina para acabado', 12.00)
ON CONFLICT (id) DO NOTHING;

-- 5. Insertar opciones de envío
INSERT INTO shippings (id, "shippingType", "carrierName", cost)
VALUES 
  (1, 'Local', 'Entrega Personal', 0.00),
  (2, 'Nacional Estándar', 'Estafeta', 120.00),
  (3, 'Nacional Express', 'DHL', 250.00),
  (4, 'Local Motorizado', 'Mensajero', 50.00)
ON CONFLICT (id) DO NOTHING;

-- Actualizar secuencias
SELECT setval('electricity_rates_id_seq', (SELECT MAX(id) FROM electricity_rates));
SELECT setval('printers_id_seq', (SELECT MAX(id) FROM printers));
SELECT setval('filaments_id_seq', (SELECT MAX(id) FROM filaments));
SELECT setval('extra_supplies_id_seq', (SELECT MAX(id) FROM extra_supplies));
SELECT setval('shippings_id_seq', (SELECT MAX(id) FROM shippings));

-- Mostrar datos insertados
SELECT 'Electricity Rates:' as tabla;
SELECT * FROM electricity_rates;

SELECT 'Printers:' as tabla;
SELECT * FROM printers;

SELECT 'Filaments:' as tabla;
SELECT * FROM filaments;

SELECT 'Extra Supplies:' as tabla;
SELECT * FROM extra_supplies;

SELECT 'Shippings:' as tabla;
SELECT * FROM shippings;
