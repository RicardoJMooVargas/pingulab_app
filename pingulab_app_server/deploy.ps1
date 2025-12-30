# PowerShell Script de deployment para Dockploy

$ErrorActionPreference = "Stop"

Write-Host "🚀 Iniciando deployment de Pingulab App..." -ForegroundColor Cyan

# Variables
$ComposeFile = "docker-compose.production.yaml"
$EnvFile = ".env.production"

# Verificar archivos necesarios
Write-Host "📋 Verificando archivos necesarios..." -ForegroundColor Yellow
if (-not (Test-Path $ComposeFile)) {
    Write-Host "❌ Error: $ComposeFile no encontrado" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "config\passwords.yaml")) {
    Write-Host "❌ Error: config\passwords.yaml no encontrado" -ForegroundColor Red
    Write-Host "   Crea el archivo con contraseñas de producción" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $EnvFile)) {
    Write-Host "⚠️  Warning: $EnvFile no encontrado" -ForegroundColor Yellow
    Write-Host "   Debes crear el archivo con las contraseñas" -ForegroundColor Yellow
    exit 1
}

# Build y deploy
Write-Host "🔨 Construyendo imágenes..." -ForegroundColor Green
docker-compose -f $ComposeFile build

Write-Host "🚀 Iniciando servicios..." -ForegroundColor Green
docker-compose -f $ComposeFile up -d

# Esperar a que la base de datos esté lista
Write-Host "⏳ Esperando a que PostgreSQL esté listo..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Aplicar migraciones
Write-Host "📦 Aplicando migraciones..." -ForegroundColor Green
docker exec pingulab_api ./server --apply-migrations --mode=production
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al aplicar migraciones" -ForegroundColor Red
    exit 1
}

# Verificar estado
Write-Host "✅ Verificando servicios..." -ForegroundColor Green
docker-compose -f $ComposeFile ps

# Health check
Write-Host "🏥 Realizando health check..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/serverpod" -UseBasicParsing
    Write-Host "✅ Servidor respondiendo correctamente" -ForegroundColor Green
} catch {
    Write-Host "❌ Servidor no responde" -ForegroundColor Red
    docker logs pingulab_api
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✅ Deployment completado exitosamente" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Puedes ver los logs con:"
Write-Host "   docker logs -f pingulab_api"
Write-Host ""
Write-Host "🌐 URLs disponibles:"
Write-Host "   API:      https://api3d.mogastisolutions.engineer"
Write-Host "   Insights: https://insights.api3d.mogastisolutions.engineer"
Write-Host ""
