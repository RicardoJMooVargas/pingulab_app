# Sistema de Cotizaciones PinguLab - Guía de Uso

## ✅ Estado Actual del Sistema

### Servidor Backend (Serverpod)
- ✅ Base de datos PostgreSQL con todas las tablas creadas
- ✅ Endpoint `quote` para CRUD de cotizaciones
- ✅ Endpoint `resources` para cargar catálogos (filamentos, impresoras, etc.)
- ✅ Cálculo automático de costos

### Aplicación Flutter
- ✅ Pantalla de lista de cotizaciones
- ✅ Pantalla de detalles con desglose completo
- ✅ Formulario para crear/editar cotizaciones
- ✅ Integración con servidor

## 🗂️ Tablas en la Base de Datos

1. **filaments** - Catálogo de filamentos disponibles
2. **printers** - Impresoras disponibles con su consumo
3. **electricity_rates** - Tarifa eléctrica activa
4. **extra_supplies** - Insumos extra (pegamento, lija, etc.)
5. **shippings** - Opciones de envío
6. **quotes** - Cotizaciones principales
7. **quote_filaments** - Filamentos usados por cotización
8. **quote_extra_supplies** - Insumos usados por cotización

## 📊 Datos de Prueba Insertados

### Filamentos (5)
- PLA Negro - Creality - 1kg - $25
- PLA Blanco - Sunlu - 1kg - $22
- ABS Rojo - Esun - 1kg - $30
- PETG Transparente - Overture - 1kg - $28
- TPU Flexible - Sunlu - 0.5kg - $35

### Impresoras (3)
- Ender 3 V2 - 350W - Disponible
- Prusa i3 MK3S+ - 120W - Disponible
- Creality CR-10 - 400W - No disponible

### Insumos Extra (5)
- Pegamento - $5
- Lija 400 - $2.50
- Pintura Spray - $15
- Tornillos M3 - $3
- Resina para acabado - $12

### Envíos (4)
- Local (Entrega Personal) - $0
- Nacional Estándar (Estafeta) - $120
- Nacional Express (DHL) - $250
- Local Motorizado (Mensajero) - $50

### Tarifa Eléctrica
- $0.15 por kWh (activa)

## 🚀 Cómo Usar la Aplicación

### 1. Crear una Nueva Cotización

1. Presiona el botón **+** en la pantalla principal
2. Completa los datos básicos:
   - **Gramos a imprimir**: Peso total de la pieza
   - **Horas de impresión**: Tiempo que tardará
   - **Medidas** (opcional): Dimensiones de la pieza
   - **Post-procesado** (opcional): Costo adicional de acabado

3. Selecciona la **Impresora** (afecta el cálculo de electricidad)

4. Agrega **Filamentos**:
   - Haz clic en "Agregar filamento"
   - Selecciona el filamento del catálogo
   - Verás info del rollo completo (peso total, costo)
   - Ingresa los **gramos que usarás** para esta impresión
   - El sistema calculará el costo proporcional

5. Agrega **Insumos Extra** (opcional):
   - Pegamento, lijas, pintura, etc.
   - Especifica la cantidad

6. Selecciona **Método de Envío** (opcional)

7. Define el **Margen de Ganancia**:
   - Ejemplo: 0.30 = 30% de margen
   - Ejemplo: 0.50 = 50% de margen

8. Selecciona el **Estado**:
   - PENDIENTE
   - EN PROCESO
   - FINALIZADO
   - CANCELADO

9. Presiona **"Crear Cotización"**

### 2. Ver Detalles de una Cotización

- Toca cualquier cotización en la lista
- Verás el desglose completo:
  - Total y subtotal
  - Filamentos usados con costos
  - Insumos extra
  - Costos de electricidad
  - Margen aplicado
  - Envío

### 3. Editar una Cotización

- Desde los detalles, presiona el ícono de editar (lápiz)
- Modifica los datos necesarios
- Los costos se recalculan automáticamente

### 4. Cambiar Estado

- Desde los detalles, toca los 3 puntos verticales
- Selecciona el nuevo estado

