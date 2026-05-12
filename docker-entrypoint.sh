#!/bin/bash
set -e

echo "=== WordPress Docker Entrypoint ==="
echo "Esperando a que la base de datos esté disponible..."

# Parámetros de BD
DB_HOST="${WORDPRESS_DB_HOST:-mysql}"
DB_USER="${WORDPRESS_DB_USER:-wordpress}"
DB_PASS="${WORDPRESS_DB_PASSWORD:-}"
DB_NAME="${WORDPRESS_DB_NAME:-wordpress}"

# Intentar conectar a la BD
max_attempts=30
attempt=1

while [ $attempt -le $max_attempts ]; do
    echo "Intento $attempt de $max_attempts para conectar a $DB_HOST..."
    
    if mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1" &> /dev/null; then
        echo "✓ Conexión a base de datos establecida"
        
        # Crear base de datos si no existe
        mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
        echo "✓ Base de datos verificada"
        break
    fi
    
    if [ $attempt -eq $max_attempts ]; then
        echo "✗ No se pudo conectar a la base de datos después de $max_attempts intentos"
        echo "Continuando de todas formas (WordPress puede intentar auto-instalarse)..."
        break
    fi
    
    attempt=$((attempt + 1))
    sleep 2
done

echo "=== Iniciando Apache ==="
exec "$@"
