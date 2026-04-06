# Implementación de Endpoint de Análisis de Ventas

## 📌 Resumen Ejecutivo

Se ha implementado un **endpoint de análisis completo** con **6 métodos** para obtener datos sobre:

- 📈 **Ventas mensuales** (últimos 12 meses)
- 💰 **Ganancias netas** (Ingresos - Costos)
- 🖨️ **Amortización de impresoras** (Depreciación y uso)
- 📊 **Análisis comparativo** (Ventas vs Costos)

Se integró una **pantalla visual** con gráficas interactivas usando `fl_chart`.

---

## 🏗️ Estructura de Archivos

### Backend
```
pingulab_app_server/
└── lib/src/endpoints/
    └── analytics_endpoint.dart (NUEVO - 400+ líneas)
```

### Frontend
```
pingulab_app_flutter/
└── lib/screens/
    ├── analytics_screen.dart (NUEVO - 500+ líneas)
    └── backup_screen.dart (MODIFICADO - agregado botón)
```

### Configuración
```
pingulab_app_flutter/
└── pubspec.yaml (MODIFICADO - agregado fl_chart)
```

---

## 📊 Métodos del Endpoint

### 1. `getMonthlySalesData(int monthsBack)`

**Propósito**: Obtener total de ventas por mes

**Lógica**:
- Filtra ventas en los últimos N meses
- Agrupa por mes-año
- Suma totales por mes

**Retorna**:
```dart
{
  'months': ['2025-04', '2025-05', ...],
  'totalSales': [1000.0, 1500.0, ...],
  'totalRevenue': 18000.0
}
```

### 2. `getNetProfitData(int monthsBack)`

**Propósito**: Calcular ganancias netas mensuales

**Fórmula**:
```
Ganancia = Venta.totalAmount - (Quote.filamentCost + electricityCost + suppliesCost + depreciationCost)
```

**Retorna**: Datos mensuales de ganancias

### 3. `getPrinterDepreciationData(int depreciationYears)`

**Propósito**: Analizar depreciación de impresoras

**Cálculos**:
- Depreciation mensual = purchaseCost / (años × 12)
- Uso% = (horasImpresión / (años × 365 × 24)) × 100
- Agrupa por impresora

**Retorna**:
```dart
{
  'printers': [
    {
      'printerName': 'PrusaI3',
      'printerId': 1,
      'purchaseCost': 500.0,
      'monthlyDepreciation': 8.33,
      'depreciationPercentage': 23.5,
      'totalPrintHours': 150.5
    }
  ],
  'totalDepreciation': 500.0,
  'averageDepreciation': 250.0
}
```

### 4. `getSalesVsCostsAnalysis(int monthsBack)`

**Propósito**: Comparar ventas vs costos por mes

**Retorna**: 
- Mes a mes desglose de costos (Filamento, Electricidad, Suministros, Depreciación)
- Cálculo de ganancia por mes
- Totales acumulados

### 5. `getCategoryProfitabilityData()`

**Propósito**: Medir rentabilidad por categoría

**Retorna**:
```dart
{
  'categories': [
    {
      'categoryName': 'Figuras',
      'quoteCount': 15,
      'totalRevenue': 5000.0,
      'totalCosts': 2000.0,
      'profit': 3000.0,
      'profitMargin': '60.00%'
    }
  ]
}
```

### 6. `getOverallMetrics()`

**Propósito**: Resumen general mes actual vs mes pasado

**Retorna**:
```dart
{
  'thisMonth': {
    'revenue': 10000.0,
    'costs': 4000.0,
    'profit': 6000.0,
    'sales': 12
  },
  'lastMonth': {
    'revenue': 8000.0,
    'costs': 3500.0,
    'profit': 4500.0,
    'sales': 10
  },
  'changes': {
    'revenueChange': 25.0,
    'profitChange': 33.33
  },
  'totals': {
    'customers': 45,
    'quotes': 89
  }
}
```

---

## 🎨 Componentes de la Pantalla

### AnalyticsScreen

**Widget raíz**: `StatefulWidget`

**Ciclo de vida**:
1. `initState()` → Carga datos del endpoint
2. `_loadAnalyticsData()` → Llama a todos los métodos del endpoint
3. `build()` → Renderiza gráficas y datos

**Estructura de UI**:
```
Scaffold
├── AppBar (con botón refresh)
├── Body
│   ├── CircularProgressIndicator (si loading)
│   ├── ErrorWidget (si error)
│   └── SingleChildScrollView
│       └── Column
│           ├── MetricsCards (4 tarjetas)
│           ├── SalesChart (LineChart)
│           ├── ProfitChart (LineChart)
│           ├── CostsAnalysisChart (LineChart dual)
│           └── DepreciationChart (BarChart + Tabla)
```

