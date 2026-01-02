# Testing Guide - Backend Changes

## 🧪 Guía de Pruebas para Cambios del Backend

### Preparación

1. **Aplicar Migración**
```bash
psql -U postgres -d pingulab_db -f migrations/migration_add_users_and_updates.sql
```

2. **Cargar Datos de Prueba**
```bash
psql -U postgres -d pingulab_db -f seed_data_with_auth.sql
```

3. **Generar Protocolo**
```bash
cd pingulab_app_server
serverpod generate
```

4. **Iniciar Servidor**
```bash
dart run bin/main.dart
```

---

## ✅ Checklist de Pruebas

### 1. Autenticación y Usuarios

#### ✅ Test 1.1: Login Exitoso
```dart
final user = await client.auth.login('admin@pingulab.com', 'admin123');
// Verificar que user no sea null
// Verificar que user.rol sea ADMIN
```

#### ✅ Test 1.2: Login Fallido (contraseña incorrecta)
```dart
final user = await client.auth.login('admin@pingulab.com', 'wrongpassword');
// Verificar que user sea null
```

#### ✅ Test 1.3: Registro de Usuario
```dart
final newUser = await client.auth.register(
  'test@test.com',
  'test123',
  'Test',
  'User',
  UserRole.OPERADOR,
);
// Verificar que newUser.id no sea null
// Verificar que newUser.activo sea true
```

#### ✅ Test 1.4: Cambio de Contraseña
```dart
final success = await client.auth.changePassword(
  userId,
  'admin123',
  'newpassword',
);
// Verificar que success sea true
// Intentar login con nueva contraseña
```

#### ✅ Test 1.5: Listar Usuarios
```dart
final users = await client.auth.getAllUsers();
// Verificar que la lista tenga al menos 3 usuarios (admin, operador, viewer)
```

---

### 2. Cotizaciones con Nuevos Campos

#### ✅ Test 2.1: Crear Cotización con Quantity
```dart
final input = QuoteInput(
  name: 'Test Quote',
  quantity: 5,  // NUEVO
  pieceWeightGrams: 100.0,
  printHours: 3.0,
  marginPercent: 0.25,
  printerId: 1,
  filamentUsages: [
    FilamentUsage(filamentId: 1, gramsUsed: 100.0),
  ],
);

final quote = await client.quote.createQuote(input, userId: 1);
// Verificar que quote.quantity sea 5
// Verificar que quote.createdBy sea 1
// Verificar que quote.depreciationCost > 0
```

#### ✅ Test 2.2: Verificar Cálculo con Quantity
```dart
// Con quantity = 2:
// - filamentCost debe ser el doble
// - electricityCost debe ser el doble
// - depreciationCost debe ser el doble
// - shippingCost NO debe multiplicarse
// - total debe reflejar quantity correctamente

final quote = await client.quote.createQuote(input, userId: 1);
final expectedFilamentCost = baseCost * 2;
// Verificar que quote.filamentCost == expectedFilamentCost
```

#### ✅ Test 2.3: Actualizar Cotización con User Tracking
```dart
final updatedQuote = await client.quote.updateQuote(
  quoteId: 1,
  input: updatedInput,
  userId: 2,  // Usuario diferente al creador
);
// Verificar que updatedQuote.updatedBy sea 2
// Verificar que updatedQuote.createdBy siga siendo 1
```

#### ✅ Test 2.4: Obtener Detalles de Cotización
```dart
final details = await client.quote.getQuoteDetails(1);
// Verificar que details.quote no sea null
// Verificar que details.filamentDetails tenga elementos
// Verificar cálculo de depreciationCost
```

---

### 3. Impresoras con Costo de Compra

#### ✅ Test 3.1: Crear Impresora con Purchase Cost
```dart
final printer = await client.resources.createPrinter(
  'Test Printer',
  250,  // watts
  500.00,  // purchaseCost - NUEVO
  true,  // available
);
// Verificar que printer.purchaseCost sea 500.00
```

