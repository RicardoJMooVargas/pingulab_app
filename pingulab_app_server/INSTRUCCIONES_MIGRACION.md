# 🔧 Instrucciones de Migración (SIN PERDER DATOS)

## ✅ Script Actualizado: `migrate_preserve_data.sql`

Este script está diseñado para **actualizar tu base de datos existente** sin borrar ningún dato.

## 📋 Lo que hace el script:

### 1. Crea la tabla `users` (si no existe)
- Admin: admin@pingulab.com / admin123
- Operador: operador@pingulab.com / operator123  
- Viewer: viewer@pingulab.com / viewer123

### 2. Actualiza tabla `printers`
- Agrega columna `purchase_cost`
- Actualiza automáticamente tus impresoras:
  - "Bambu Lab A1 Mini | 5,549$" → purchase_cost = 5549.00
  - "Bambu Lab A1 | 12,000$" → purchase_cost = 12000.00

### 3. Actualiza tabla `quotes`
- Agrega columna `quantity` (default: 1)
- Agrega columna `depreciation_cost` (default: 0.0)
- Agrega columna `created_by` (referencia a users)
- Agrega columna `updated_by` (referencia a users)
- Asigna automáticamente al admin como creador de cotizaciones existentes

### 4. Preserva TODOS tus datos existentes:
- ✅ Clientes (Maribel)
- ✅ Filamentos (12 filamentos)
- ✅ Suministros (7 items)
- ✅ Impresoras (Bambu Lab A1 Mini y A1)
- ✅ Cotizaciones existentes
- ✅ Tarifas eléctricas (1.243)
- ✅ Opciones de envío

## 🚀 Cómo Ejecutar

### Opción 1: pgAdmin (Recomendado)

1. Abre **pgAdmin**
2. Conecta a PostgreSQL
3. Click derecho en `pingulab_db` → **Query Tool**
4. Abre el archivo: `migrations/migrate_preserve_data.sql`
5. Click **Execute** (▶️)
6. Verifica los resultados en la pestaña "Data Output"

### Opción 2: Línea de comandos

```bash
# Navega al directorio de PostgreSQL bin (ejemplo):
cd "C:\Program Files\PostgreSQL\15\bin"

# Ejecuta la migración
.\psql.exe -U postgres -d pingulab_db -f "C:\Users\Eltra\Repos\pingulab_app\pingulab_app_server\migrations\migrate_preserve_data.sql"
```

### Opción 3: Desde psql interactivo

```sql
-- Abre psql
psql -U postgres -d pingulab_db

-- Ejecuta el script
\i C:/Users/Eltra/Repos/pingulab_app/pingulab_app_server/migrations/migrate_preserve_data.sql

-- Sal de psql
\q
```

## ✅ Verificación Post-Migración

Después de ejecutar, deberías ver:

```
✅ Migration completed successfully!

users_count | printers_count | filaments_count | supplies_count | customers_count | quotes_count
------------|----------------|-----------------|----------------|-----------------|-------------
     3      |       2        |       12        |       7        |       1         |      1

Users:
id |         email          |    nombre     |    rol    | activo
---|------------------------|---------------|-----------|--------
 1 | admin@pingulab.com     | Administrator | ADMIN     | t
 2 | operador@pingulab.com  | Operador      | OPERADOR  | t
 3 | viewer@pingulab.com    | Visualizador  | VIEWER    | t

Printers with purchase cost:
id |           name                    | power_consumption_watts | purchase_cost | available
---|-----------------------------------|-------------------------|---------------|----------
 1 | Bambu Lab A1 Mini | 5,549$       |          127            |   5549.00     | t
 2 | Bambu Lab A1 | 12,000$           |          300            |  12000.00     | t

Quotes with new fields:
id |              name                          | quantity | depreciation_cost | created_by
---|--------------------------------------------| ---------|-------------------|------------
 1 | Letras ABCEDARIO Completo 27 Letras       |    1     |       0.0         |     1
```

## 🔍 Comandos de Verificación

```sql
-- Ver estructura de la tabla users
\d users

-- Ver columnas nuevas en quotes
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'quotes' 
AND column_name IN ('quantity', 'depreciation_cost', 'created_by', 'updated_by');

-- Ver columna nueva en printers
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'printers' 
AND column_name = 'purchase_cost';

-- Ver todos tus datos preservados
SELECT COUNT(*) as total_filaments FROM filaments;
SELECT COUNT(*) as total_supplies FROM extra_supplies;
SELECT COUNT(*) as total_customers FROM customers;
```

## ⚠️ Notas Importantes

1. **El script es SEGURO**: Usa `IF NOT EXISTS` y `ON CONFLICT DO NOTHING`
2. **No borra datos**: Solo agrega columnas y usuarios
3. **Idempotente**: Puedes ejecutarlo múltiples veces sin problemas
4. **Usa transacción**: Si algo falla, no se aplica ningún cambio (ROLLBACK automático)

## 🎯 Después de la Migración

1. **Reinicia el servidor Dart**:
   ```bash
   cd pingulab_app_server
   dart run bin/main.dart
   ```

2. **Ejecuta Flutter**:
   ```bash
   cd pingulab_app_flutter
   flutter run
   ```

3. **Login con**:
   - Email: `admin@pingulab.com`
   - Password: `admin123`

4. **Prueba creando una cotización**:
   - Verás tus filamentos reales
   - Verás tus impresoras con sus costos
   - El sistema calculará la depreciación automáticamente

## 📊 Datos Preservados

### Tus Filamentos (12):
- PLA Azul, Rojo, Amarillo, Plata, Silk (Creality/Sunlu/Mexico Maker)
- PETG Blanco, Gris, Negro (Jayo/Sunlu/Futur3D)
- TPU Transparente
- PLA Meta

### Tus Suministros (7):
- Pegamento (5)
- Lija (2.5)
- Pintura Spray (15)
- Resina para acabado (12)
- Vela Lamp de Batería (7)
- Lámpara Led RGB + Control (52.83)
- Bolsa Esmerilada Zipper (2.61)

### Tus Impresoras (2):
- Bambu Lab A1 Mini (127W, 5,549$)
- Bambu Lab A1 (300W, 12,000$)

### Tu Cliente (1):
- Maribel (+52 1 981 117 4442)

### Tu Cotización (1):
- "Letras ABCEDARIO Completo 27 Letras"

## 🚨 Si algo sale mal

```sql
-- Verificar si la migración se aplicó parcialmente
SELECT table_name 
FROM information_schema.tables 
WHERE table_name = 'users';

-- Si necesitas hacer rollback manual (solo si algo falló)
-- NO EJECUTES ESTO A MENOS QUE SEA NECESARIO
-- DROP TABLE IF EXISTS users CASCADE;
-- ALTER TABLE printers DROP COLUMN IF EXISTS purchase_cost;
-- ALTER TABLE quotes DROP COLUMN IF EXISTS quantity;
-- ALTER TABLE quotes DROP COLUMN IF EXISTS depreciation_cost;
-- ALTER TABLE quotes DROP COLUMN IF EXISTS created_by;
-- ALTER TABLE quotes DROP COLUMN IF EXISTS updated_by;
```

---

**¡Listo!** Una vez ejecutada la migración, tu base de datos estará actualizada y podrás usar el sistema de login sin perder ninguno de tus datos. 🎉
