# API Reference - Pingulab Backend

## Base URL
```
http://localhost:8080
```

## 🔐 Authentication Endpoint

### POST `/auth/register`
Registrar nuevo usuario.

**Request:**
```json
{
  "email": "usuario@ejemplo.com",
  "password": "password123",
  "nombre": "Nombre",
  "apellido": "Apellido",  // opcional
  "rol": "OPERADOR"  // ADMIN, OPERADOR, VIEWER
}
```

**Response:**
```json
{
  "id": 1,
  "email": "usuario@ejemplo.com",
  "nombre": "Nombre",
  "apellido": "Apellido",
  "rol": "OPERADOR",
  "activo": true,
  "created": "2026-01-01T10:00:00.000Z"
}
```

### POST `/auth/login`
Iniciar sesión.

**Request:**
```json
{
  "email": "admin@pingulab.com",
  "password": "admin123"
}
```

**Response:**
```json
{
  "id": 1,
  "email": "admin@pingulab.com",
  "nombre": "Administrator",
  "rol": "ADMIN",
  "activo": true
}
```

### POST `/auth/changePassword`
Cambiar contraseña.

**Request:**
```json
{
  "userId": 1,
  "oldPassword": "admin123",
  "newPassword": "newpassword456"
}
```

**Response:**
```json
{
  "success": true
}
```

### GET `/auth/getAllUsers`
Obtener todos los usuarios (solo ADMIN).

**Response:**
```json
[
  {
    "id": 1,
    "email": "admin@pingulab.com",
    "nombre": "Administrator",
    "rol": "ADMIN",
    "activo": true
  }
]
```

---

## 📋 Quote Endpoint

### POST `/quote/createQuote`
Crear nueva cotización.

**Request:**
```json
{
  "input": {
    "name": "Soporte para Monitor",
    "quantity": 2,
    "pieceWeightGrams": 150.0,
    "printHours": 5.0,
    "postProcessingCost": 0.0,
    "measurements": "200x100x50mm",
    "marginPercent": 0.30,
    "imageUrl": null,
    "customerId": 1,
    "printerId": 1,
    "shippingId": null,
    "filamentUsages": [
      {
        "filamentId": 1,
        "gramsUsed": 150.0
      }
    ],
    "supplyUsages": []
  },
  "userId": 1
}
```

**Response:**
```json
{
  "id": 1,
  "name": "Soporte para Monitor",
  "quantity": 2,
  "pieceWeightGrams": 150.0,
  "printHours": 5.0,
  "filamentCost": 6.00,
  "electricityCost": 0.33,
  "suppliesCost": 0.0,
  "depreciationCost": 0.50,
  "subtotal": 6.83,
  "marginPercent": 0.30,
  "total": 17.75,
  "status": "PENDIENTE",
  "createdBy": 1
}
```

### GET `/quote/getQuoteDetails`
Obtener detalles completos de cotización.

**Request:**
```json
{
  "id": 1
}
```

**Response:**
```json
{
  "quote": { /* objeto quote */ },
  "filamentDetails": [
    {
      "filament": {
        "id": 1,
        "name": "PLA Blanco 1kg",
        "brand": "Creality",
        "materialType": "PLA"
      },
      "gramsUsed": 150.0,
      "cost": 3.00
    }
  ],
  "supplyDetails": [],
  "customer": { /* objeto customer */ },
  "printer": { /* objeto printer */ },
  "shipping": null
}
```

### GET `/quote/getAllQuotes`
Obtener todas las cotizaciones.

**Response:**
```json
[
  {
    "id": 1,
    "name": "Soporte para Monitor",
    "quantity": 2,
    "total": 17.75,
    "status": "PENDIENTE"
  }
]
```

### PUT `/quote/updateQuote`
Actualizar cotización existente.

**Request:**
```json
{
  "quoteId": 1,
  "input": { /* mismo formato que createQuote */ },
  "userId": 1
}
```

### PUT `/quote/updateQuoteStatus`
Actualizar solo el estado de una cotización.

**Request:**
```json
{
  "id": 1,
  "status": "PROCESO"  // PENDIENTE, PROCESO, FINALIZADO, CANCELADO
}
```

### DELETE `/quote/deleteQuote`
Eliminar cotización.

**Request:**
```json
{
  "id": 1
}
```

---

## 👤 Customer Endpoint

### GET `/customer/getAllCustomers`
Obtener todos los clientes.

### GET `/customer/searchCustomers`
Buscar clientes por apodo, nombre o apellido.

**Request:**
```json
{
  "query": "Juan"
}
```

### POST `/customer/createCustomer`
Crear nuevo cliente.

**Request:**
```json
{
  "apodo": "JuanP",
  "nombre": "Juan",
  "apellido": "Pérez",
  "numero": "+1234567890",
  "direccion": "Calle Principal 123",
  "notes": "Cliente frecuente"
}
```

### PUT `/customer/updateCustomer`
Actualizar cliente.

**Request:**
```json
{
  "customerId": 1,
  "apodo": "JuanP",
  "nombre": "Juan",
  "apellido": "Pérez",
  "numero": "+1234567890",
  "direccion": "Calle Principal 123",
  "notes": "Cliente VIP"
}
```

