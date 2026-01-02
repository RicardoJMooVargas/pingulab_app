# Guía de Compilación para Android - Producción

## Problemas Resueltos

### 1. Conexión a Servidor de Producción
- ✅ **AndroidManifest.xml**: Agregados permisos de INTERNET y ACCESS_NETWORK_STATE
- ✅ **network_security_config.xml**: Configuración de seguridad de red que permite HTTPS con certificados del sistema
- ✅ **main.dart**: HttpOverrides solo se aplica en modo debug, no en producción

### 2. Generación de PDFs
- ✅ **Permisos de almacenamiento**: Agregados para Android ≤ 12
- ✅ **minSdkVersion**: Configurado en 21 (requerido por paquetes pdf/printing)

## Comandos de Compilación

### Para Debug (desarrollo local)
```bash
flutter run --debug
```
Usa: `http://localhost:8080/` o `http://10.0.2.2:8080/` (emulador)

### Para Release (producción)
```bash
# APK (para distribución directa)
flutter build apk --release

# App Bundle (recomendado para Google Play Store)
flutter build appbundle --release
```
Usa automáticamente: `https://api3d.mogastisolutions.engineer/`

### Con URL personalizada
```bash
flutter build apk --release --dart-define=SERVER_URL=https://tu-servidor.com/
```

## Archivos Modificados

1. **android/app/src/main/AndroidManifest.xml**
   - Permisos de internet y red
   - Permisos de almacenamiento para PDFs
   - Referencia a network_security_config

2. **android/app/src/main/res/xml/network_security_config.xml** (nuevo)
   - Permite HTTPS para producción (api3d.mogastisolutions.engineer)
   - Permite HTTP solo para localhost/desarrollo
   - Usa certificados del sistema para validación

3. **android/app/build.gradle.kts**
   - `minSdk = 21` (requerido para pdf/printing)

4. **lib/main.dart**
   - HttpOverrides solo en modo debug
   - URL de producción por defecto en release builds

## Verificación

### Antes de compilar, verifica:
1. ✅ La URL de producción en main.dart está correcta
2. ✅ El servidor de producción tiene certificado SSL válido
3. ✅ Los permisos están en AndroidManifest.xml

### Después de compilar:
1. Instala el APK: `flutter install --release`
2. Verifica que se conecte al servidor de producción
3. Prueba el login
4. Genera un PDF de una cotización

## Troubleshooting

### "Unable to connect to server"
- Verifica que el servidor esté corriendo
- Verifica que la URL sea correcta (incluye `/` al final)
- Verifica que el certificado SSL sea válido

### "Permission denied" al guardar PDF
- En Android 13+, el permiso se solicita automáticamente
- En Android ≤ 12, verifica que los permisos estén en AndroidManifest.xml

### "Certificate verification failed"
- Verifica que el servidor tenga un certificado SSL válido
- El dominio debe coincidir con el certificado
- No uses HttpOverrides en producción (ya está configurado)

## Distribución

### Google Play Store
1. Compila: `flutter build appbundle --release`
2. El archivo estará en: `build/app/outputs/bundle/release/app-release.aab`
3. Sube a Google Play Console

### Distribución Directa
1. Compila: `flutter build apk --release`
2. El archivo estará en: `build/app/outputs/flutter-apk/app-release.apk`
3. Comparte el APK

## Notas de Seguridad

- ✅ En **producción**: Se usan certificados del sistema, validación completa
- ✅ En **desarrollo**: Se aceptan certificados autofirmados solo en debug
- ✅ **network_security_config.xml**: Configuración explícita para cada dominio
- ✅ No hay vulnerabilidades de seguridad en release builds
