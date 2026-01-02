# Script de prueba local de Docker Compose
# Ejecutar con: .\test_docker_local.ps1

Write-Host "🧪 Testing Docker Compose Production Setup" -ForegroundColor Cyan
Write-Host ""

# Verificar que existe docker-compose.production.yaml
if (-not (Test-Path "docker-compose.production.yaml")) {
    Write-Host "❌ No se encontró docker-compose.production.yaml" -ForegroundColor Red
    exit 1
}

# Verificar que existe Dockerfile
if (-not (Test-Path "Dockerfile")) {
    Write-Host "❌ No se encontró Dockerfile" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Archivos necesarios encontrados" -ForegroundColor Green
Write-Host ""

# Crear archivo .env temporal para pruebas locales
$envContent = @"
POSTGRES_PASSWORD=test_password_123
REDIS_PASSWORD=test_redis_456
"@

Set-Content -Path ".env" -Value $envContent
Write-Host "✅ Archivo .env creado para testing" -ForegroundColor Green
Write-Host ""

# Intentar construir la imagen
Write-Host "🔨 Construyendo imagen Docker..." -ForegroundColor Yellow
docker compose -f docker-compose.production.yaml build

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al construir la imagen" -ForegroundColor Red
    Remove-Item ".env" -ErrorAction SilentlyContinue
    exit 1
}

Write-Host "✅ Imagen construida exitosamente" -ForegroundColor Green
Write-Host ""

# Preguntar si desea iniciar los contenedores
$start = Read-Host "¿Deseas iniciar los contenedores para probar? (y/n)"

if ($start -eq "y") {
    Write-Host "🚀 Iniciando contenedores..." -ForegroundColor Yellow
    docker compose -f docker-compose.production.yaml up -d
    
    Write-Host ""
    Write-Host "✅ Contenedores iniciados" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 Monitoreando logs (Ctrl+C para salir)..." -ForegroundColor Cyan
    Write-Host ""
    
    # Esperar un momento para que los contenedores inicien
    Start-Sleep -Seconds 3
    
    # Mostrar logs
    docker compose -f docker-compose.production.yaml logs -f serverpod
    
    # Al salir, preguntar si desea detener los contenedores
    Write-Host ""
    $stop = Read-Host "¿Deseas detener los contenedores? (y/n)"
    
    if ($stop -eq "y") {
        Write-Host "🛑 Deteniendo contenedores..." -ForegroundColor Yellow
        docker compose -f docker-compose.production.yaml down
        Write-Host "✅ Contenedores detenidos" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "ℹ️  Los contenedores siguen ejecutándose" -ForegroundColor Cyan
        Write-Host "Para detenerlos: docker compose -f docker-compose.production.yaml down" -ForegroundColor Cyan
        Write-Host "Para ver logs: docker compose -f docker-compose.production.yaml logs -f" -ForegroundColor Cyan
    }
} else {
    Write-Host "✅ Build exitoso. Los contenedores no fueron iniciados." -ForegroundColor Green
}

Write-Host ""
Write-Host "🧹 Limpiando archivo .env de prueba..." -ForegroundColor Yellow
Remove-Item ".env" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "✅ Test completado" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Recuerda:" -ForegroundColor Cyan
Write-Host "   - En Dockploy, configura las variables POSTGRES_PASSWORD y REDIS_PASSWORD" -ForegroundColor White
Write-Host "   - Usa contraseñas seguras en producción" -ForegroundColor White
Write-Host "   - Verifica que los dominios apunten a tu servidor" -ForegroundColor White
