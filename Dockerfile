FROM python:3.11-slim

WORKDIR /app

# 可选：如果有些源/依赖需要 git/curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates curl \
  && rm -rf /var/lib/apt/lists/*

COPY . /app

# README 推荐 uv
RUN pip install -U uv && uv sync --frozen

ENV PYTHONUNBUFFERED=1

# 默认执行一次（定时执行交给 Zeabur Cron）
CMD ["uv", "run", "horizon"]
