# Resumen de Cambios - Backend Pingulab App

## 📋 Cambios Implementados

### 1. ✅ Sistema de Usuarios y Autenticación

#### Nuevos Modelos
- **`user.yaml`**: Modelo de usuario con campos:
  - email (único)
  - passwordHash (SHA256)
  - nombre
  - apellido (opcional)
  - rol (ADMIN, OPERADOR, VIEWER)
  - activo (boolean)
  - created/updated timestamps

- **`user_role.yaml`**: Enum con roles:
  - ADMIN
  - OPERADOR
  - VIEWER

#### Nuevo Endpoint: `auth_endpoint.dart`
Métodos disponibles:
- `register()`: Registrar nuevo usuario
- `login()`: Autenticar usuario
- `changePassword()`: Cambiar contraseña
- `getUserById()`: Obtener usuario por ID
- `getAllUsers()`: Listar todos los usuarios
- `updateUser()`: Actualizar información de usuario
- `deactivateUser()`: Desactivar cuenta
- `activateUser()`: Activar cuenta
- `resetPassword()`: Resetear contraseña (genera contraseña temporal)

**Seguridad**: 
- Contraseñas cifradas con SHA256
- Usuario admin por defecto: `admin@pingulab.com` / `admin123`
- ⚠️ Cambiar contraseña de admin en producción

---

### 2. ✅ Tracking de Usuarios en Cotizaciones

#### Cambios en `quote.yaml`
Nuevos campos agregados:
- `quantity`: Cantidad de piezas a producir
- `depreciationCost`: Costo de depreciación de impresora
- `createdBy`: ID del usuario que creó la cotización
- `updatedBy`: ID del usuario que actualizó la cotización

#### Cambios en `quote_input.yaml`
- Agregado campo `quantity`

#### Cambios en `quote_endpoint.dart`
- Métodos `createQuote()` y `updateQuote()` ahora aceptan parámetro opcional `userId`
- Se registra automáticamente quién crea/modifica cada cotización

---

### 3. ✅ Costo y Depreciación de Impresoras

#### Cambios en `printer.yaml`
Nuevo campo:
- `purchaseCost`: Costo de compra de la impresora

#### Cálculo de Depreciación
En `quote_endpoint.dart` método `_calculateQuoteCosts()`:
```dart
const double estimatedLifespanHours = 5000.0;
depreciationCost = (printer.purchaseCost / estimatedLifespanHours) * quote.printHours;
```

**Fórmula**: 
- Vida útil estimada: 5000 horas
- Depreciación = (Costo de compra / 5000) × Horas de impresión

---

### 4. ✅ Cálculo de Cotizaciones Actualizado

#### Nueva Lógica de Costos
Todos los costos ahora se multiplican por `quantity`:

```
Subtotal = (filamento + electricidad + suministros + depreciación + post-procesamiento)
Total = (Subtotal × (1 + margen%)) + envío) × quantity
```

**Costos individuales por pieza**:
- filamentCost × quantity
- electricityCost × quantity  
- suppliesCost × quantity
- depreciationCost × quantity (NUEVO)

**Envío**: No se multiplica por quantity (costo fijo)

---

### 5. ✅ Endpoints CRUD Completos

#### `resources_endpoint.dart` - Ampliado
Ahora incluye operaciones completas para:

**Printers**:
- `createPrinter()`
- `updatePrinter()`
- `deletePrinter()`

**Filaments**:
- `createFilament()`
- `updateFilament()`
- `deleteFilament()`

**Extra Supplies**:
- `createExtraSupply()`
- `updateExtraSupply()`
- `deleteExtraSupply()`

**Shipping**:
- `createShipping()`
- `updateShipping()`
- `deleteShipping()`

**Electricity Rates**:
- `createElectricityRate()` - Auto-desactiva otras tarifas si está activa
- `updateElectricityRate()` - Maneja activación única
- `deleteElectricityRate()`