#### ✅ Test 3.2: Verificar Cálculo de Depreciación
```dart
// Crear cotización con impresora de costo $500
// printHours = 10
// Depreciación esperada = (500 / 5000) * 10 = $1.00

final quote = await client.quote.createQuote(input);
// Verificar que quote.depreciationCost == 1.00 (aproximado)
```

#### ✅ Test 3.3: Actualizar Impresora
```dart
final updated = await client.resources.updatePrinter(
  printerId: 1,
  name: 'Updated Printer',
  powerConsumptionWatts: 300,
  purchaseCost: 600.00,
  available: true,
);
// Verificar que updated.purchaseCost sea 600.00
```

---

### 4. CRUD de Recursos

#### ✅ Test 4.1: CRUD Filamentos
```dart
// Create
final filament = await client.resources.createFilament(
  'Test Filament', 'TestBrand', 'PLA', 1.0, 25.00
);

// Read
final filaments = await client.resources.getAllFilaments();

// Update
final updated = await client.resources.updateFilament(
  filament.id!, 'Updated Name', 'TestBrand', 'PLA', 1.0, 30.00
);

// Delete
await client.resources.deleteFilament(filament.id!);
```

#### ✅ Test 4.2: CRUD Suministros
```dart
// Similar a Test 4.1 pero con ExtraSupplies
```

#### ✅ Test 4.3: CRUD Envíos
```dart
// Similar a Test 4.1 pero con Shippings
```

#### ✅ Test 4.4: Tarifas Eléctricas con Auto-Desactivación
```dart
// Crear tarifa activa
final rate1 = await client.resources.createElectricityRate(0.15, true);

// Crear segunda tarifa activa
final rate2 = await client.resources.createElectricityRate(0.20, true);

// Verificar que rate1 ya no esté activa
final allRates = await client.resources.getAllElectricityRates();
final rate1Updated = allRates.firstWhere((r) => r.id == rate1.id);
// Verificar que rate1Updated.active sea false
```

---

### 5. Clientes con Validación

#### ✅ Test 5.1: Crear Cliente
```dart
final customer = await client.customer.createCustomer(
  'TestCustomer',
  'Test',
  'Customer',
  '+123456789',
  'Test Address',
  'Test notes',
);
// Verificar que customer.id no sea null
```

#### ✅ Test 5.2: Actualizar Cliente
```dart
final updated = await client.customer.updateCustomer(
  customerId: customer.id!,
  apodo: 'UpdatedCustomer',
  nombre: 'Updated',
  apellido: 'Customer',
  numero: '+987654321',
  direccion: 'Updated Address',
  notes: 'Updated notes',
);
// Verificar que updated.apodo sea 'UpdatedCustomer'
```

#### ✅ Test 5.3: Borrar Cliente sin Cotizaciones
```dart
await client.customer.deleteCustomer(customer.id!);
// Verificar que se elimine sin error
```

#### ✅ Test 5.4: Intentar Borrar Cliente con Cotizaciones
```dart
// Crear cotización con customerId
final quote = await client.quote.createQuote(inputWithCustomer);

// Intentar borrar el cliente
try {
  await client.customer.deleteCustomer(customerId);
  // Debe lanzar excepción
  fail('Expected exception not thrown');
} catch (e) {
  // Verificar que e.message contenga 'used in existing quotes'
}
```

---

### 6. Búsqueda y Filtros

#### ✅ Test 6.1: Búsqueda de Clientes
```dart
final results = await client.customer.searchCustomers('Juan');
// Verificar que results contenga clientes con 'Juan' en apodo, nombre o apellido
```

#### ✅ Test 6.2: Obtener Solo Impresoras Disponibles
```dart
final available = await client.resources.getAvailablePrinters();
// Verificar que todos tengan available == true
```

