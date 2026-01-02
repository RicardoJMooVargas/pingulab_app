# GUÍA DE MIGRACIÓN RÁPIDA

## ⚠️ IMPORTANTE: Debes aplicar la migración SQL a la base de datos

El protocolo de Serverpod (`serverpod generate`) solo genera código Dart.
**NO modifica la base de datos automáticamente.**

## 🚀 Pasos para Aplicar la Migración

### Opción 1: Usando psql (Línea de comandos)

```bash
# 1. Conectarte a PostgreSQL
psql -U postgres -d pingulab_db

# 2. Ejecutar la migración
\i C:/Users/Eltra/Repos/pingulab_app/pingulab_app_server/migrations/migration_add_users_and_updates.sql

# 3. Verificar las tablas nuevas
\dt

# 4. Ver la tabla users
SELECT * FROM users;

# 5. Salir
\q
```

### Opción 2: Usando pgAdmin (Interfaz Gráfica)

1. Abre **pgAdmin**
2. Conecta a tu servidor PostgreSQL
3. Navega a: `Servers → PostgreSQL → Databases → pingulab_db`
4. Click derecho en `pingulab_db` → **Query Tool**
5. Abre el archivo: `migration_add_users_and_updates.sql`
6. Click en el botón ▶️ **Execute/Run**
7. Verifica que veas: "Query returned successfully"

### Opción 3: Usando el script automatizado

```bash
# Edita migrate.bat y configura tu contraseña
notepad migrate.bat

# Ejecuta el script
migrate.bat
```

## ✅ Verificar que la Migración se Aplicó

```sql
-- Verificar tabla users existe
SELECT table_name 
FROM information_schema.tables 
WHERE table_name = 'users';

-- Ver estructura de la tabla users
\d users

-- Verificar que hay un usuario admin
SELECT id, email, nombre, rol, activo FROM users;

-- Verificar nuevas columnas en quotes
\d quotes

-- Debería mostrar:
-- - quantity
-- - depreciation_cost
-- - created_by
-- - updated_by

-- Verificar nueva columna en printers
\d printers

-- Debería mostrar:
-- - purchase_cost
```

## 📊 Resultado Esperado

Después de la migración, deberías ver:

### Nueva tabla `users`:
```
 id |        email         |   nombre      |    rol    | activo 
----+---------------------+---------------+-----------+--------
  1 | admin@pingulab.com  | Administrator | ADMIN     | t
```

### Tabla `quotes` actualizada:
```
Columnas nuevas:
- quantity (integer)
- depreciation_cost (double precision)
- created_by (integer)
- updated_by (integer)
```

### Tabla `printers` actualizada:
```
Columna nueva:
- purchase_cost (double precision)
```

## 🔧 Si la Migración Falla

### Error: "relation already exists"
Significa que las tablas ya existen. Puedes:

```sql
-- Ver qué existe
\dt

-- Si quieres empezar de cero (¡CUIDADO! Borra todo)
DROP TABLE IF EXISTS users CASCADE;
-- Luego vuelve a ejecutar la migración
```

### Error: "column already exists"
Significa que algunas columnas ya existen:

```sql
-- Verificar columnas de quotes
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'quotes';
```

## 🎯 Comandos Rápidos

```bash
# Ver todas las tablas
\dt

# Ver columnas de una tabla
\d+ quotes

# Ver usuarios
SELECT * FROM users;

# Ver cotizaciones con usuario
SELECT q.id, q.name, q.quantity, u.email as created_by_email
FROM quotes q
LEFT JOIN users u ON q.created_by = u.id;
```

## 📝 Notas

- **Backup automático**: El script `migrate.bat` crea backup antes de migrar
- **Rollback**: Si algo sale mal, restaura desde el backup:
  ```bash
  psql -U postgres -d pingulab_db < backup_YYYYMMDD.sql
  ```
- **Usuario admin**: Se crea con password `admin123` - ¡cámbialo!

## ❓ Troubleshooting

### "No puedo conectar a PostgreSQL"
```bash
# Verifica que PostgreSQL esté corriendo
# En Windows:
services.msc
# Busca "postgresql" y verifica que esté "Running"
```

### "Database does not exist"
```bash
# Crea la base de datos
createdb -U postgres pingulab_db

# O desde psql:
CREATE DATABASE pingulab_db;
```

### "Permission denied"
```bash
# Asegúrate de usar el usuario correcto (postgres)
psql -U postgres
```

---

**IMPORTANTE**: Después de aplicar la migración:
1. Reinicia el servidor Dart
2. La app Flutter ya debería funcionar con login
3. Las cotizaciones guardarán el userId correctamente
