# OTUS. Мониторинг в Kubernetes

Этот проект содержит готовую конфигурацию для развертывания стека мониторинга в Kubernetes включающего Prometheus, Grafana, Loki и демо-приложение.

## Цели занятия

После выполнения заданий вы сможете:
- Развернуть полный стек мониторинга в Kubernetes
- Работать с Grafana дашбордами
- Настраивать сбор логов через Loki
- Создавать метрики и алерты
- Понимать архитектуру мониторинга в K8s

## Предварительные требования

- Доступ к Kubernetes кластеру minikube
- Установленные `kubectl` и `helm`
- `make` для запуска команд

### Проверка доступа к кластеру
```bash
kubectl cluster-info
kubectl get nodes
```

## План занятия
1. Установим стек мониторинга с помощью Helm
   - Prometheus + Grafana + AlertManager
   - Loki для логирования
2. Изучим демо-приложение с метриками и логами
3. Посмотрим /metrics демо-приложения
4. Посмотрим как работает Grafana
   - Изучим предустановленные дашборды
   - Загрузим собственный дашборд
   - Настроим алерты

## Быстрый старт

### 1. Установка всего стека одной командой
```bash
make install-all
```

Эта команда установит:
- Prometheus + Grafana + AlertManager
- Loki для логирования
- Демо-приложение с метриками

### 2. Проверка статуса
```bash
make status
```

### 3. Получение пароля для Grafana
```bash
make grafana-password
```

### 4. Доступ к Grafana
```bash
make port-forward-grafana
```

После этого откройте http://localhost:3000 в браузере.
- **Логин:** admin
- **Пароль:** otus123 (или используйте `make grafana-password`)

## Что установлено

### Prometheus Stack
- **Prometheus** - сбор и хранение метрик
- **Grafana** - визуализация метрик
- **AlertManager** - управление алертами
- **Node Exporter** - метрики узлов
- **Kube State Metrics** - метрики состояния K8s

### Loki Stack
- **Loki** - сбор и хранение логов
- **Promtail** - агент сбора логов

### Demo Application
- **Node Exporter** - простое приложение с метриками
- **Log Generator** - генератор тестовых логов
- **ServiceMonitor** - автоматический сбор метрик

## 🛠️ Доступные команды

| Команда | Описание |
|---------|----------|
| `make help` | Показать справку |
| `make install-all` | Установить весь стек |
| `make install-prometheus` | Установить только Prometheus Stack |
| `make install-loki` | Установить только Loki |
| `make install-demo` | Установить демо-приложение |
| `make status` | Проверить статус компонентов |
| `make grafana-password` | Показать пароль Grafana |
| `make port-forward-grafana` | Запустить порт-форвард для Grafana |
| `make port-forward-prometheus` | Запустить порт-форвард для Prometheus |
| `make clean` | Удалить демо-приложение |
| `make clean-all` | Удалить весь стек |

## Практические задания

### Задание 1: Исследование Grafana
1. Откройте Grafana (http://localhost:3000)
2. Изучите предустановленные дашборды:
   - **Kubernetes / Compute Resources / Cluster**
   - **Kubernetes / Compute Resources / Namespace (Pods)**

### Задание 2: Работа с метриками
1. Перейдите в **Explore** в Grafana
2. Выберите источник данных **Prometheus**
3. Попробуйте следующие запросы:
   ```promql
   # Использование CPU по подам
   rate(container_cpu_usage_seconds_total[5m])
   
   # Использование памяти
   container_memory_usage_bytes
   
   # Метрики демо-приложения
   up{job="demo-app-service"}
   ```

### Задание 3: Работа с логами в Loki
1. **Loki уже настроен автоматически** как источник данных
2. Перейдите в **Explore** в Grafana
3. Выберите источник данных **Loki** 
4. Попробуйте запросы:
   ```logql
   # Все логи из namespace demo-app
   {namespace="demo-app"}
   
   # Логи с ошибками
   {namespace="demo-app"} |= "ERROR"
   
   # Логи за последние 5 минут
   {namespace="demo-app"} [5m]
   ```

### Задание 4: Создание дашборда
1. Создайте новый дашборд в Grafana
2. Добавьте панели с метриками:
   - CPU usage демо-приложения
   - Memory usage
   - Количество запросов
3. Сохраните дашборд

### Задание 5: Настройка алерта
1. Создайте правило алерта на высокое потребление CPU
2. Настройте уведомления
3. Протестируйте срабатывание

## Полезные ссылки

- **Prometheus:** http://localhost:9090 (после `make port-forward-prometheus`)
- **Grafana:** http://localhost:3000 (после `make port-forward-grafana`)
- **AlertManager:** http://localhost:9093

## Структура проекта

```
.
├── Makefile                           # Основные команды
├── values-prometheus.yaml             # Конфигурация Prometheus Stack
├── dashboards/                        # Grafana дашборды
│   └── demo-app-dashboard.json        # Готовый дашборд с логами
├── demo-app/                          # Демо-приложение
│   ├── app.yaml                       # Deployment и Service
│   ├── servicemonitor.yaml            # ServiceMonitor для метрик
│   └── alert-rules.yaml               # Правила алертов
└── README.md                          # Эта документация

## Очистка

### Удалить только демо-приложение
```bash
make clean
```

### Удалить весь стек
```bash
make clean-all
```

## Troubleshooting

### Проблемы с установкой
1. Проверьте доступ к кластеру: `kubectl get nodes`
2. Убедитесь что Helm установлен: `helm version`
3. Проверьте свободное место в кластере

### Grafana не показывает метрики
1. Проверьте что Prometheus работает: `kubectl get pods -n monitoring`
2. Убедитесь что источник данных настроен: URL должен быть `http://monitoring-kube-prometheus-prometheus:9090`

### Нет логов в Loki
1. Проверьте что Promtail собирает логи: `kubectl get pods -n monitoring | grep promtail`
2. Убедитесь что Loki добавлен как источник данных в Grafana
