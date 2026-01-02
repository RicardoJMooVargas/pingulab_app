BEGIN;

-- Agregar columna color a filaments
ALTER TABLE filaments ADD COLUMN IF NOT EXISTS color TEXT NOT NULL DEFAULT '#808080';

-- Agregar columna imageBase64 a printers
ALTER TABLE printers ADD COLUMN IF NOT EXISTS "imageBase64" TEXT;

-- Actualizar filamentos existentes con colores por defecto basados en el nombre
UPDATE filaments SET color = '#FFFFFF' WHERE LOWER(name) LIKE '%blanco%' OR LOWER(name) LIKE '%white%';
UPDATE filaments SET color = '#000000' WHERE LOWER(name) LIKE '%negro%' OR LOWER(name) LIKE '%black%';
UPDATE filaments SET color = '#FF0000' WHERE LOWER(name) LIKE '%rojo%' OR LOWER(name) LIKE '%red%';
UPDATE filaments SET color = '#0000FF' WHERE LOWER(name) LIKE '%azul%' OR LOWER(name) LIKE '%blue%';
UPDATE filaments SET color = '#00FF00' WHERE LOWER(name) LIKE '%verde%' OR LOWER(name) LIKE '%green%';
UPDATE filaments SET color = '#FFFF00' WHERE LOWER(name) LIKE '%amarillo%' OR LOWER(name) LIKE '%yellow%';
UPDATE filaments SET color = '#FFA500' WHERE LOWER(name) LIKE '%naranja%' OR LOWER(name) LIKE '%orange%';
UPDATE filaments SET color = '#800080' WHERE LOWER(name) LIKE '%morado%' OR LOWER(name) LIKE '%purple%';
UPDATE filaments SET color = '#FFC0CB' WHERE LOWER(name) LIKE '%rosa%' OR LOWER(name) LIKE '%pink%';
UPDATE filaments SET color = '#808080' WHERE LOWER(name) LIKE '%gris%' OR LOWER(name) LIKE '%gray%' OR LOWER(name) LIKE '%grey%';

COMMIT;

SELECT 'Columnas agregadas y colores asignados' as status;
