@echo off
echo ================================
echo  Compilando APK para Android
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

REM Build APK
echo [3/4] Construyendo APK...
flutter build apk --release
echo.

REM Verificar resultado
echo [4/4] Verificando resultado...
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo.
    echo ================================
    echo   APK compilado exitosamente!
    echo ================================
    echo.
    echo Ubicacion: build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo Abriendo carpeta...
    start "" "build\app\outputs\flutter-apk\"
) else (
    echo.
    echo ================================
    echo   Error al compilar APK
    echo ================================
    echo.
    echo Revisa los logs arriba para ver el error.
)

pause