#### ✅ Test 6.3: Obtener Tarifa Eléctrica Activa
```dart
final activeRate = await client.resources.getActiveElectricityRate();
// Verificar que activeRate.active sea true
```

---

## 🔍 Tests de Validación

### Validación 1: Hash de Contraseñas
```dart
// Verificar que las contraseñas nunca se almacenen en texto plano
final user = await User.db.findById(session, userId);
// Verificar que user.passwordHash != 'admin123'
// Verificar longitud de hash (SHA256 = 64 caracteres hex)
```

### Validación 2: Unicidad de Email
```dart
try {
  await client.auth.register(
    'admin@pingulab.com',  // Email ya existente
    'password',
    'Test',
    null,
    UserRole.OPERADOR,
  );
  fail('Expected exception');
} catch (e) {
  // Verificar que e.message contenga 'already registered'
}
```

### Validación 3: Usuario Inactivo No Puede Loguearse
```dart
// Desactivar usuario
await client.auth.deactivateUser(userId);

// Intentar login
try {
  await client.auth.login(email, password);
  fail('Expected exception');
} catch (e) {
  // Verificar que e.message contenga 'deactivated'
}
```

---

## 📊 Verificación de Cálculos

### Ejemplo de Cálculo Completo

**Datos de entrada:**
- Quantity: 3 piezas
- Filament: 100g @ $20/kg = $2.00
- Print hours: 5h
- Printer: 200W @ $300 purchase cost
- Electricity: $0.15/kWh
- Margin: 30%
- Shipping: $5.00

**Cálculo esperado (por pieza):**
```
Filament cost per piece = (100g / 1000g) * $20 = $2.00
Electricity cost per piece = (200W / 1000) * 5h * $0.15 = $0.15
Depreciation per piece = ($300 / 5000h) * 5h = $0.30
Subtotal per piece = $2.00 + $0.15 + $0.30 = $2.45

Total per piece with margin = $2.45 * 1.30 = $3.185

For 3 pieces:
Total = ($3.185 * 3) + $5.00 shipping = $14.555
```

**Test:**
```dart
// Verificar que quote.total ≈ 14.56 (con redondeo)
```

---

## 🚨 Tests de Seguridad

### ✅ Test S1: Verificar Hash de Contraseña
```bash
echo -n "admin123" | sha256sum
# Resultado: 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
```

### ✅ Test S2: Contraseña Incorrecta
```dart
final result = await client.auth.login('admin@pingulab.com', 'wrongpass');
// Verificar que result sea null
```

### ✅ Test S3: Email No Existente
```dart
final result = await client.auth.login('notexist@test.com', 'password');
// Verificar que result sea null
```

---

## 📝 Checklist Post-Deployment

- [ ] Cambiar contraseña de admin
- [ ] Cambiar contraseña de operador
- [ ] Cambiar contraseña de viewer
- [ ] Verificar que no haya contraseñas de prueba
- [ ] Revisar logs de errores
- [ ] Verificar permisos de base de datos
- [ ] Probar todos los endpoints principales
- [ ] Verificar cálculos de cotizaciones
- [ ] Confirmar tracking de usuarios funciona
- [ ] Validar que depreciación se calcule correctamente

---

## 🛠️ Comandos Útiles

### Verificar Usuarios en DB
```sql
SELECT id, email, nombre, rol, activo FROM users;
```

### Verificar Cotizaciones con Usuarios
```sql
SELECT 
  q.id, 
  q.name, 
  q.quantity,
  q.depreciation_cost,
  u1.nombre as created_by_name,
  u2.nombre as updated_by_name
FROM quotes q
LEFT JOIN users u1 ON q.created_by = u1.id
LEFT JOIN users u2 ON q.updated_by = u2.id;
```

### Verificar Impresoras con Costo
```sql
SELECT id, name, power_consumption_watts, purchase_cost, available 
FROM printers;
```

---

**Última actualización**: 2026-01-01  
**Estado**: Lista para pruebas
