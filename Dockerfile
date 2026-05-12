FROM wordpress:6.7-php8.3-apache

# Instalar utilidades necesarias
RUN apt-get update && apt-get install -y \
    mysql-client \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Habilitar módulos de Apache necesarios
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl

# Copiar los archivos de WordPress personalizados
COPY ./wordpress /var/www/html

# Crear archivo .htaccess si no existe
RUN echo "# BEGIN WordPress\n<IfModule mod_rewrite.c>\nRewriteEngine On\nRewriteBase /\nRewriteRule ^index\.php$ - [L]\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule . /index.php [L]\n</IfModule>\n# END WordPress" > /var/www/html/.htaccess

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod 644 /var/www/html/.htaccess

# Script de entrada para verificar BD
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Exponer el puerto (Render usará la variable de entorno PORT)
EXPOSE 80

# Usar nuestro script de entrada
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
