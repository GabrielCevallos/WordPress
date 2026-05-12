FROM wordpress:6.7-php8.3-apache

# Habilitar módulos de Apache necesarios
RUN a2enmod rewrite && \
    a2enmod headers && \
    a2enmod ssl

# Copiar los archivos de WordPress personalizados
COPY ./wordpress /var/www/html

# Crear archivo .htaccess si no existe
RUN echo "# BEGIN WordPress\n<IfModule mod_rewrite.c>\nRewriteEngine On\nRewriteBase /\nRewriteRule ^index\.php$ - [L]\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule . /index.php [L]\n</IfModule>\n# END WordPress" > /var/www/html/.htaccess

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod 644 /var/www/html/.htaccess

# Exponer el puerto (Render usará la variable de entorno PORT)
EXPOSE 80

# Comando por defecto (apache en primer plano)
CMD ["apache2-foreground"]
