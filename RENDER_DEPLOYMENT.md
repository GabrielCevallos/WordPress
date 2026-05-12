# Instrucciones de Despliegue en Render

## Pasos para desplegar en Render:

### 1. Crear la Base de Datos
- En Render, crea un nuevo servicio "PostgreSQL" o "MySQL"
- Guarda las credenciales de la base de datos que Render proporcione

### 2. Crear el Web Service
- En Render, crea un nuevo "Web Service"
- Conecta tu repositorio de GitHub: `https://github.com/GabrielCevallos/WordPress`
- Selecciona "Docker" como el tipo de servicio
- El Dockerfile se construirá automáticamente

### 3. Configurar las Variables de Entorno
En el panel de Render, añade las siguientes variables de entorno:

```
WORDPRESS_DB_NAME=wordpress_db
WORDPRESS_DB_USER=tu_usuario_db
WORDPRESS_DB_PASSWORD=tu_contraseña_db
WORDPRESS_DB_HOST=tu_host_de_render.render.com
WORDPRESS_AUTH_KEY=cambiar_esto_a_clave_segura
WORDPRESS_SECURE_AUTH_KEY=cambiar_esto_a_clave_segura
WORDPRESS_LOGGED_IN_KEY=cambiar_esto_a_clave_segura
WORDPRESS_NONCE_KEY=cambiar_esto_a_clave_segura
WORDPRESS_AUTH_SALT=cambiar_esto_a_clave_segura
WORDPRESS_SECURE_AUTH_SALT=cambiar_esto_a_clave_segura
WORDPRESS_LOGGED_IN_SALT=cambiar_esto_a_clave_segura
WORDPRESS_NONCE_SALT=cambiar_esto_a_clave_segura
```

### 4. Habilitar Sincronización Automática (Opcional)
- Marca "Auto-Deploy" para que se actualice con cada push a main

## Notas Importantes:

1. **Base de Datos**: WordPress requiere MySQL 8.0+. Asegúrate de crear la base de datos en Render.
2. **Variables de Entorno**: Las claves de seguridad (SALT/KEY) deberían ser únicas y seguras.
3. **Volúmenes**: Los cambios en el código se sincronizarán, pero los datos de WordPress se almacenarán en la base de datos.
4. **Persistencia**: Para mantener tus temas y plugins, asegúrate de versionarlos en Git.

## Troubleshooting:

- Si Render muestra errores de conexión a BD, verifica que las credenciales coincidan
- Si la aplicación se cuelga, revisa los logs en Render para más detalles
- Ejecuta `wp-cli` comandos si es necesario para instalar/configurar WordPress
