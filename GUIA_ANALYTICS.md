# Guía de Finalización - Endpoint de Análisis

## 📋 Estado Actual

Se han creado e implementado exitosamente:

✅ **Backend**:
- Nuevo archivo: `lib/src/endpoints/analytics_endpoint.dart`
- Contiene: 6 métodos para análisis de ventas, ganancias y amortización

✅ **Frontend**:
- Nueva pantalla: `lib/screens/analytics_screen.dart` (con gráficas interactivas)
- Dependencia: `fl_chart: ^0.68.0` (agregada a pubspec.yaml)
- Integración: Botón en `lib/screens/backup_screen.dart`

## 🚀 Próximos Pasos - Para Activar

### 1. Generar código Serverpod

Ejecuta en terminal desde la carpeta del servidor:

```bash
cd pingulab_app_server

# Instala serverpod si no lo tienes
dart pub global activate serverpod_cli

# Genera el código
serverpod generate
```

**Esto generará automáticamente**:
- Cliente actualizado en `pingulab_app_client/`
- Endpoint registrado en `lib/src/generated/endpoints.dart`
- Métodos cliente en `pingulab_app_client/lib/src/client.dart`

### 2. Actualizar dependencias en Flutter

```bash
cd pingulab_app_flutter

# Obtiene la nueva dependencia fl_chart
flutter pub get

# Sincroniza con el cliente actualizado
flutter pub upgrade pingulab_app_client
```

### 3. Executar la aplicación

```bash
flutter run
```

## 📊 Características Implementadas

### Endpoint: `AnalyticsEndpoint`

#### 1. `getMonthlySalesData()`
- **Parámetros**: `monthsBack` (default: 12)
- **Retorna**: 
  ```dart
  {
    'months': ['2025-04', '2025-05', ...],
    'totalSales': [1000.0, 1500.0, ...],
    'totalRevenue': 18000.0
  }
  ```

#### 2. `getNetProfitData()`
- **Parámetros**: `monthsBack` (default: 12)
- **Calcula**: Ganancia = Ventas - (Filamento + Electricidad + Suministros + Depreciación)
- **Retorna**: Datos mensuales de ganancias netas

#### 3. `getPrinterDepreciationData()`
- **Parámetros**: `depreciationYears` (default: 5)
- **Calcula**: Depreciación mensual, porcentaje de uso, horas totales
- **Retorna**: Datos detallados por impresora

#### 4. `getSalesVsCostsAnalysis()`
- **Análisis**: Comparación mes a mes de ventas vs costos
- **Desglose**: Filamentos, Electricidad, Suministros, Depreciación
- **Retorna**: Datos completos con totales

#### 5. `getCategoryProfitabilityData()`
- **Análisis**: Rentabilidad por categoría de cotización
- **Métricas**: Ingresos, Costos, Ganancia, Margen de Ganancia %

#### 6. `getOverallMetrics()`
- **Comparación**: Mes actual vs mes anterior
- **Cambios**: Porcentajes de cambio en ingresos y ganancias
- **Totales**: Cantidad de clientes y cotizaciones

### Pantalla: `AnalyticsScreen`

**Gráficas Implementadas**:

1. **Tarjetas de Métricas**
   - Ingresos del mes
   - Ganancias del mes
   - Número de ventas
   - Total de clientes

2. **Gráfica de Ventas Mensuales** (LineChart)
   - Eje Y: Ventas en dólares
   - Eje X: Meses (últimos 12)
   - Línea azul con puntos interactivos

3. **Gráfica de Ganancias Netas** (LineChart)
   - Eje Y: Ganancias en dólares
   - Color dinámico (verde/naranja según rentabilidad)
   - Puntos interactivos

4. **Análisis Ventas vs Costos** (LineChart Dual)
   - Línea azul: Ventas totales
   - Línea roja: Costos totales
   - Tabla resumida con totales

5. **Amortización de Impresoras** (BarChart + Tabla)
   - Gráfica de barras con porcentaje de uso (0-100%)
   - Colores: Verde (< 25%), Verde claro (25-50%), Naranja (50-75%), Rojo (> 75%)
   - Tabla con detalles por cada impresora

## 🔄 Flujo de Conexión

```
BackupScreen
    ↓
[Botón "Análisis de Ventas"]
    ↓
AnalyticsScreen
    ↓
    ├→ client.analytics.getMonthlySalesData()
    ├→ client.analytics.getNetProfitData()
    ├→ client.analytics.getPrinterDepreciationData()
    ├→ client.analytics.getSalesVsCostsAnalysis()
    └→ client.analytics.getOverallMetrics()
    ↓
Backend (AnalyticsEndpoint)
    ↓
Base de Datos ← Fetch Sales, Quotes, Printers, Categories
```

## 🎯 Fórmulas de Cálculo

### Ganancia Neta (Net Profit)
```
Ganancia = Ingresos Venta - Costos Totales
Costos Totales = Filamento + Electricidad + Suministros + Depreciación
```

### Amortización de Impresoras
```
Depreciation_Mensual = Costo_Compra / (Años_VidaÚtil × 12)
Uso_Porcentaje = (Horas_Impresión / (Años × 365 × 24)) × 100
```

### Cambio Porcentual
```
Cambio% = ((Valor_Actual - Valor_Anterior) / Valor_Anterior) × 100
```

## 📱 Interfaz Visual

La pantalla incluye:
- **AppBar**: Con título y botón de refrescar
- **Indicador de carga**: CircularProgressIndicator
- **Manejo de errores**: Mensaje de error con botón de reintentar
- **ScrollView**: Para desplazar por todas las gráficas
- **Cards**: Cada sección en una tarjeta elevada (elevation: 4)
- **Colores temáticos**: DeepPurple para el app bar, códigos de color para estados

## 🔍 Validaciones Implementadas

- ✅ Ventas vacías: Manejo de listas sin datos
- ✅ Impresoras sin uso: Porcentaje en 0%
- ✅ Divisiones por cero: Manejo de `monthlyData.isEmpty`
- ✅ Null safety: Operadores seguros en toda la lógica

## 🐛 Posibles Mejoras Futuras

1. Exportar gráficas como PDF
2. Filtros por rango de fechas personalizadas
3. Análisis de tendencias con predicciones
4. Comparación multi-año
5. Alertas de baja rentabilidad
6. Reportes programados por email

## ✅ Verificación

Antes de ejecutar, verifica:

- [ ] Archivo `analytics_endpoint.dart` existe sin errores de sintaxis
- [ ] Archivo `analytics_screen.dart` existe sin errores de sintaxis
- [ ] Archivo `backup_screen.dart` actualizado con botón de análisis
- [ ] `pubspec.yaml` incluye `fl_chart: ^0.68.0`
- [ ] Comando `serverpod generate` ejecutado exitosamente
- [ ] `flutter pub get` ejecutado en la carpeta del cliente
- [ ] `flutter pub get` ejecutado en la carpeta Flutter

## 📞 Soporte

Si encuentras errores tras ejecutar `serverpod generate`:

1. **Error de importación**: Verifica que `analytics_endpoint.dart` esté en `lib/src/endpoints/`
2. **Errores de tipos**: Revisa que los modelos (Sale, Quote, etc.) estén disponibles
3. **Error de cliente**: Asegúrate que el cliente fue regenerado

