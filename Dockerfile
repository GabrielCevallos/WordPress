FROM wordpress:6.7-php8.3-apache

# Habilitar módulos de Apache necesarios
RUN a2enmod rewrite
RUN a2enmod headers

# Copiar los archivos de WordPress personalizados
COPY ./wordpress /var/www/html

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto (Render usará la variable de entorno PORT)
EXPOSE 80

# Comando por defecto (apache en primer plano)
CMD ["apache2-foreground"]
