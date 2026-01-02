# 🚀 Deployment Rápido en Dockploy

## 🎯 Configuración en 3 pasos

### 1️⃣ Variables de Entorno
En Dockploy, configura:
```bash
POSTGRES_PASSWORD=tu_password_segura_aqui
REDIS_PASSWORD=tu_redis_password_aqui
```

### 2️⃣ Crear Servicio Compose
- Tipo: **Compose**
- Archivo: `./docker-compose.production.yaml`
- Variables: Agregar las 2 variables de arriba

### 3️⃣ Configurar Dominios
Mapea los puertos en Dockploy:
- `api3d.mogastisolutions.engineer` → puerto **8080** (API)
- `insights.api3d.mogastisolutions.engineer` → puerto **8081** (Insights)
- `app.api3d.mogastisolutions.engineer` → puerto **8082** (Web)

Click en **Deploy** ✅

---

## 📱 Configurar App Flutter

Actualiza la URL en tu app:

```dart
// lib/main.dart
final client = Client(
  'https://api3d.mogastisolutions.engineer/',
  authenticationKeyManager: FlutterAuthenticationKeyManager(),
)..connectivityMonitor = FlutterConnectivityMonitor();
```

---

## 👥 Usuarios Predeterminados

Se crean automáticamente en el primer inicio:

| Email | Password | Rol |
|-------|----------|-----|
| admin@pingulab.com | admin123 | Administrador |
| operador@pingulab.com | operador123 | Operador |
| viewer@pingulab.com | viewer123 | Solo lectura |

**⚠️ IMPORTANTE:** Cambia estas contraseñas después del primer login.

---

## 🔍 Verificar Deployment

Monitorea los logs:
```bash
docker logs pingulab_api -f
```

Busca estos mensajes:
- ✅ "Configuring passwords..."
- ✅ "Database is ready"
- ✅ "All migrations applied"
- ✅ "Starting Serverpod..."

---

## 📚 Documentación Completa

Ver [DOCKPLOY_DEPLOYMENT.md](./DOCKPLOY_DEPLOYMENT.md) para detalles completos, troubleshooting y configuración avanzada.

---

## ⚡ Lo que hace el deployment automáticamente

1. Construye la imagen Docker con el servidor compilado
2. **Genera automáticamente el protocolo Serverpod** (user.dart, user_role.dart, etc.)
3. Configura PostgreSQL 16 con pgvector
4. Configura Redis 6 para cache
5. Aplica todas las migraciones de Serverpod
6. Ejecuta el script de post-migración (campos custom)
7. Crea los 3 usuarios administradores
8. Inicia el servidor en los 3 puertos
9. Configura health checks automáticos

Todo listo para producción 🎉
