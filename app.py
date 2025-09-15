
import os
from flask import Flask, render_template, request, redirect, url_for
from sqlalchemy import create_engine, Column, Integer, String, Text
from sqlalchemy.orm import declarative_base, sessionmaker
from dotenv import load_dotenv 
# Configuración

load_dotenv()

# Ahora podés usar las variables de entorno
SECRET_KEY = os.environ.get("SECRET_KEY", "valor_por_defecto")
PORT = int(os.environ.get("PORT", 8000))
DB_URL = os.environ.get("DATABASE_URL")

DATABASE_URL = os.environ.get(
    "DATABASE_URL", "postgresql://user:password@db:5432/flaskdb"
)

engine = create_engine(DATABASE_URL, echo=False)
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()

# Modelo
class Message(Base):
    __tablename__ = "messages"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    text = Column(Text, nullable=False)

# Crear tablas si no existen
Base.metadata.create_all(bind=engine)

# Flask
app = Flask(__name__)
app.config["SECRET_KEY"] = SECRET_KEY

# Rutas
@app.route("/")
def index():
    session = SessionLocal()
    messages = session.query(Message).all()
    session.close()
    return render_template("index.html", messages=messages)

@app.route("/about")
def about():
    return render_template("about.html")

@app.route("/send", methods=["POST"])
def send():
    name = request.form.get("name", "Anon")
    text = request.form.get("text", "")
    if text:
        session = SessionLocal()
        message = Message(name=name, text=text)
        session.add(message)
        session.commit()
        session.close()
    return redirect(url_for("index"))

@app.route("/health")
def health():
    return {"status": "ok"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT, debug=(os.environ.get('FLASK_ENV')=='development'))

