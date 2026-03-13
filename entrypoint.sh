#!/bin/bash
set -e

# Mensaje de inicio
 echo "Entrypoint ejecutado desde la raíz del proyecto"

# Esperar a que MySQL esté disponible
while ! nc -z db 3306; do
  sleep 1
done

echo "MySQL listo"

# Permisos para uploads/logs/cache/sessions
for dir in uploads application/logs application/cache application/sessions; do
  if [ -d "/var/www/html/$dir" ]; then
    chown -R www-data:www-data "/var/www/html/$dir"
    chmod -R 775 "/var/www/html/$dir"
    echo "Permisos configurados para $dir"
  fi
done

# Ejecutar el comando por defecto
exec "$@"
