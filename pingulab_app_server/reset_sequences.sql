-- Script para resetear todas las secuencias de auto-incremento
-- Ejecutar después de insertar datos semilla (seed_data.sql)

-- Resetear secuencia de customers
SELECT setval('customers_id_seq', (SELECT COALESCE(MAX(id), 1) FROM customers));

-- Resetear secuencia de filaments
SELECT setval('filaments_id_seq', (SELECT COALESCE(MAX(id), 1) FROM filaments));

-- Resetear secuencia de printers
SELECT setval('printers_id_seq', (SELECT COALESCE(MAX(id), 1) FROM printers));

-- Resetear secuencia de shippings
SELECT setval('shippings_id_seq', (SELECT COALESCE(MAX(id), 1) FROM shippings));

-- Resetear secuencia de electricity_rates
SELECT setval('electricity_rates_id_seq', (SELECT COALESCE(MAX(id), 1) FROM electricity_rates));

-- Resetear secuencia de extra_supplies
SELECT setval('extra_supplies_id_seq', (SELECT COALESCE(MAX(id), 1) FROM extra_supplies));

-- Resetear secuencia de quotes
SELECT setval('quotes_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quotes));

-- Resetear secuencia de quote_filaments
SELECT setval('quote_filaments_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quote_filaments));

-- Resetear secuencia de quote_supplies
SELECT setval('quote_supplies_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quote_supplies));

-- Resetear secuencia de quote_categories
SELECT setval('quote_categories_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quote_categories));

-- Resetear secuencia de quote_versions
SELECT setval('quote_versions_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quote_versions));

-- Resetear secuencia de quote_version_filaments
SELECT setval('quote_version_filaments_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quote_version_filaments));

-- Resetear secuencia de quote_version_supplies
SELECT setval('quote_version_supplies_id_seq', (SELECT COALESCE(MAX(id), 1) FROM quote_version_supplies));

-- Resetear secuencia de sales
SELECT setval('sales_id_seq', (SELECT COALESCE(MAX(id), 1) FROM sales));

-- Verificar resultados
SELECT 
    schemaname,
    sequencename,
    last_value
FROM pg_sequences
WHERE schemaname = 'public'
ORDER BY sequencename;
