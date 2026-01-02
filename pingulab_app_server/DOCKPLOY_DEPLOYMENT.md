# ✅ Checklist de Deployment en Dockploy

## ⚠️ PROBLEMAS CRÍTICOS ENCONTRADOS Y SOLUCIONADOS

### 1. Migraciones manuales no compatibles con Serverpod
**PROBLEMA:** Tienes migraciones manuales SQL que NO serán aplicadas por `--apply-migrations`:
- `migrate_preserve_data.sql`
- `migration_add_users_and_updates.sql`
- `rename_columns.sql`
- `add_color_and_image.sql`

**SOLUCIÓN:** Estas migraciones YA deben estar aplicadas en tu base de datos de desarrollo. En producción debes:
1. Partir de un dump de la base de datos actual
2. O ejecutar estas migraciones manualmente ANTES del primer deploy

### 2. Usuarios administradores no se crean automáticamente
**PROBLEMA:** El endpoint `InitEndpoint` crea usuarios admin, pero solo se ejecuta cuando la app Flutter se conecta.

**SOLUCIÓN RECOMENDADA:** Agregar la creación de usuarios al script de entrypoint del Docker.

---

## 📋 PASOS PARA DEPLOYMENT EN DOCKPLOY

### Paso 1: Configurar variables de entorno
En Dockploy, configura estas variables de entorno:

```bash
POSTGRES_PASSWORD=tu_password_super_segura_aqui_123
REDIS_PASSWORD=tu_redis_password_segura_aqui_456
```

**IMPORTANTE:** Usa contraseñas fuertes y diferentes a las de desarrollo.

### Paso 2: Preparar la base de datos

#### Opción A - Importar desde desarrollo (RECOMENDADO)
```bash
# En tu máquina de desarrollo, exportar datos:
pg_dump -h localhost -p 8090 -U postgres -d pingulab_app -F c -f pingulab_backup.dump

# Copiar a producción y restaurar:
pg_restore -h <host_produccion> -U postgres -d pingulab_app pingulab_backup.dump
```

#### Opción B - Aplicar migraciones manuales
Si quieres partir de cero, ejecuta en orden:
1. Deja que Serverpod aplique las 6 migraciones oficiales
2. Ejecuta manualmente los scripts SQL custom:
   - `migration_add_users_and_updates.sql`
   - `rename_columns.sql`
   - `add_color_and_image.sql`

### Paso 3: Configurar en Dockploy

1. **Crear nuevo servicio de tipo "Compose"**
2. **Ruta del compose file:** `./docker-compose.production.yaml`
3. **Variables de entorno:** Agregar `POSTGRES_PASSWORD` y `REDIS_PASSWORD`
4. **Dominio:** Configurar los 3 subdominios:
   - API: `api3d.mogastisolutions.engineer` → puerto 8080
   - Insights: `insights.api3d.mogastisolutions.engineer` → puerto 8081
   - Web: `app.api3d.mogastisolutions.engineer` → puerto 8082

### Paso 4: Verificar configuración DNS
Asegúrate de tener los registros A/CNAME apuntando a tu servidor:
```
api3d.mogastisolutions.engineer → IP_SERVIDOR
insights.api3d.mogastisolutions.engineer → IP_SERVIDOR
app.api3d.mogastisolutions.engineer → IP_SERVIDOR
```

### Paso 5: Deploy inicial
1. Click en "Deploy" en Dockploy
2. Monitorea los logs para verificar:
   - ✅ "Configuring passwords..."
   - ✅ "Applying migrations..." o "Migrations already applied"
   - ✅ "Starting Serverpod..."
   - ✅ "Server started on port 8080"

### Paso 6: Crear usuarios iniciales
**OPCIÓN A - Desde la app Flutter:**
La primera vez que la app se conecte, llamará a `InitEndpoint.initializeDatabase()`

**OPCIÓN B - Manualmente vía psql:**
```sql
INSERT INTO users (email, "passwordHash", nombre, apellido, rol, activo, created)
VALUES 
  ('admin@pingulab.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Admin', 'Principal', 0, TRUE, NOW()),
  ('operador@pingulab.com', '6ca8a22e0f87d7ad0a072f0ac4fd89e8f5b2c2e93c0d95e0c9a3d1dbb4ff5a59', 'Operador', 'General', 1, TRUE, NOW()),
  ('viewer@pingulab.com', '2c2da6f8c4f51e6dc59b5a8dbf23432f3e8f2b72a1cd19d1e7f8c0e5b3a1d4f2', 'Viewer', 'Solo lectura', 2, TRUE, NOW());
```