### DELETE `/customer/deleteCustomer`
Eliminar cliente (solo si no tiene cotizaciones).

**Request:**
```json
{
  "customerId": 1
}
```

---

## 🔧 Resources Endpoint

### PRINTERS

#### GET `/resources/getAllPrinters`
Obtener todas las impresoras.

#### GET `/resources/getAvailablePrinters`
Obtener solo impresoras disponibles.

#### POST `/resources/createPrinter`
Crear nueva impresora.

**Request:**
```json
{
  "name": "Creality Ender 3 V2",
  "powerConsumptionWatts": 220,
  "purchaseCost": 250.00,
  "available": true
}
```

#### PUT `/resources/updatePrinter`
Actualizar impresora.

#### DELETE `/resources/deletePrinter`
Eliminar impresora.

---

### FILAMENTS

#### GET `/resources/getAllFilaments`
Obtener todos los filamentos.

#### POST `/resources/createFilament`
Crear nuevo filamento.

**Request:**
```json
{
  "name": "PLA Blanco 1kg",
  "brand": "Creality",
  "materialType": "PLA",
  "spoolWeightKg": 1.0,
  "spoolCost": 20.00
}
```

#### PUT `/resources/updateFilament`
Actualizar filamento.

#### DELETE `/resources/deleteFilament`
Eliminar filamento.

---

### EXTRA SUPPLIES

#### GET `/resources/getAllExtraSupplies`
Obtener todos los suministros extra.

#### POST `/resources/createExtraSupply`
Crear nuevo suministro.

**Request:**
```json
{
  "name": "Tornillo M3 x 10mm",
  "cost": 0.10
}
```

#### PUT `/resources/updateExtraSupply`
Actualizar suministro.

#### DELETE `/resources/deleteExtraSupply`
Eliminar suministro.

---

### SHIPPING

#### GET `/resources/getAllShippings`
Obtener todas las opciones de envío.

#### POST `/resources/createShipping`
Crear nueva opción de envío.

**Request:**
```json
{
  "shippingType": "Express",
  "carrierName": "DHL",
  "cost": 15.00
}
```

#### PUT `/resources/updateShipping`
Actualizar opción de envío.

#### DELETE `/resources/deleteShipping`
Eliminar opción de envío.

---

### ELECTRICITY RATES

#### GET `/resources/getActiveElectricityRate`
Obtener tarifa eléctrica activa.

#### GET `/resources/getAllElectricityRates`
Obtener todas las tarifas eléctricas.

#### POST `/resources/createElectricityRate`
Crear nueva tarifa (auto-desactiva las demás si está activa).

**Request:**
```json
{
  "costPerKwh": 0.15,
  "active": true
}
```

#### PUT `/resources/updateElectricityRate`
Actualizar tarifa eléctrica.

#### DELETE `/resources/deleteElectricityRate`
Eliminar tarifa eléctrica.

---

## 🔢 Status Values

### QuoteStatus
- `PENDIENTE`: Cotización pendiente
- `PROCESO`: En proceso de producción
- `FINALIZADO`: Completado
- `CANCELADO`: Cancelado

### UserRole
- `ADMIN`: Administrador (acceso completo)
- `OPERADOR`: Operador (crear/editar cotizaciones)
- `VIEWER`: Visualizador (solo lectura)

---

## 💡 Calculation Formulas

### Quote Total Calculation
```
Per Piece Cost = filamentCost + electricityCost + suppliesCost + depreciationCost + postProcessingCost

Subtotal = Per Piece Cost × quantity

Total = (Subtotal × (1 + marginPercent)) + shippingCost
```

### Depreciation Calculation
```
Printer Lifespan = 5000 hours (configurable)

Depreciation per hour = purchaseCost / Printer Lifespan

Depreciation Cost = (Depreciation per hour) × printHours × quantity
```

### Filament Cost Calculation
```
Total Grams in Spool = spoolWeightKg × 1000

Cost per Gram = spoolCost / Total Grams

Filament Cost = (gramsUsed × Cost per Gram) × quantity
```

### Electricity Cost Calculation
```
kWh = (powerConsumptionWatts / 1000) × printHours

Electricity Cost = kWh × costPerKwh × quantity
```

---

## 🔐 Default Credentials

| Email | Password | Role |
|-------|----------|------|
| admin@pingulab.com | admin123 | ADMIN |
| operador@pingulab.com | operator123 | OPERADOR |
| viewer@pingulab.com | viewer123 | VIEWER |

**⚠️ IMPORTANT**: Change these passwords in production!

---

## 🛡️ Security Notes

1. Passwords are hashed using SHA256
2. For production, consider using bcrypt or Argon2
3. Implement JWT tokens for session management
4. Add rate limiting to auth endpoints
5. Validate user roles on sensitive endpoints
6. Use HTTPS in production

---

## 📊 Response Codes

- `200 OK`: Successful request
- `400 Bad Request`: Invalid input
- `404 Not Found`: Resource not found
- `500 Internal Server Error`: Server error

---

**Version**: 1.1.0  
**Last Updated**: 2026-01-01
