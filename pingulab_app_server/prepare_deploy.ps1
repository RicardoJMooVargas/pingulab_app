# Script para preparar el deployment a Dockploy
# Ejecutar con: .\prepare_deploy.ps1

Write-Host "🚀 Preparando deployment a Dockploy" -ForegroundColor Cyan
Write-Host ""

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "Dockerfile")) {
    Write-Host "❌ Error: Ejecuta este script desde pingulab_app_server/" -ForegroundColor Red
    exit 1
}

Write-Host "📦 Verificando archivos generados..." -ForegroundColor Yellow
$generatedFiles = Get-ChildItem -Path "lib/src/generated" -File

if ($generatedFiles.Count -eq 0) {
    Write-Host "❌ No se encontraron archivos generados" -ForegroundColor Red
    Write-Host "   Ejecuta 'serverpod generate' primero" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Encontrados $($generatedFiles.Count) archivos generados" -ForegroundColor Green
Write-Host ""

# Verificar estado de Git
Write-Host "🔍 Verificando estado de Git..." -ForegroundColor Yellow
$gitStatus = git status --porcelain lib/src/generated/

if ([string]::IsNullOrEmpty($gitStatus)) {
    Write-Host "✅ Los archivos generados ya están en Git" -ForegroundColor Green
    Write-Host ""
    Write-Host "ℹ️  Todo listo para deploy. Solo haz push si hay otros cambios." -ForegroundColor Cyan
} else {
    Write-Host "⚠️  Archivos generados sin commitear:" -ForegroundColor Yellow
    Write-Host $gitStatus
    Write-Host ""
    
    $addFiles = Read-Host "Agregar archivos generados a Git? (y/n)"
    
    if ($addFiles -eq "y") {
        Write-Host ""
        Write-Host "Agregando archivos..." -ForegroundColor Yellow
        git add lib/src/generated/
        
        Write-Host "Archivos agregados" -ForegroundColor Green
        Write-Host ""
        Write-Host "Proximo paso: hacer commit y push" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Comandos sugeridos:" -ForegroundColor White
        Write-Host "  git commit -m ""fix: Incluir archivos generados para build de produccion""" -ForegroundColor Gray
        Write-Host "  git push" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "📋 Checklist de deployment:" -ForegroundColor Cyan
Write-Host "  [ ] Archivos generados commiteados" -ForegroundColor White
Write-Host "  [ ] Push realizado a GitHub" -ForegroundColor White
Write-Host "  [ ] Variables POSTGRES_PASSWORD y REDIS_PASSWORD configuradas en Dockploy" -ForegroundColor White
Write-Host "  [ ] Dominios configurados en Dockploy" -ForegroundColor White
Write-Host ""
Write-Host "📚 Ver DEPLOYMENT_QUICK.md para más detalles" -ForegroundColor Cyan
