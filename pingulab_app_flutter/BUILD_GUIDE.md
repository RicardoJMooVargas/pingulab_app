# Guía de Compilación - Pingulab App Flutter

## 🚀 Compilación Rápida

### Android APK
```cmd
build_apk.bat
```
📦 Resultado: `build\app\outputs\flutter-apk\app-release.apk`

### Windows EXE
```cmd
build_windows.bat
```
💻 Resultado: `build\windows\x64\runner\Release\` (carpeta completa)

### Compilar Todo
```cmd
build_all.bat
```

---

## 📋 Compilación Manual

### Android APK

```bash
# 1. Limpiar
flutter clean

# 2. Dependencias
flutter pub get

# 3. Compilar APK (producción)
flutter build apk --release

# 4. APK generado en:
# build\app\outputs\flutter-apk\app-release.apk
```

### Windows EXE

```bash
# 1. Limpiar
flutter clean

# 2. Dependencias
flutter pub get

# 3. Compilar Windows (producción)
flutter build windows --release

# 4. Ejecutable en:
# build\windows\x64\runner\Release\pingulab_app_flutter.exe
```

⚠️ **IMPORTANTE**: Para distribuir la app de Windows, debes copiar TODA la carpeta `Release`, no solo el `.exe`

---

## 🌐 Configuración de URL del Servidor

La app se configura automáticamente según el modo:

- **Desarrollo** (Debug): `http://localhost:8080/`
- **Producción** (Release): `https://api3d.mogastisolutions.engineer/`

### Cambiar URL manualmente:

```bash
# Android APK con URL personalizada
flutter build apk --release --dart-define=SERVER_URL=https://tu-dominio.com/

# Windows con URL personalizada
flutter build windows --release --dart-define=SERVER_URL=https://tu-dominio.com/
```

---

## 📱 Distribución

### Android APK
1. Copiar `app-release.apk` al dispositivo
2. Habilitar "Instalar apps de fuentes desconocidas"
3. Instalar APK

### Windows EXE
1. Copiar carpeta `Release` completa
2. Opcional: Crear instalador con Inno Setup o NSIS
3. Distribuir carpeta o instalador

---

## 🔧 Troubleshooting

### Error: "Flutter SDK not found"
```bash
flutter doctor
```

### Error al compilar Android
```bash
# Verificar Android SDK
flutter doctor -v

# Limpiar gradle cache
cd android
.\gradlew clean
cd ..
```

### Error al compilar Windows
```bash
# Verificar Visual Studio instalado
flutter doctor

# Reinstalar dependencias Windows
flutter clean
flutter pub get
```

### App no se conecta al servidor
1. Verificar que el servidor esté desplegado
2. Probar URL en navegador: `https://api3d.mogastisolutions.engineer/serverpod`
3. Verificar SSL válido
4. Compilar con URL correcta usando `--dart-define`

---

## 📦 Builds Optimizados

### APK más pequeño (split por arquitectura)
```bash
flutter build apk --split-per-abi --release
```
Genera 3 APKs: arm64-v8a, armeabi-v7a, x86_64

### Windows con icono personalizado
1. Agregar icono en `windows\runner\resources\app_icon.ico`
2. Compilar normalmente

---

## 🎯 Checklist Pre-Compilación

- [ ] Servidor desplegado y funcionando
- [ ] URL de producción actualizada en código
- [ ] Versión actualizada en `pubspec.yaml`
- [ ] Probado en modo debug
- [ ] Dependencias actualizadas (`flutter pub get`)
- [ ] Sin warnings de `flutter analyze`

---

**Última actualización:** Diciembre 2025
**Versión Flutter recomendada:** 3.x o superior
