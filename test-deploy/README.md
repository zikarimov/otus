# Запуск через docker compose

## 🐳 Быстрый старт

### 1. Запустить сервисы

docker compose up -d --build // docker-compose up -d --build (в зависимости от версии docker compose)

### 2. Проверить работу

curl http://localhost:8000

docker exec -it api ping postgres

docker exec -it postgres ping api