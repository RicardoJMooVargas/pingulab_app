-- Script para insertar una cotización de prueba

-- Primero insertamos la cotización base
INSERT INTO quotes (
  id,
  "gramsPrinted",
  "printHours",
  "postProcessingCost",
  measurements,
  "filamentCost",
  "electricityCost",
  "suppliesCost",
  "shippingCost",
  subtotal,
  "marginPercent",
  total,
  status,
  "imageUrl",
  "printerId",
  "shippingId"
) VALUES (
  1,
  150.0,              -- 150 gramos
  8.5,                -- 8.5 horas
  10.00,              -- $10 post-procesado
  '10x10x5 cm',       -- medidas
  3.75,               -- costo filamento (se calculará)
  0.45,               -- costo electricidad
  7.50,               -- costo insumos
  50.00,              -- costo envío
  21.70,              -- subtotal
  0.30,               -- 30% margen
  78.21,              -- total
  0,                  -- PENDIENTE
  'https://example.com/image.jpg',
  1,                  -- Ender 3 V2
  4                   -- Local Motorizado
) ON CONFLICT (id) DO UPDATE SET
  "gramsPrinted" = EXCLUDED."gramsPrinted",
  "printHours" = EXCLUDED."printHours",
  "postProcessingCost" = EXCLUDED."postProcessingCost",
  measurements = EXCLUDED.measurements,
  "filamentCost" = EXCLUDED."filamentCost",
  "electricityCost" = EXCLUDED."electricityCost",
  "suppliesCost" = EXCLUDED."suppliesCost",
  "shippingCost" = EXCLUDED."shippingCost",
  subtotal = EXCLUDED.subtotal,
  "marginPercent" = EXCLUDED."marginPercent",
  total = EXCLUDED.total,
  status = EXCLUDED.status,
  "imageUrl" = EXCLUDED."imageUrl",
  "printerId" = EXCLUDED."printerId",
  "shippingId" = EXCLUDED."shippingId";

-- Insertar filamento usado
INSERT INTO quote_filaments (id, "quoteId", "filamentId", "gramsUsed", cost)
VALUES (1, 1, 1, 150.0, 3.75)
ON CONFLICT (id) DO UPDATE SET
  "gramsUsed" = EXCLUDED."gramsUsed",
  cost = EXCLUDED.cost;

-- Insertar insumos extra
INSERT INTO quote_extra_supplies (id, "quoteId", "extraSupplyId", quantity, cost)
VALUES 
  (1, 1, 1, 1, 5.00),  -- 1x Pegamento
  (2, 1, 2, 1, 2.50)   -- 1x Lija 400
ON CONFLICT (id) DO UPDATE SET
  quantity = EXCLUDED.quantity,
  cost = EXCLUDED.cost;

-- Actualizar secuencias
SELECT setval('quotes_id_seq', (SELECT MAX(id) FROM quotes));
SELECT setval('quote_filaments_id_seq', (SELECT MAX(id) FROM quote_filaments));
SELECT setval('quote_extra_supplies_id_seq', (SELECT MAX(id) FROM quote_extra_supplies));

-- Mostrar la cotización creada
SELECT 'Cotización creada:' as info;
SELECT * FROM quotes WHERE id = 1;

SELECT 'Filamentos usados:' as info;
SELECT qf.*, f.name as filament_name 
FROM quote_filaments qf 
JOIN filaments f ON qf."filamentId" = f.id 
WHERE qf."quoteId" = 1;

SELECT 'Insumos usados:' as info;
SELECT qes.*, es.name as supply_name 
FROM quote_extra_supplies qes 
JOIN extra_supplies es ON qes."extraSupplyId" = es.id 
WHERE qes."quoteId" = 1;
