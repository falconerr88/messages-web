# Flask Messages App 📨
## Hecha para practicar dockerfiles y docker compose
![Python](https://img.shields.io/badge/Python-3.11-blue)
![Flask](https://img.shields.io/badge/Flask-2.3.2-green)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blueviolet)
![Docker](https://img.shields.io/badge/Docker-Ready-orange)

Aplicación de mensajes simple hecha con **Python + Flask**, pensada para ser **docker-friendly** y extremadamente **portable**.
Esta versión está optimizada para **ejecutarse únicamente con Docker Compose y PostgreSQL** para garantizar persistencia y confiabilidad de los datos.

---

## 🚀 Características

* Mensajes persistentes usando PostgreSQL.
* Multi-stage Dockerfile optimizado.
* Usuario no root en producción.
* Healthcheck integrado.
* Fácil de ejecutar en cualquier máquina con Docker y Docker Compose.

---

## 🔧 Requisitos

* Docker ≥ 20
* Docker Compose ≥ 2
* Python ≥ 3.11 (solo para desarrollo local)

---

## 📦 Uso con Docker Compose (PostgreSQL)

1. Crear archivo `.env` con tus variables de entorno:

```env
SECRET_KEY=changeme
PORT=8000
DATABASE_URL=postgresql://user:password@db:5432/flaskdb
FLASK_ENV=development
```

2. Asegurarte de tener `docker-compose.yml` en el repositorio.

3. Levantar la app junto con la base de datos:

```bash
docker-compose up --build
```

4. Acceder a la app en el navegador: [http://localhost:8000](http://localhost:8000)

> PostgreSQL manejará la persistencia de todos los mensajes. No es necesario configurar volúmenes adicionales.

---

## 📝 Notas de desarrollo

* Para correr local sin Docker (solo para pruebas):

```bash
pip install -r requirements.txt
python app.py
```

* Healthcheck integrado: `GET /health` devuelve `{"status":"ok"}`

---

## 📂 Estructura de archivos

```
/app
  ├─ app.py
  ├─ requirements.txt
  ├─ Dockerfile
  ├─ docker-compose.yml
  ├─ .env.example
  ├─ templates/
  └─ static/
```

---

## 👨‍💻 Autor

Proyecto desarrollado por **Thiago + ChatGPT**, diseñado para ser **portable, seguro y completamente dockerizado con PostgreSQL**.

