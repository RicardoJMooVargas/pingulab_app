@echo off
echo ================================
echo  Compilando todas las versiones
echo ================================
echo.

REM Limpiar
echo Limpiando...
flutter clean
echo.

REM Dependencias
echo Obteniendo dependencias...
flutter pub get
echo.

REM Windows
echo [1/2] Compilando Windows EXE...
flutter build windows --release
echo.

REM Android APK
echo [2/2] Compilando Android APK...
flutter build apk --release
echo.

REM Resumen
echo.
echo ================================
echo      Compilacion Completa
echo ================================
echo.

if exist "build\windows\x64\runner\Release\pingulab_app_flutter.exe" (
    echo [OK] Windows: build\windows\x64\runner\Release\
) else (
    echo [ERROR] Windows: No se compilo
)

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo [OK] Android: build\app\outputs\flutter-apk\app-release.apk
) else (
    echo [ERROR] Android: No se compilo
)

echo.
echo Abriendo carpeta de builds...
start "" "build\"
echo.

pause
