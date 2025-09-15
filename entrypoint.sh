#!/bin/sh

# Esperar a PostgreSQL
echo "Esperando a que PostgreSQL esté listo..."
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER"; do
  sleep 1
done

echo "PostgreSQL listo, arrancando Flask..."
exec gunicorn --bind 0.0.0.0:${PORT:-8000} app:app
