FROM python:3.11-slim as BUILDER

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY  requirements.txt ./

# Install Python dependencies (including gunicorn)
RUN python -m venv /opt/venv \ 
  &&  /opt/venv/bin/pip install --upgrade pip  \
  &&  /opt/venv/bin/pip install --no-cache-dir -r requirements.txt  
    
    
FROM python:3.11-slim

# Set environment variables
ENV PATH="/opt/venv/bin:$PATH" 
ENV VIRTUAL_ENV="/opt/venv" 
    
WORKDIR /app

RUN useradd --create-home appuser

# Copy installed dependencies from builder
COPY --from=BUILDER /opt/venv /opt/venv
COPY entrypoint.sh /app/entrypoint.sh
# Copy application code
COPY . /app

# Change ownership to the non-root user
RUN chown -R appuser:appuser /app 
RUN chmod +x /app/entrypoint.sh
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*
USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s CMD curl --fail http://localhost:8000/health || exit 1


ENTRYPOINT ["/app/entrypoint.sh"]

## To build the Docker image:
# docker build -t (thenameyouwant) .   

## To run the Docker container:
# docker run -d -p 8000:8000 --name flask_app (thenameyouwant)
# Access the application at http://localhost:8000