### 5. Eliminar una Cotización

- Desde los detalles, presiona el ícono de eliminar (basurero)
- Confirma la eliminación

## 💡 Cómo Funciona el Cálculo

### Costo de Filamento
```
Costo = (Gramos Usados / Gramos Totales del Rollo) × Costo del Rollo
Ejemplo: (150g / 1000g) × $25 = $3.75
```

### Costo de Electricidad
```
kWh = (Watts de Impresora / 1000) × Horas de Impresión
Costo = kWh × Tarifa por kWh
Ejemplo: (350W / 1000) × 8.5h × $0.15 = $0.45
```

### Subtotal
```
Subtotal = Filamento + Electricidad + Insumos + Post-procesado
```

### Total Final
```
Total = Subtotal × (1 + Margen) + Envío
Ejemplo: $21.70 × 1.30 + $50 = $78.21
```

## 🔧 Comandos Útiles

### Servidor
```powershell
# Iniciar servidor
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_server
dart run bin/main.dart

# Generar código después de cambios
serverpod generate

# Crear nueva migración
serverpod create-migration

# Aplicar migraciones
dart bin/main.dart --apply-migrations
```

### Aplicación Flutter
```powershell
# Ejecutar en Windows
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_flutter
flutter run -d windows

# Hot reload (en la app corriendo)
# Presiona 'r' en la terminal

# Hot restart (en la app corriendo)
# Presiona 'R' en la terminal
```

### Base de Datos
```powershell
# Conectar a PostgreSQL
docker exec -it pingulab_app_server-postgres-1 psql -U postgres -d pingulab_app

# Ver todas las cotizaciones
SELECT * FROM quotes;

# Ver filamentos disponibles
SELECT * FROM filaments;

# Ver detalles de una cotización
SELECT q.*, p.name as printer_name 
FROM quotes q 
LEFT JOIN printers p ON q."printerId" = p.id 
WHERE q.id = 1;
```

## 📝 Notas Importantes

1. **Gramos en Filamentos**: Cuando agregas un filamento a una cotización, los gramos se refieren a cuánto vas a USAR, no cuánto tiene el rollo completo.

2. **Cálculo Automático**: El sistema calcula automáticamente todos los costos basándose en:
   - Proporción del rollo de filamento usado
   - Consumo eléctrico de la impresora seleccionada
   - Cantidades de insumos extra

3. **Estados**: El cambio de estado no afecta los costos, solo es para seguimiento.

4. **Datos Necesarios**: Para crear una cotización válida necesitas al menos:
   - Gramos a imprimir
   - Horas de impresión
   - Al menos un filamento
   - Margen de ganancia

## 🐛 Solución de Problemas

### No se ven filamentos/impresoras
- Verifica que el servidor esté corriendo
- Revisa que los datos estén en la base de datos
- Reinicia la aplicación Flutter

### Error al crear cotización
- Asegúrate de agregar al menos un filamento
- Verifica que todos los campos requeridos estén completos
- Revisa los logs del servidor

### No se calculan los costos
- Verifica que haya una tarifa eléctrica activa
- Asegura que la impresora esté seleccionada
- Los filamentos deben tener precio configurado

## 🎯 Próximos Pasos Sugeridos

1. Agregar autenticación y login
2. Crear pantalla de catálogo público
3. Agregar carga de imágenes
4. Exportar cotizaciones a PDF
5. Envío de cotizaciones por email
6. Dashboard con estadísticas
7. Historial de cambios en cotizaciones

---

## 🚀 Cómo Ejecutar el Sistema Completo

### Paso 1: Iniciar Docker (Base de Datos)

```powershell
# Navega al directorio del servidor
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_server

# Inicia los contenedores de PostgreSQL y Redis
docker compose up -d

# Verifica que estén corriendo
docker compose ps
```

Deberías ver:
- `pingulab_app_server-postgres-1` en puerto 8090
- `pingulab_app_server-redis-1` en puerto 8091

### Paso 2: Iniciar el Servidor Serverpod

Abre una nueva terminal PowerShell:

