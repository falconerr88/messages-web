Flask Docker-Friendly App 🚀








Autores: Thiago + ChatGPT

📂 Estructura del proyectoFlask Docker-Friendly App 🚀




Autores: Thiago + ChatGPT
📂 Estructura del proyecto

flask-docker-friendly/
├─ app.py
├─ requirements.txt
├─ .env.example
├─ Dockerfile
├─ docker-compose.yml
├─ templates/
│  ├─ index.html
│  └─ about.html
└─ static/

⚙️ Requisitos

    Docker ≥ 24

    Docker Compose ≥ 2.17

    Python 3.11 (solo si ejecutás localmente)

🟢 Variables de entorno (.env)

Cloná .env.example y renombralo a .env:

cp .env.example .env

Editá los valores:

SECRET_KEY=mi_clave_secreta
PORT=8000
DB_HOST=db
DB_PORT=5432
DB_USER=user
DB_PASSWORD=password
DATABASE_URL=postgresql://user:password@db:5432/flaskdb
FLASK_ENV=development

🐳 Uso desde DockerHub

 git pull falconerr88/imagenes-pruebas:appmessages

docker run -p 8000:8000 --env-file .env falconerr88/imagenes-pruebas:appmessages
O podes subir vos la imagen con el nombre que quieras y cambiarla por la mia que ya esta subida en DockerHub
    Accedé a la app en http://localhost:8000.

🐙 Uso desde GitHub

Cloná el repositorio:

git clone git@github.com:falconerr88/messages-web.git
cd flask-docker-friendly

Construí la imagen y ejecutala:

docker build -t flask_app .
docker run -p 8000:8000 --env-file .env flask_app:latest

🏗️ Uso con Docker Compose

Levanta la app y la base de datos PostgreSQL juntos:

docker-compose up --build

    Accedé a http://localhost:8000.

    Los mensajes se guardan en PostgreSQL y persisten gracias al volumen pgdata.

⚡ Notas importantes

    Multi-stage Dockerfile → imagen más liviana y segura.

    Usuario no-root (appuser) → mejora la seguridad.

    Healthcheck → Docker puede verificar que la app esté lista.

    Persistencia de datos → volumen pgdata mantiene los mensajes aunque cierres los contenedores.

📝 Comandos útiles

# Levantar solo la app
docker-compose up -d web

# Ver logs
docker-compose logs -f

# Detener y eliminar contenedores
docker-compose down

# Reconstruir imagen después de cambios
docker-compose up --build

✅ Resumen

Esta app está diseñada para:

    Ser fácil de contenerizar y ejecutar en cualquier máquina.

    Mantener la configuración fuera del código mediante .env.

    Producción segura y portable con Docker y PostgreSQL.

