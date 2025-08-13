# Kafka VM — минимальный стенд Kafka (Docker, KRaft)

Одноузловая Kafka в режиме KRaft (без ZooKeeper) + простой UI. Подходит для отдельного сервера Ubuntu/Docker. Внешний доступ защищён логином/паролем (SASL/PLAIN) на внешнем listener-е, UI защищён Basic Auth.

## Что входит
- docker-compose: Kafka (KRaft) с INTERNAL/EXTERNAL listener-ами
- `env.example` — параметры запуска
- Веб-интерфейс: `provectuslabs/kafka-ui` (порт `8080` по умолчанию)
- Скрипты для Linux: `scripts/start.sh`, `scripts/stop.sh`, `scripts/logs.sh`

## Быстрый старт (Ubuntu 22.04 / Docker Compose v2)
1. Установите Docker и Compose, клонируйте репозиторий
2. Создайте файл `.env` из `env.example` и задайте значения:
```
COMPOSE_PROJECT_NAME=kafka_vm
KAFKA_IMAGE=bitnami/kafka:3.7
KAFKA_ADVERTISED_HOST=your.server.ip.or.dns
KAFKA_EXTERNAL_PORT=9094
KAFKA_DATA_VOLUME=kafka_data
KAFKA_SASL_USER=app
KAFKA_SASL_PASSWORD=change-me-strong
KAFKA_UI_IMAGE=provectuslabs/kafka-ui:latest
KAFKA_UI_PORT=8080
KAFKA_UI_CLUSTER_NAME=kafka
KAFKA_UI_BASIC_USER=admin
KAFKA_UI_BASIC_PASSWORD=change-me-strong-too
```
3. Запуск:
```
./scripts/start.sh
```
4. Логи:
```
./scripts/logs.sh
```
5. Остановка:
```
./scripts/stop.sh
./scripts/stop.sh -v   # с удалением томов
```

## Подключение из другого проекта (SASL/PLAIN)
Пример настроек клиента:
```
bootstrap.servers=your.server.ip:9094
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="app" password="change-me-strong";
```

## UI (kafka-ui)
- Откройте: `http://<server>:<KAFKA_UI_PORT>` (по умолчанию `http://localhost:8080`)
- Логин/пароль UI: `KAFKA_UI_BASIC_USER` / `KAFKA_UI_BASIC_PASSWORD`
- UI подключается к внутреннему listener `kafka:9092` (без аутентификации внутри docker-сети)

## Заметки
- Автосоздание топиков включено (`KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE=true`).
- Данные в Docker-томе `KAFKA_DATA_VOLUME`.
- Zookeeper не нужен (KRaft). UI защищён Basic Auth.