#### `customer_endpoint.dart` - Ampliado
Nuevos métodos:
- `createCustomer()`
- `updateCustomer()`
- `deleteCustomer()` - Con validación (no permite borrar si tiene cotizaciones)

---

### 6. ✅ Dependencias Actualizadas

#### `pubspec.yaml`
Agregada dependencia:
```yaml
crypto: ^3.0.3  # Para hash de contraseñas
```

---

### 7. ✅ Migración de Base de Datos

#### Archivo: `migration_add_users_and_updates.sql`
Incluye:
- Creación de enum `user_role`
- Creación de tabla `users` con índices
- Alteración de tabla `printers` (nuevo campo `purchase_cost`)
- Alteración de tabla `quotes` (nuevos campos: `quantity`, `depreciation_cost`, `created_by`, `updated_by`)
- Usuario admin por defecto
- Índices para optimización

---

## 🚀 Pasos para Desplegar

### 1. Instalar Dependencias
```bash
cd pingulab_app_server
dart pub get
```

### 2. Aplicar Migración de Base de Datos
```bash
# Hacer backup primero
pg_dump -U postgres -d pingulab_db > backup_$(date +%Y%m%d).sql

# Aplicar migración
psql -U postgres -d pingulab_db -f migrations/migration_add_users_and_updates.sql
```

### 3. Regenerar Protocolo de Serverpod
```bash
serverpod generate
```

### 4. Reiniciar Servidor
```bash
dart run bin/main.dart
```

---

## 📊 Estructura de Endpoints

### Endpoints Disponibles:

1. **AuthEndpoint** (`/auth`)
   - Gestión de usuarios y autenticación

2. **QuoteEndpoint** (`/quote`)
   - CRUD de cotizaciones con tracking de usuarios

3. **CustomerEndpoint** (`/customer`)
   - CRUD de clientes

4. **ResourcesEndpoint** (`/resources`)
   - CRUD de impresoras, filamentos, suministros, envíos y tarifas eléctricas

---

## ⚠️ Notas Importantes

### Seguridad
1. **Cambiar contraseña del admin** inmediatamente: `admin@pingulab.com` / `admin123`
2. SHA256 es básico - considerar **bcrypt** o **Argon2** para producción
3. Implementar **tokens JWT** para sesiones
4. Agregar **rate limiting** en endpoints de auth
5. Validar roles en endpoints sensibles

### Próximos Pasos (Frontend Flutter)
- [ ] Pantalla de login
- [ ] Gestión de usuarios (admin)
- [ ] Campo de cantidad en formulario de cotización
- [ ] Mostrar depreciación en detalles de cotización
- [ ] Indicador de quién creó/modificó cotización
- [ ] Formularios CRUD para recursos (impresoras, filamentos, etc.)

### Mejoras Futuras
- [ ] Tokens JWT con refresh tokens
- [ ] Middleware de autenticación
- [ ] Permisos granulares por rol
- [ ] Historial de cambios en cotizaciones
- [ ] Auditoría completa de acciones
- [ ] 2FA (autenticación de dos factores)
- [ ] Rate limiting
- [ ] Logs de seguridad

---

## 📝 Cambios en Modelos

| Modelo | Campo Agregado | Tipo | Descripción |
|--------|---------------|------|-------------|
| User | (nuevo modelo) | - | Sistema de usuarios |
| Printer | purchaseCost | double | Costo de compra |
| Quote | quantity | int | Cantidad de piezas |
| Quote | depreciationCost | double | Costo de depreciación |
| Quote | createdBy | int? | Usuario creador |
| Quote | updatedBy | int? | Usuario que actualizó |

---

## 🔧 Configuración

### Variables de Entorno (Recomendadas)
```yaml
# config/production.yaml
jwt_secret: "tu-secret-key-aqui"
password_salt: "tu-salt-aqui"
printer_lifespan_hours: 5000  # Configurable
```

---

**Fecha de implementación**: 2026-01-01  
**Versión**: 1.1.0  
**Estado**: ✅ Backend Completo - Listo para integración Frontend
