@echo off
echo ================================
echo  Compilando EXE para Windows
echo ================================
echo.

REM Limpiar build anterior
echo [1/4] Limpiando build anterior...
flutter clean
echo.

REM Obtener dependencias
echo [2/4] Obteniendo dependencias...
flutter pub get
echo.

REM Build Windows
echo [3/4] Construyendo ejecutable Windows...
flutter build windows --release
echo.

REM Verificar resultado
echo [4/4] Verificando resultado...
if exist "build\windows\x64\runner\Release\pingulab_app_flutter.exe" (
    echo.
    echo ================================
    echo   EXE compilado exitosamente!
    echo ================================
    echo.
    echo Ubicacion: build\windows\x64\runner\Release\
    echo.
    echo IMPORTANTE: Debes copiar TODA la carpeta Release
    echo para distribuir la aplicacion, no solo el .exe
    echo.
    echo Abriendo carpeta...
    start "" "build\windows\x64\runner\Release\"
) else (
    echo.
    echo ================================
    echo   Error al compilar EXE
    echo ================================
    echo.
    echo Revisa los logs arriba para ver el error.
)

pause
