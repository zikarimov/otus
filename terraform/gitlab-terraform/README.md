# OTUS. Terraform в Gitlab CI/CD

## План работы

1. Создадим проект в Gitlab
2. Создадим локальный репозиторий с директорией `infra` для хранения terraform-кода
3. Добавим файл `.terraformrc` для [настройки провайдера](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart#configure-provider) внутри Gitlab Runner
4. Добавим файлы:
    * `main.tf`
    * `provider.tf`
    * `variables.tf`
5. Добавим файл `.gitignore` для исключения файлов из репозитория
6. Создадим .gitlab-ci.yml для настройки CI/CD со стадиями:
    * `validate`
    * `plan`
    * `apply`
    * `destroy`
7. Добавим переменные окружения в пайплайн для хранения terraform-state файла в Gitlab
8. Добавим переменные окружения от облака Yandex Cloud в Gitlab на уровне проекта:
    * `TF_VAR_yc_token`
    * `TF_VAR_yc_cloud_id`
    * `TF_VAR_yc_folder_id`
    * `TF_VAR_ssh_public_key`  
    **Примечание:** чтобы получить YC_TOKEN можно выполнить команду `yc iam create-token`
9. Запушим репозиторий в Gitlab
10. Проверим работу CI/CD пайплайна

В результате мы должны получить автоматизированное развертывание инфраструктуры в Yandex Cloud