### Gráficas Implementadas

#### 1. SalesChart (LineChart)
- **Tipo**: Gráfica de líneas
- **Eje X**: Meses
- **Eje Y**: Ventas ($)
- **Interactividad**: Puntos con tooltips

#### 2. ProfitChart (LineChart)
- **Tipo**: Gráfica de líneas
- **Color**: Verde (positive) / Naranja (negative)
- **Eje Y**: Ganancia ($)

#### 3. CostsAnalysisChart (LineChart Dual)
- **Línea 1** (Azul): Ventas totales
- **Línea 2** (Rojo): Costos totales
- **Tabla**: Resumen abajo

#### 4. DepreciationChart (BarChart + DetailedTable)
- **Gráfica**: Barras de % de uso (0-100%)
- **Colores**:
  - Verde: 0-25%
  - Verde claro: 25-50%
  - Naranja: 50-75%
  - Rojo: 75-100%
- **Tabla**: Detalles por impresora

---

## 🔌 Integración en BackupScreen

**Cambios**:
1. Importar `analytics_screen.dart`
2. Agregar Card con ListTile que navega a AnalyticsScreen

**Código**:
```dart
Card(
  child: ListTile(
    leading: const CircleAvatar(
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.analytics, color: Colors.white),
    ),
    title: const Text('Análisis de Ventas'),
    subtitle: const Text('Gráficas de ventas, ganancias y amortización'),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
      );
    },
  ),
)
```

---

## 🔄 Flujo de Datos

```
BackupScreen
    ↓ [Tap "Análisis de Ventas"]
AnalyticsScreen → initState()
    ↓
_loadAnalyticsData()
    ├→ client.analytics.getMonthlySalesData()
    ├→ client.analytics.getNetProfitData()
    ├→ client.analytics.getPrinterDepreciationData()
    ├→ client.analytics.getSalesVsCostsAnalysis()
    ├→ client.analytics.getCategoryProfitabilityData()
    └→ client.analytics.getOverallMetrics()
    ↓
AnalyticsEndpoint (Backend)
    ├→ Query Sale.db.find()
    ├→ Query Quote.db.find()
    ├→ Query Printer.db.find()
    └→ Query QuoteCategory.db.find()
    ↓
setState() → Renderizar gráficas
```

---

## ⚙️ Configuración Requerida

### pubspec.yaml (Flutter)
```yaml
dependencies:
  fl_chart: ^0.68.0  # Nueva dependencia
```

### generator.yaml (Serverpod)
```yaml
type: server
client_package_path: ../pingulab_app_client
```

---

## 🚀 Pasos de Activación

1. **Serverpod Generate**:
   ```bash
   cd pingulab_app_server
   dart pub global activate serverpod_cli
   serverpod generate
   ```

2. **Flutter Get**:
   ```bash
   cd pingulab_app_flutter
   flutter pub get
   ```

3. **Run**:
   ```bash
   flutter run
   ```

---

## 📋 Casos de Uso

### Casos de éxito
- ✅ Mostrar tendencias de ventas
- ✅ Comparar ingresos mes a mes
- ✅ Identificar márgenes de ganancia
- ✅ Monitorear deprecación de equipos
- ✅ Detectar categorías rentables

### Manejo de errores
- ✅ Si no hay ventas: Gráficas vacías con mensaje
- ✅ Si no hay impresoras: Mensaje "No hay impresoras"
- ✅ Si hay errores en API: Muestra SnackBar con mensaje
- ✅ Botón "Reintentar" siempre disponible

---

## 🎯 Validaciones

- **Null Safety**: Todos los valores nullable están validados
- **Divisiones**: Se valida antes de dividir por cero
- **Rango de fechas**: Se valida que existan datos para el rango
- **Colores dinámicos**: Según valores positivos/negativos

---

## 📝 Notas Importantes

1. **Datos en Tiempo Real**: Las gráficas se actualizan al recargar
2. **Performance**: Carga máximo 2 años de datos (evita sobrecarga)
3. **Precisión**: Dinero mostrado con 2 decimales
4. **Timestamps**: Todas las fechas se convierten a formato local
5. **Responsivo**: Gráficas se adaptan al tamaño de pantalla

---

## 🔍 Debugging

Si hay errores post-generación:

1. **Verificar imports**: Todos los modelos deben estar disponibles
2. **Revisar `protocol.dart`**: Debe incluir todos los modelos
3. **Limpiar caché**: `flutter clean && flutter pub get`
4. **Verificar SQL**: Las queries deben coincidir con BD real