```powershell
# Navega al directorio del servidor
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_server

# Inicia el servidor
dart run bin/main.dart
```

El servidor estará listo cuando veas:
```
Server default listening on port 8080
Insights listening on port 8081
Webserver listening on port 8082
```

**⚠️ Mantén esta terminal abierta** mientras uses la aplicación.

### Paso 3: Iniciar la Aplicación Flutter

Abre **otra** terminal PowerShell:

```powershell
# Navega al directorio de Flutter
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_flutter

# Ejecuta la aplicación en Windows
flutter run -d windows
```

Espera a que compile (primera vez puede tardar ~20 segundos).

La aplicación se abrirá automáticamente cuando esté lista.

### Paso 4: ¡Listo! 🎉

Ahora puedes:
1. Ver la lista de cotizaciones (al inicio estará vacía)
2. Presionar el botón **+** para crear tu primera cotización
3. Seleccionar filamentos, impresoras y configurar los costos
4. Ver el cálculo automático del total

---

## 🛑 Detener el Sistema

### Detener la Aplicación Flutter
En la terminal de Flutter, presiona:
```
q
```

### Detener el Servidor Serverpod
En la terminal del servidor, presiona:
```
Ctrl + C
```

### Detener Docker (opcional)
Si quieres detener los contenedores de base de datos:
```powershell
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_server
docker compose down
```

---

## 🔄 Reiniciar Después de Cambios

### Si modificaste modelos (.yaml)
```powershell
# Terminal 1: Regenerar código
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_server
serverpod generate

# Terminal 2: Reiniciar servidor (Ctrl+C y luego)
dart run bin/main.dart

# Terminal 3: Hot restart en Flutter (presiona en la terminal)
R
```

### Si modificaste endpoints (.dart del servidor)
```powershell
# Terminal 1: Regenerar código
cd c:\Users\Eltra\Repos\pingulab_app\pingulab_app_server
serverpod generate

# Terminal 2: Reiniciar servidor (Ctrl+C y luego)
dart run bin/main.dart

# Terminal 3: Hot restart en Flutter
R
```

### Si modificaste UI de Flutter (.dart del flutter)
```powershell
# En la terminal de Flutter, presiona
r   # Hot reload (más rápido)
# o
R   # Hot restart (si el hot reload no funciona)
```

---

## 📋 Checklist de Verificación

Antes de empezar a usar el sistema, verifica:

- [ ] Docker Desktop está corriendo
- [ ] Contenedores de PostgreSQL y Redis están activos
- [ ] Servidor Serverpod muestra "listening on port 8080"
- [ ] Aplicación Flutter se abrió correctamente
- [ ] Puedes ver la pantalla de lista de cotizaciones

Si algo falla:
1. Revisa la sección "🐛 Solución de Problemas"
2. Verifica los logs en las terminales
3. Asegúrate de que los puertos 8080, 8090 no estén ocupados

---

## 💻 Comandos Rápidos de Inicio

### Script de Inicio Rápido (PowerShell)

Puedes crear un archivo `iniciar.ps1` en la raíz del proyecto:

```powershell
# iniciar.ps1
Write-Host "🚀 Iniciando Sistema PinguLab..." -ForegroundColor Cyan

# Verificar Docker
Write-Host "`n📦 Iniciando Docker..." -ForegroundColor Yellow
cd pingulab_app_server
docker compose up -d

Start-Sleep -Seconds 3

# Iniciar servidor en nueva ventana
Write-Host "`n🔧 Iniciando Servidor..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; dart run bin/main.dart"

Start-Sleep -Seconds 5

# Iniciar Flutter en nueva ventana
Write-Host "`n📱 Iniciando Aplicación Flutter..." -ForegroundColor Yellow
cd ..\pingulab_app_flutter
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; flutter run -d windows"

Write-Host "`n✅ Sistema iniciado!" -ForegroundColor Green
Write-Host "Cierra esta ventana cuando termines de trabajar.`n" -ForegroundColor Cyan
```

Ejecútalo con:
```powershell
.\iniciar.ps1
```

