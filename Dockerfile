# --- Dockerfile (root) ---
FROM public.ecr.aws/docker/library/python:3.11-slim

WORKDIR /app

# Faster/cleaner installs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Install deps first for better layer caching
COPY analytics/requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

# Copy the app code
COPY analytics/ .

# App port (change only if your app uses a different one)
ENV PORT=8080
EXPOSE 8080

# Start the API (change app.py if needed)
CMD ["python", "app.py"]
