#!/bin/bash

echo "=== Запуск TestProject с Kafka KRaft ==="

# Определяем команду docker-compose
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo "Docker Compose не найден!"
    exit 1
fi

# Останавливаем старые контейнеры
$DOCKER_COMPOSE down

# Собираем и запускаем
$DOCKER_COMPOSE up --build -d

# Ждем запуска
echo "Ожидание запуска сервисов..."
sleep 20

./start.sh: строка 1: !/bin/bash: Нет такого файла или каталога
=== Запуск TestProject с Kafka KRaft ===
no configuration file provided: not found
no configuration file provided: not found
Ожидание запуска сервисов...

=== Статус контейнеров ===
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

=== Проверка API ===
GET запрос к http://localhost:8080/testproject/api/tasks
Сервис еще не готов, попробуйте через минуту

=== Готово! ===
API доступен по адресу: http://localhost:8080/testproject/api/tasks

Примеры запросов для Postman:

1. Получить все задачи:
   GET http://localhost:8080/testproject/api/tasks

2. Получить задачу по ID:
   GET http://localhost:8080/testproject/api/tasks/1

3. Создать задачу:
   POST http://localhost:8080/testproject/api/tasks
   Body (JSON):
   {"name":"Новая задача","description":"Описание задачи"}

4. Назначить исполнителя:
   PATCH http://localhost:8080/testproject/api/tasks/1/assign
   Body (JSON):
   {"executorId":1}

5. Сменить статус:
   PATCH http://localhost:8080/testproject/api/tasks/1/status
   Body (JSON):
   {"status":"IN_PROGRESS"}

Логи: docker logs -f testproject-app
art@art-Aspire-5750G:~/Spring project/one/testProject$
# Проверяем статус
echo ""
echo "=== Статус контейнеров ==="
docker ps

echo ""
echo "=== Проверка API ==="
echo "GET запрос к http://localhost:8080/testproject/api/tasks"
curl -s "http://localhost:8080/testproject/api/tasks" 2>/dev/null || echo "Сервис еще не готов, попробуйте через минуту"

echo ""
echo "=== Готово! ==="
echo "API доступен по адресу: http://localhost:8080/testproject/api/tasks"
echo ""
echo "Примеры запросов для Postman:"
echo ""
echo "1. Получить все задачи:"
echo "   GET http://localhost:8080/testproject/api/tasks"
echo ""
echo "2. Получить задачу по ID:"
echo "   GET http://localhost:8080/testproject/api/tasks/1"
echo ""
echo "3. Создать задачу:"
echo "   POST http://localhost:8080/testproject/api/tasks"
echo "   Body (JSON):"
echo '   {"name":"Новая задача","description":"Описание задачи"}'
echo ""
echo "4. Назначить исполнителя:"
echo "   PATCH http://localhost:8080/testproject/api/tasks/1/assign"
echo "   Body (JSON):"
echo '   {"executorId":1}'
echo ""
echo "5. Сменить статус:"
echo "   PATCH http://localhost:8080/testproject/api/tasks/1/status"
echo "   Body (JSON):"
echo '   {"status":"IN_PROGRESS"}'
echo ""
echo "Логи: docker logs -f testproject-app"