Contraseñas: admin123, operador123, viewer123

---

## 🔍 VERIFICACIONES POST-DEPLOYMENT

### 1. Health Checks
```bash
# PostgreSQL
docker exec pingulab_postgres pg_isready -U postgres

# Redis
docker exec pingulab_redis redis-cli -a $REDIS_PASSWORD ping

# API Server
curl https://api3d.mogastisolutions.engineer/health
```

### 2. Verificar logs
```bash
docker logs pingulab_api -f
```

Busca mensajes de error o warnings.

### 3. Test de endpoints desde Flutter
Actualiza la URL en tu app Flutter:
```dart
final client = Client(
  'https://api3d.mogastisolutions.engineer/',
  authenticationKeyManager: FlutterAuthenticationKeyManager(),
)..connectivityMonitor = FlutterConnectivityMonitor();
```

---

## 🔧 CONFIGURACIÓN ACTUAL

### Puertos expuestos
- **8080:** API Server (HTTP → HTTPS vía proxy reverso)
- **8081:** Insights Server
- **8082:** Web Server

### Volúmenes persistentes
- `postgres_data` → Base de datos
- `redis_data` → Cache

### Network
- `pingulab_network` (bridge) → Comunicación entre contenedores

---

## ⚠️ NOTAS IMPORTANTES

1. **SSL/TLS:** Dockploy debería manejar automáticamente los certificados Let's Encrypt

2. **Backups:** Configura backups automáticos del volumen `postgres_data`
   ```bash
   docker run --rm -v pingulab_app_server_postgres_data:/data \
     -v $(pwd)/backups:/backup alpine tar czf /backup/postgres_$(date +%Y%m%d).tar.gz /data
   ```

3. **Migraciones futuras:** 
   - Serverpod aplicará automáticamente nuevas migraciones en el registry
   - Si haces cambios manuales en la DB, documéntalos en `migrations/`

4. **Monitoreo:** Usa el Insights server para ver logs y métricas en tiempo real

5. **Primer inicio puede tardar:** La compilación Dart y aplicación de migraciones toman ~2-3 minutos

---

## 🚨 TROUBLESHOOTING

### Error: "Could not connect to database"
- Verifica `POSTGRES_PASSWORD` en variables de entorno
- Espera a que PostgreSQL esté healthy (puede tardar 30s)

### Error: "Redis connection failed"
- Verifica `REDIS_PASSWORD` en variables de entorno
- Verifica que el contenedor redis esté corriendo

### Error: "Migration failed"
- El script continúa aunque falle la migración
- Verifica logs con `docker logs pingulab_api`
- Aplica migraciones manuales si es necesario

### Los usuarios admin no existen
- Opción 1: Abre la app Flutter y espera que se auto-creen
- Opción 2: Ejecuta el SQL de creación de usuarios manualmente

---

## ✅ CHECKLIST FINAL ANTES DE DEPLOY

- [ ] Variables `POSTGRES_PASSWORD` y `REDIS_PASSWORD` configuradas
- [ ] Dominios DNS apuntando al servidor
- [ ] Backup de base de datos de desarrollo (si vas a migrar datos)
- [ ] Revisar `config/production.yaml` con los dominios correctos
- [ ] Certificados SSL configurados en Dockploy
- [ ] Plan de rollback en caso de fallo
- [ ] Credenciales de admin disponibles para primer login

---

## 📱 CONFIGURACIÓN DE LA APP FLUTTER

Recuerda actualizar la URL del servidor en tu app:

```dart
// lib/main.dart
final client = Client(
  'https://api3d.mogastisolutions.engineer/',
  authenticationKeyManager: FlutterAuthenticationKeyManager(),
)..connectivityMonitor = FlutterConnectivityMonitor();
```

Y hacer build de la app con el modo release:
```bash
flutter build apk --release
# o
flutter build appbundle --release
```
