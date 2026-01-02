@echo off
echo ========================================
echo MIGRACION DE BASE DE DATOS - PinguLab
echo ========================================
echo.

REM Configuracion
set PGUSER=postgres
set PGPASSWORD=tu_password_aqui
set PGHOST=localhost
set PGPORT=5432
set PGDATABASE=pingulab_db

echo 1. Haciendo backup de la base de datos...
pg_dump -U %PGUSER% -h %PGHOST% -p %PGPORT% -d %PGDATABASE% > backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.sql
if errorlevel 1 (
    echo ERROR: No se pudo hacer el backup
    pause
    exit /b 1
)
echo    ✓ Backup creado exitosamente

echo.
echo 2. Aplicando migracion...
psql -U %PGUSER% -h %PGHOST% -p %PGPORT% -d %PGDATABASE% -f migrations\migration_add_users_and_updates.sql
if errorlevel 1 (
    echo ERROR: La migracion fallo
    pause
    exit /b 1
)
echo    ✓ Migracion aplicada

echo.
echo 3. Cargando datos de prueba (opcional)...
psql -U %PGUSER% -h %PGHOST% -p %PGPORT% -d %PGDATABASE% -f seed_data_with_auth.sql
if errorlevel 1 (
    echo ADVERTENCIA: Los datos de prueba no se pudieron cargar
)
echo    ✓ Datos de prueba cargados

echo.
echo ========================================
echo MIGRACION COMPLETADA
echo ========================================
echo.
echo Ahora puedes:
echo 1. Reiniciar el servidor: dart run bin\main.dart
echo 2. Probar el login en Flutter
echo.
pause
