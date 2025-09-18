# OTUS. Helm и GitLab CI/CD

## План работы

0. Создать helm chart для fastapi-app
1. Перенести наши манифесты из k8s в helm/fastapi-app/templates
2. Заполнить в helm/fastapi-app values.yaml и Chart.yaml
3. Запустить линтер helm и проверить шаблонизацию
4. Подготовить .gitlab-ci.yml для CI/CD
5. Подготовить kubeconfig для доступа к кластеру из GitLab Runner
6. Заполнить переменные в GitLab Variables
7. Запушить репозиторий в GitLab и запустить CI/CD
8. Проверить работу приложения в кластере по External IP Ingress
