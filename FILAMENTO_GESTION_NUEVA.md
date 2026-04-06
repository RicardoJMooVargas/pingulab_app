# Gestion de Filamento - Diseno Funcional e Implementacion

## Objetivo
Terminar el flujo de gestion de filamento para:
- Catalogos (inventario real por spool).
- Cotizacion (seleccion inteligente de spool al guardar).
- Venta (impacto automatico en inventario, con autocorreccion si faltan gramos).

## Problema detectado
- La UI de seleccion/obtencion de filamento estaba incompleta y no tomaba una decision consistente de spool real.
- El inventario no quedaba alineado de forma robusta con el momento de venta.
- Se necesitaba tolerancia a desviaciones de calculo (gramos estimados vs consumo real).

## Regla de negocio acordada
1. La cotizacion se arma con una lista generica (material + color + gramos requeridos).
2. Al guardar, el sistema sugiere spool real con esta prioridad:
   1) Filamento preferido (si aplica).
   2) Filamento del mismo catalogo con mas gramos y stock suficiente.
   3) Filamento del mismo catalogo con mas gramos (aunque no alcance).
   4) Ultimo usado del mismo catalogo.
   5) Cualquier filamento del mismo color.
3. Al crear venta:
   - Se descuenta inventario de los filamentos usados en la cotizacion.
   - Si no alcanza inventario, se autocorrige agregando gramos faltantes y luego descontando.
   - Resultado: nunca se bloquea la venta por falta de stock estimado.

## Endpoints implementados
Se implementaron en `ResourcesEndpoint`:

### 1) getFilamentCatalogItems
- Devuelve lista de catalogo material+color (`FilamentCatalogItem`).
- Uso: poblar selector generico en pantalla de cotizacion.

### 2) getFilamentInventoryByCatalog(materialType, color, onlyWithStock)
- Devuelve spools reales del catalogo seleccionado.
- Ordenado por `remainingGrams` descendente.
- Uso: mostrar opciones de spool disponibles para asignacion final.

### 3) suggestFilamentForRequirement(materialType, color, requiredGrams, preferredFilamentId)
- Devuelve sugerencia de spool y motivo de seleccion en JSON.
- Incluye candidatos con `remainingGrams` y `isSufficient`.
- Uso: justo antes de guardar cotizacion, resolver spool por defecto.

### 4) applySaleFilamentInventoryImpact(saleId, autoCorrectIfInsufficient)
- Aplica movimiento de inventario por venta ya creada.
- Si falta stock y `autoCorrectIfInsufficient=true`, agrega faltante y descuenta.
- Retorna reporte JSON por spool (before, addedForCorrection, after, status).

Adicionalmente se integro en `SalesEndpoint`:

### 5) convertQuoteToSale(...)
- Ahora aplica automaticamente impacto de inventario al crear la venta.
- Comportamiento alineado con la regla: la venta no falla por diferencias de gramos.

## Flujo de UI propuesto
1. Pantalla de cotizacion:
   - Seleccion de items genericos (material/color).
   - Captura de gramos por item.
2. Pre-guardar cotizacion:
   - Por cada item, llamar `suggestFilamentForRequirement(...)`.
   - Mostrar sugerencia por defecto y permitir override manual.
3. Guardar cotizacion:
   - Persistir `QuoteFilament` con `filamentId` real y `gramsUsed`.
4. Crear venta:
   - `convertQuoteToSale` descuenta stock automaticamente.
   - Si no alcanza, aplica autocorreccion (agregar faltante y luego descontar).

## Consideraciones
- El inventario queda orientado a continuidad operativa (no bloquea ventas).
- Para auditoria futura se recomienda agregar tabla de movimientos de inventario (entrada/salida/correccion).
- Si se desea exactitud fisica estricta, se puede desactivar autocorreccion por endpoint y forzar confirmacion manual.

## Estado
- Endpoints de backend listos para consumo por interfaz.
- Falta terminar cableado visual completo en pantallas de Catalogos/Cotizacion para usar estas sugerencias de forma guiada.

## Auditoria de interfaz (estado actual)
- No se detecta uso de los nuevos endpoints de inventario inteligente en pantallas Flutter.
- Pantallas revisadas:
   - `pingulab_app_flutter/lib/screens/catalogs_screen.dart`
   - `pingulab_app_flutter/lib/screens/quote_form_screen.dart`
   - `pingulab_app_flutter/lib/screens/quote_details_screen.dart`
- Hallazgo principal:
   - Actualmente se trabaja con seleccion directa de `Filament` y gramos, pero no con selector generico `materialType + color` ni sugerencia de spool.

## Estado de tablas y migraciones
- Las nuevas entidades aparecen en el schema generado de Serverpod:
   - `filament_catalog_items`
   - `sale_filament_consumptions`
   - Columna `remainingGrams` en `filaments`
- Se creo una nueva migracion en:
   - `pingulab_app_server/migrations/20260406044143144`
- Se ajusto `migration.sql` para que sea segura en produccion (sin DROP de `filaments`).

## Estrategia de despliegue por pull (API + server)
Contexto: cada pull dispara despliegue automatico.

1. Confirmar que el pull incluya:
    - Cambios de modelos/endpoints.
    - Carpeta de migracion nueva.
    - `migration_registry.txt` actualizado.
2. El deploy debe seguir ejecutando:
    - `./server --apply-migrations --mode=production`
3. La migracion nueva es aditiva:
    - Crea tablas nuevas si no existen.
    - Agrega `remainingGrams` y backfill con `spoolWeightKg * 1000`.
    - Evita perdida de datos de `filaments`.
4. Verificacion post-deploy recomendada (SQL):
    - `select column_name from information_schema.columns where table_name='filaments' and column_name='remainingGrams';`
    - `select to_regclass('public.filament_catalog_items');`
    - `select to_regclass('public.sale_filament_consumptions');`

## Siguiente implementacion en UI
1. Cotizacion: selector generico por catalogo (`materialType`, `color`).
2. Pre-guardado: usar `suggestFilamentForRequirement` para sugerencia por defecto.
3. Confirmacion: permitir override de spool antes de guardar.
4. Venta: mostrar resultado de ajuste de inventario (normal o autocorregido).
