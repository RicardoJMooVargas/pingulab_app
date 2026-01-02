# Checklist de Pre-Deployment para Dockploy

## ✅ Configuración Local

- [ ] Actualizar `config/passwords.yaml` con contraseñas de producción
- [ ] Crear `.env.production` con las mismas contraseñas
- [ ] Verificar que `.gitignore` protege archivos sensibles
- [ ] Commit y push de todos los cambios
- [ ] Build local exitoso: `docker-compose -f docker-compose.production.yaml build`

## ✅ Dockploy Setup

- [ ] Cuenta creada en Dockploy
- [ ] Servidor configurado y conectado
- [ ] Docker instalado en el servidor
- [ ] Docker Compose instalado en el servidor

## ✅ DNS Configuration

- [ ] Record A para `api3d.mogastisolutions.engineer` → IP del servidor
- [ ] Record A para `insights.api3d.mogastisolutions.engineer` → IP del servidor
- [ ] Record A para `app.api3d.mogastisolutions.engineer` → IP del servidor
- [ ] DNS propagado (verificar con `nslookup api3d.mogastisolutions.engineer`)

## ✅ Deployment en Dockploy

### Opción 1: Git Deploy (Recomendado)
1. [ ] En Dockploy, crear nuevo proyecto tipo "Compose"
2. [ ] Conectar repositorio Git
3. [ ] Configurar branch de producción
4. [ ] Especificar `docker-compose.production.yaml`
5. [ ] Agregar variables de entorno:
   - `POSTGRES_PASSWORD`
   - `REDIS_PASSWORD`
6. [ ] Configurar dominios en Dockploy:
   - Puerto **8080** → `api3d.mogastisolutions.engineer` (API Server)
   - Puerto **8081** → `insights.api3d.mogastisolutions.engineer` (Insights/Monitoring)
   - Puerto **8082** → `app.api3d.mogastisolutions.engineer` (Web Server)
7. [ ] Habilitar SSL automático (Let's Encrypt)
8. [ ] Deploy

### Opción 2: Manual Deploy
1. [ ] Subir archivos al servidor:
   ```bash
   scp -r pingulab_app_server/ user@server:/opt/pingulab/
   ```
2. [ ] SSH al servidor:
   ```bash
   ssh user@server
   cd /opt/pingulab/pingulab_app_server
   ```
3. [ ] Ejecutar deployment:
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```

## ✅ Post-Deployment

- [ ] Verificar que los contenedores están corriendo:
  ```bash
  docker ps
  ```
- [ ] Verificar logs sin errores:
  ```bash
  docker logs pingulab_api
  docker logs pingulab_postgres
  docker logs pingulab_redis
  ```
- [ ] Probar endpoint de health:
  ```bash
  curl https://api3d.mogastisolutions.engineer/serverpod
  ```
- [ ] Verificar SSL activo (certificado válido en navegador)
- [ ] Probar endpoints principales:
  - GET /quote/list
  - GET /customer/list
  - GET /resources/filaments
- [ ] Insertar datos de clientes (si aplica):
  ```bash
  docker exec -it pingulab_postgres psql -U postgres -d pingulab_app -f /tmp/customers.sql
  ```
- [ ] Configurar backups automáticos:
  ```bash
  # Ver DEPLOY.md sección "Backup de Base de Datos"
  ```

## ✅ Monitoreo

- [ ] Configurar alertas en Dockploy
- [ ] Monitorear uso de recursos (CPU, RAM, Disco)
- [ ] Configurar logs centralizados (opcional)
- [ ] Documentar proceso de rollback

## 🚨 Troubleshooting Común

### Error: "Connection refused"
- Verificar que los puertos están expuestos correctamente
- Verificar firewall del servidor
- Verificar que Traefik/Nginx está corriendo

### Error: "Database connection failed"
- Verificar que PostgreSQL está corriendo: `docker ps | grep postgres`
- Verificar contraseñas en `.env.production` y `passwords.yaml`
- Ver logs: `docker logs pingulab_postgres`

### Error: "SSL certificate not valid"
- Esperar 1-5 minutos para que Let's Encrypt genere el certificado
- Verificar que DNS apunta correctamente al servidor
- Verificar logs de Traefik/Nginx

### Error de migraciones
```bash
# Ver migraciones aplicadas
docker exec -it pingulab_postgres psql -U postgres -d pingulab_app -c "SELECT * FROM serverpod_migrations;"

# Aplicar manualmente
docker exec pingulab_api ./server --apply-migrations --mode=production
```

## 📝 Notas

- Contraseñas seguras: Mínimo 16 caracteres, mezcla de letras, números y símbolos
- Backup antes de updates: Siempre hacer backup antes de actualizar
- Rollback plan: Mantener versión anterior por 48 horas
- Logs: Rotar logs semanalmente para ahorrar espacio

---

**Última actualización:** $(Get-Date -Format "yyyy-MM-dd HH:mm")
**Versión del servidor:** Serverpod 2.9.2
**Dominio:** api3d.mogastisolutions.engineer
