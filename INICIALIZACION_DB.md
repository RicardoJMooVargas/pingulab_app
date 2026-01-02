# Inicialización Automática de Base de Datos

## Descripción

El sistema ahora incluye un endpoint de inicialización que crea automáticamente los usuarios por defecto cuando la aplicación Flutter se inicia por primera vez.

## Cómo Funciona

1. **Al iniciar la app Flutter**, el `main.dart` llama automáticamente a `client.init.initializeDatabase()`

2. **El endpoint verifica** si existe el usuario admin (`admin@pingulab.com`)

3. **Si no existe**:
   - Crea el usuario Admin
   - Crea el usuario Operador
   - Crea el usuario Viewer
   - Todos con las contraseñas hasheadas correctamente usando SHA256

4. **Si ya existe**:
   - No hace nada, la base de datos ya está inicializada

## Usuarios Creados

Los siguientes usuarios se crean automáticamente:

| Email | Contraseña | Rol | Descripción |
|-------|-----------|-----|-------------|
| admin@pingulab.com | admin123 | ADMIN | Administrador con todos los permisos |
| operador@pingulab.com | operador123 | OPERADOR | Operador principal |
| viewer@pingulab.com | viewer123 | VIEWER | Usuario solo lectura |

## Ventajas de Este Enfoque

✅ **Automático**: No requiere scripts SQL manuales
✅ **Seguro**: Usa la lógica de negocio para hashear contraseñas
✅ **Idempotente**: Se puede ejecutar múltiples veces sin problemas
✅ **Limpio**: Los datos se crean a través de endpoints, no directamente en la BD
✅ **Transparente**: Se ejecuta al inicio de la app sin intervención del usuario

## Endpoint Disponible

### `init.initializeDatabase()`
- **Retorna**: `bool` - `true` si se inicializó, `false` si ya estaba inicializada
- **Uso**: `await client.init.initializeDatabase();`

### `init.isDatabaseInitialized()`
- **Retorna**: `bool` - `true` si la BD está inicializada, `false` si no
- **Uso**: `await client.init.isDatabaseInitialized();`

## Desarrollo

Si necesitas resetear la base de datos durante desarrollo:

```sql
-- Limpiar usuarios
UPDATE quotes SET created_by = NULL, updated_by = NULL;
DELETE FROM users;
```

Luego solo reinicia la app Flutter y los usuarios se recrearán automáticamente.

## Código Relevante

- **Backend**: `lib/src/endpoints/init_endpoint.dart`
- **Frontend**: `lib/main.dart` (función `main()`)
