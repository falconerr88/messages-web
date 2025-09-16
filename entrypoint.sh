#!/bin/sh
set -e  # Salir si hay algún error

echo "Esperando a que PostgreSQL esté listo en $DB_HOST:$DB_PORT..."
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" > /dev/null 2>&1; do
  echo "PostgreSQL no disponible, esperando 2s..."
  sleep 2
done

echo "PostgreSQL listo, arrancando Flask..."
exec gunicorn --bind "0.0.0.0:${PORT:-8000}" app:app
