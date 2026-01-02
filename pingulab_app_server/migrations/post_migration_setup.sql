-- =====================================================
-- SCRIPT DE INICIALIZACIÓN POST-MIGRACIÓN
-- =====================================================
-- Este script debe ejecutarse DESPUÉS de que Serverpod
-- aplique las migraciones oficiales del registry.
-- Contiene las modificaciones manuales necesarias.
-- =====================================================

-- 1. Agregar campos a users (ya deben existir por migraciones)
-- Verificar que la tabla users tenga todos los campos necesarios
DO $$ 
BEGIN
    -- Agregar passwordHash si no existe
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='users' AND column_name='passwordHash') THEN
        ALTER TABLE users ADD COLUMN "passwordHash" TEXT NOT NULL DEFAULT '';
    END IF;
    
    -- Agregar rol si no existe (debe ser bigint)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='users' AND column_name='rol') THEN
        ALTER TABLE users ADD COLUMN rol BIGINT NOT NULL DEFAULT 1;
    END IF;
    
    -- Agregar activo si no existe
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='users' AND column_name='activo') THEN
        ALTER TABLE users ADD COLUMN activo BOOLEAN NOT NULL DEFAULT TRUE;
    END IF;
END $$;

-- 2. Agregar campos a printers
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='printers' AND column_name='purchaseCost') THEN
        ALTER TABLE printers ADD COLUMN "purchaseCost" DOUBLE PRECISION NOT NULL DEFAULT 0.0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='printers' AND column_name='imageBase64') THEN
        ALTER TABLE printers ADD COLUMN "imageBase64" TEXT;
    END IF;
END $$;

-- 3. Agregar color a filaments
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='filaments' AND column_name='color') THEN
        ALTER TABLE filaments ADD COLUMN color TEXT NOT NULL DEFAULT '#808080';
    END IF;
END $$;

-- 4. Agregar campos a quotes
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='quotes' AND column_name='quantity') THEN
        ALTER TABLE quotes ADD COLUMN quantity INTEGER NOT NULL DEFAULT 1;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='quotes' AND column_name='depreciationCost') THEN
        ALTER TABLE quotes ADD COLUMN "depreciationCost" DOUBLE PRECISION NOT NULL DEFAULT 0.0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='quotes' AND column_name='createdBy') THEN
        ALTER TABLE quotes ADD COLUMN "createdBy" INTEGER REFERENCES users(id);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='quotes' AND column_name='updatedBy') THEN
        ALTER TABLE quotes ADD COLUMN "updatedBy" INTEGER REFERENCES users(id);
    END IF;
END $$;

-- 5. Asignar colores predeterminados a filamentos existentes (solo si color es gris)
UPDATE filaments SET color = '#FFFFFF' WHERE LOWER(name) LIKE '%blanco%' AND color = '#808080';
UPDATE filaments SET color = '#000000' WHERE LOWER(name) LIKE '%negro%' AND color = '#808080';
UPDATE filaments SET color = '#FF0000' WHERE LOWER(name) LIKE '%rojo%' AND color = '#808080';
UPDATE filaments SET color = '#0000FF' WHERE LOWER(name) LIKE '%azul%' AND color = '#808080';
UPDATE filaments SET color = '#00FF00' WHERE LOWER(name) LIKE '%verde%' AND color = '#808080';
UPDATE filaments SET color = '#FFFF00' WHERE LOWER(name) LIKE '%amarillo%' AND color = '#808080';
UPDATE filaments SET color = '#FFA500' WHERE LOWER(name) LIKE '%naranja%' AND color = '#808080';
UPDATE filaments SET color = '#800080' WHERE LOWER(name) LIKE '%morado%' OR LOWER(name) LIKE '%purpura%' AND color = '#808080';
UPDATE filaments SET color = '#FFC0CB' WHERE LOWER(name) LIKE '%rosa%' AND color = '#808080';

-- 6. Crear índices para mejorar performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_quotes_created_by ON quotes("createdBy");
CREATE INDEX IF NOT EXISTS idx_quotes_updated_by ON quotes("updatedBy");
CREATE INDEX IF NOT EXISTS idx_quotes_customer_id ON quotes("customerId");

-- 7. Verificación final
DO $$
BEGIN
    RAISE NOTICE '✅ Script de post-migración completado';
    RAISE NOTICE 'Tablas verificadas: users, printers, filaments, quotes';
END $$;
