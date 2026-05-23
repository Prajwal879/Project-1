# Docker Hello App

A minimal Flask app containerized with Docker.

## Run with Docker

```bash
docker build -t hello-app .
docker run -p 5000:5000 hello-app
```

Visit: http://localhost:5000

## Files
| File | Purpose |
|------|---------|
| `app.py` | Flask web app |
| `Dockerfile` | Container definition |
| `requirements.txt` | Python dependencies |
