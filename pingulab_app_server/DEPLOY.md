# Guía de Despliegue en Dockploy

## Configuración Previa

### 1. Actualizar Contraseñas de Producción

Edita `config/passwords.yaml` con contraseñas seguras:

```yaml
production:
  database: 'TU_PASSWORD_POSTGRES_SEGURO'
  redis: 'TU_PASSWORD_REDIS_SEGURO'
```

### 2. Configurar Variables de Entorno

Edita `.env.production` con las mismas contraseñas:

```env
POSTGRES_PASSWORD=TU_PASSWORD_POSTGRES_SEGURO
REDIS_PASSWORD=TU_PASSWORD_REDIS_SEGURO
```

## Despliegue en Dockploy

### Opción 1: Usando Docker Compose (Recomendado)

1. **Subir archivos al servidor**
   ```bash
   # Desde tu máquina local
   scp -r ./pingulab_app_server root@tu-servidor:/opt/pingulab_app
   ```

2. **Conectar al servidor**
   ```bash
   ssh root@tu-servidor
   cd /opt/pingulab_app
   ```

3. **Construir y ejecutar**
   ```bash
   docker-compose -f docker-compose.production.yaml up -d --build
   ```

4. **Aplicar migraciones**
   ```bash
   docker exec pingulab_api ./server --apply-migrations --mode=production
   ```

5. **Verificar logs**
   ```bash
   docker logs -f pingulab_api
   ```

### Opción 2: Usando Dockploy UI

1. **Crear nuevo proyecto en Dockploy**
   - Nombre: `pingulab_app`
   - Tipo: Docker Compose
   - Repositorio: Tu repositorio Git

2. **Configurar variables de entorno en Dockploy**
   - `POSTGRES_PASSWORD`: [password seguro]
   - `REDIS_PASSWORD`: [password seguro]

3. **Subir docker-compose.production.yaml**
   - Renombrar a `docker-compose.yml` o configurar en Dockploy

4. **Configurar dominio en Dockploy**
   - Dominio principal: `api3d.mogastisolutions.engineer`
   - Puerto de destino: `8080`
   - SSL: Habilitar (Let's Encrypt automático)

5. **Deploy**
   - Hacer click en "Deploy"
   - Esperar a que construya la imagen
   - Aplicar migraciones desde el contenedor

### Opción 3: Build y Push Manual

1. **Construir imagen**
   ```bash
   docker build -t pingulab_app_server:production .
   ```

2. **Etiquetar para registry**
   ```bash
   docker tag pingulab_app_server:production tu-registry/pingulab_app_server:latest
   ```

3. **Push a registry**
   ```bash
   docker push tu-registry/pingulab_app_server:latest
   ```

4. **Deploy desde Dockploy**
   - Usar la imagen del registry

## Configuración de Subdominios

En tu proveedor DNS (donde gestionas mogastisolutions.engineer):

```
api3d                    A      [IP-SERVIDOR]    # API principal
insights.api3d           A      [IP-SERVIDOR]    # Insights
app.api3d                A      [IP-SERVIDOR]    # Web (opcional por ahora)
```

O usar wildcards:
```
*.api3d                  A      [IP-SERVIDOR]
```

## Configuración de Reverse Proxy en Dockploy

Si Dockploy usa Traefik o Nginx:

```yaml
# Agregar labels en docker-compose.production.yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.pingulab-api.rule=Host(`api3d.mogastisolutions.engineer`)"
  - "traefik.http.routers.pingulab-api.entrypoints=websecure"
  - "traefik.http.routers.pingulab-api.tls.certresolver=letsencrypt"
  - "traefik.http.services.pingulab-api.loadbalancer.server.port=8080"
```

## Post-Despliegue

### Verificar que todo funciona

```bash
# Health check
curl https://api3d.mogastisolutions.engineer/

# Test endpoint
curl https://api3d.mogastisolutions.engineer/serverpod
```

### Insertar datos de prueba

```bash
# Conectar a PostgreSQL
docker exec -it pingulab_postgres psql -U postgres -d pingulab_app

# Insertar clientes de prueba
INSERT INTO customers (apodo, nombre, apellido, numero, created) VALUES
('JuanP', 'Juan', 'Pérez', '555-1234', NOW()),
('MariaG', 'María', 'García', '555-5678', NOW());

# Insertar filamentos (si no existen)
-- Ya deberían estar por seed_data.sql
```

### Monitoreo

```bash
# Ver logs en tiempo real
docker logs -f pingulab_api

# Ver estado de contenedores
docker ps

# Ver uso de recursos
docker stats
```

## Actualización de la Aplicación

```bash
# Pull últimos cambios
git pull origin main

# Rebuild y restart
docker-compose -f docker-compose.production.yaml up -d --build

# Si hay nuevas migraciones
docker exec pingulab_api ./server --apply-migrations --mode=production
```

## Troubleshooting

### Error de conexión a base de datos
```bash
# Verificar que postgres esté corriendo
docker logs pingulab_postgres

# Verificar contraseñas en passwords.yaml
cat config/passwords.yaml
```

### Puertos bloqueados
```bash
# Verificar que los puertos estén expuestos
docker port pingulab_api

# Verificar firewall
ufw status
```

### Problemas con SSL
- Asegúrate de que Dockploy tenga configurado Let's Encrypt
- Verifica que el dominio apunte a la IP correcta
- Puede tomar 1-5 minutos en obtener el certificado

## Conectar Flutter App

En tu app Flutter, actualiza la URL del servidor:

```dart
final client = Client(
  'https://api3d.mogastisolutions.engineer/',
);
```

## Backup de Producción

```bash
# Backup de PostgreSQL
docker exec pingulab_postgres pg_dump -U postgres pingulab_app > backup_$(date +%Y%m%d).sql

# Restaurar backup
cat backup_20251229.sql | docker exec -i pingulab_postgres psql -U postgres -d pingulab_app
```

## Comandos Útiles

```bash
# Reiniciar solo el servidor
docker restart pingulab_api

# Ver logs de PostgreSQL
docker logs pingulab_postgres

# Entrar al contenedor
docker exec -it pingulab_api sh

# Limpiar todo y empezar de nuevo (¡CUIDADO! Borra datos)
docker-compose -f docker-compose.production.yaml down -v
```
