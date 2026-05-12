# Instrucciones de Despliegue en Render

## Pasos para desplegar en Render:

### 1. Crear la Base de Datos MySQL
1. Ve a tu panel de Render (render.com)
2. Haz clic en "+ New" → "MySQL"
3. Configura:
   - **Name**: `wordpress-db` (o cualquier nombre)
   - **Database**: `wordpress`
   - **Username**: `wordpress_user`
   - **Password**: (Render genera uno, cópialo)
4. Una vez creada, verás la información de conexión:
   - **Host**: algo como `dpg-xxxxx.render.com`
   - **Port**: `3306`
   - **Database**: `wordpress`
   - **Username**: `wordpress_user`
   - **Password**: (la que generó Render)
5. **Guarda esta información** - la necesitarás en el siguiente paso

### 2. Crear el Web Service
1. En Render, haz clic en "+ New" → "Web Service"
2. Selecciona "Build and deploy from a Git repository"
3. Conecta tu repositorio de GitHub:
   - Busca: `GabrielCevallos/WordPress`
   - Selecciona `main` como rama
4. Configura:
   - **Name**: `wordpress-site` (o como prefieras)
   - **Region**: Elige la más cercana a ti
   - **Runtime**: Selecciona "Docker"
   - **Build Command**: Déjalo en blanco (automático)
   - **Start Command**: Déjalo en blanco (automático)
5. En la sección de variables de entorno (Environment), añade las siguientes:

### 3. Configurar las Variables de Entorno
Copia exactamente los valores de tu base de datos MySQL de Render:

```
WORDPRESS_DB_HOST=dpg-xxxxx.render.com
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=wordpress_user
WORDPRESS_DB_PASSWORD=tu_password_aqui
WORDPRESS_AUTH_KEY=esto-es-auto-generado-no-importa
WORDPRESS_SECURE_AUTH_KEY=esto-es-auto-generado-no-importa
WORDPRESS_LOGGED_IN_KEY=esto-es-auto-generado-no-importa
WORDPRESS_NONCE_KEY=esto-es-auto-generado-no-importa
WORDPRESS_AUTH_SALT=esto-es-auto-generado-no-importa
WORDPRESS_SECURE_AUTH_SALT=esto-es-auto-generado-no-importa
WORDPRESS_LOGGED_IN_SALT=esto-es-auto-generado-no-importa
WORDPRESS_NONCE_SALT=esto-es-auto-generado-no-importa
```

⚠️ **IMPORTANTE**: Reemplaza `dpg-xxxxx.render.com`, `wordpress_user` y la contraseña con los valores REALES de tu base de datos MySQL en Render.

### 4. Finalizar Despliegue
1. Haz clic en "Create Web Service"
2. Render comenzará a compilar y desplegar automáticamente
3. Espera a que termine (puedes ver el progreso en los logs)
4. Una vez listo, tendrás una URL como `wordpress-site.onrender.com`

### 5. Primera Instalación de WordPress
1. Accede a tu URL: `https://tu-sitio.onrender.com`
2. Completa la instalación de WordPress (selecciona idioma, usuario admin, etc.)
3. ¡Listo! Tu sitio WordPress está en vivo

## Variables de Entorno Explicadas

| Variable | Valor | Descripción |
|----------|-------|-------------|
| `WORDPRESS_DB_HOST` | `dpg-xxxxx.render.com` | El host de tu base de datos MySQL en Render |
| `WORDPRESS_DB_NAME` | `wordpress` | Nombre de la base de datos |
| `WORDPRESS_DB_USER` | `wordpress_user` | Usuario de la base de datos |
| `WORDPRESS_DB_PASSWORD` | Tu contraseña | Contraseña de acceso a BD |
| `WORDPRESS_*_KEY` | Auto-generado | Claves de seguridad (se pueden dejar como están) |

## Troubleshooting

### "Error establishing a database connection"
**Causas comunes:**
1. ❌ El HOST no es correcto (cópialo exacto desde Render)
2. ❌ El usuario o contraseña son incorrectos
3. ❌ El puerto 3306 está bloqueado (pero Render lo maneja)
4. ✅ **Solución**: Verifica en Render que tu base de datos esté "Available" (verde)

**Para verificar:**
```bash
# Desde la terminal local, si tienes mysql-client:
mysql -h dpg-xxxxx.render.com -u wordpress_user -p wordpress
# Te pedirá contraseña, escribe la de Render
```

### "Internal Server Error"
- Revisa los logs en Render (pestaña "Logs" en tu Web Service)
- Podría ser un problema de permisos de archivos

### La base de datos no existe
- El script `docker-entrypoint.sh` la crea automáticamente
- Si aún así no funciona, creia manualmente en Render
