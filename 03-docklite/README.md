# DockLite

Minimal Dockerized Python HTTP server. No external dependencies.

## Quick Start

```bash
docker build -t docklite .
docker run -p 8080:8080 docklite
```

Visit: http://localhost:8080

## Stack
- Python 3.12 Alpine (ultra-slim image)
- Built-in `http.server` — zero pip installs
