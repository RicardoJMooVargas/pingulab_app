# Guía de Migración - Usuarios y Actualizaciones

## Fecha: 2026-01-01

### Cambios Realizados

#### 1. Sistema de Usuarios y Autenticación
- **Nueva tabla `users`**: Almacena usuarios del sistema con autenticación
  - `email`: Email único del usuario
  - `password_hash`: Contraseña cifrada con SHA256
  - `nombre`: Nombre del usuario
  - `apellido`: Apellido (opcional)
  - `rol`: Rol del usuario (ADMIN, OPERADOR, VIEWER)
  - `activo`: Estado activo/inactivo
  - `created`/`updated`: Timestamps de creación y actualización

#### 2. Tracking de Usuarios en Cotizaciones
- **Nuevos campos en `quotes`**:
  - `created_by`: ID del usuario que creó la cotización
  - `updated_by`: ID del usuario que actualizó la cotización por última vez
  - `quantity`: Cantidad de piezas a producir
  - `depreciation_cost`: Costo de depreciación de la impresora

#### 3. Costo de Impresora
- **Nuevo campo en `printers`**:
  - `purchase_cost`: Costo de compra de la impresora para cálculo de depreciación

### Cálculo de Depreciación
El sistema ahora calcula la depreciación de la impresora usando:
- **Fórmula**: `(costo_compra / vida_útil_estimada) * horas_impresión`
- **Vida útil estimada**: 5000 horas (configurable en el código)

### Usuario Administrador por Defecto
- **Email**: admin@pingulab.com
- **Contraseña**: admin123
- **⚠️ IMPORTANTE**: Cambiar esta contraseña inmediatamente en producción

### Endpoints Nuevos

#### AuthEndpoint
- `register`: Registrar nuevo usuario
- `login`: Iniciar sesión
- `changePassword`: Cambiar contraseña
- `getUserById`: Obtener usuario por ID
- `getAllUsers`: Obtener todos los usuarios
- `updateUser`: Actualizar usuario
- `deactivateUser`: Desactivar usuario
- `activateUser`: Activar usuario
- `resetPassword`: Resetear contraseña (admin)

#### ResourcesEndpoint (ampliado)
Ahora incluye operaciones CRUD completas para:
- Printers (create, update, delete)
- Filaments (create, update, delete)
- Extra Supplies (create, update, delete)
- Shipping (create, update, delete)
- Electricity Rates (create, update, delete)

### Pasos para Aplicar la Migración

1. **Hacer backup de la base de datos**:
   ```bash
   pg_dump -U postgres -d pingulab_db > backup_$(date +%Y%m%d).sql
   ```

2. **Aplicar la migración**:
   ```bash
   psql -U postgres -d pingulab_db -f migrations/migration_add_users_and_updates.sql
   ```

3. **Instalar dependencia crypto**:
   ```bash
   cd pingulab_app_server
   dart pub get
   ```

4. **Regenerar el protocolo de Serverpod**:
   ```bash
   serverpod generate
   ```

5. **Reiniciar el servidor**

### Notas de Seguridad

1. **Cambiar contraseña del admin** inmediatamente después de la migración
2. Las contraseñas se almacenan como **SHA256 hash**
3. Para producción, considerar usar **bcrypt** o **Argon2** en lugar de SHA256
4. Implementar rate limiting en endpoints de autenticación
5. Considerar agregar tokens JWT para sesiones

### Cambios en el Cálculo de Cotizaciones

Ahora el cálculo incluye:
- Costo de filamento × cantidad
- Costo de electricidad × cantidad
- Costo de suministros × cantidad
- **Costo de depreciación × cantidad** (NUEVO)
- Costo de post-procesamiento
- Margen de ganancia
- Costo de envío (no se multiplica por cantidad)

### Próximos Pasos

1. Actualizar el frontend Flutter para:
   - Pantalla de login
   - Gestión de usuarios (admin)
   - Mostrar campo de cantidad en cotizaciones
   - Mostrar información de depreciación
   - Tracking de quién creó/modificó cotizaciones

2. Considerar agregar:
   - Tokens de autenticación (JWT)
   - Refresh tokens
   - Historial de cambios en cotizaciones
   - Permisos más granulares por rol
