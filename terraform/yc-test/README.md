# 🚀 Terraform Infrastructure for Webservers

Этот проект использует Terraform для автоматического развертывания сетевой инфраструктуры и виртуальных машин в Yandex Cloud.

## 📝 Описание проекта

**Проект создает следующую инфраструктуру:**

- VPC-сеть: Сеть под названием webservers для изоляции ресурсов.
- Подсеть: Подсеть webservers в зоне ru-central1-b с CIDR 10.5.0.0/24.
- Виртуальные машины: Две прерываемые виртуальные машины на базе Ubuntu 20.04 LTS с автоматическим доступом по SSH.
    - Параметры ВМ: Каждая ВМ имеет 2 ядра, 2 ГБ ОЗУ и использует 5% гарантированной доли ядра.

## 🛠️ Как использовать

**1. Предварительные требования**

- Terraform: Установленный Terraform.
- SSH-ключ: Публичный SSH-ключ должен быть расположен по пути, указанному в переменной vms_ssh_root_key (у меня он находится  ~/.ssh/yandex-cloud/id_rsa).

**2. Конфигурация**

Перед развертыванием необходимо указать ваши данные для аутентификации в Yandex Cloud. Создайте файл *.tfvars и добавьте в него следующие переменные:

token           = "ваш_OAuth-токен"; "https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"

cloud_id        = "ваш_cloud_id" ; "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"

folder_id       = "ваш_folder_id"; "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"

default_zone    = "ru-central1-b"; "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"

**3. Запуск**

Выполните следующие команды в терминале:

-  Инициализация Terraform:

		terraform init

- Проверка плана развертывания:

		terraform plan

*Эта команда покажет, какие ресурсы будут созданы, изменены или удалены.*


- Развертывание инфраструктуры:

		terraform apply

*Подтвердите действие, введя **yes**.*


## 🧹 Очистка ресурсов

После завершения работы с инфраструктурой вы можете удалить все созданные ресурсы одной командой:

		terraform destroy

Это поможет избежать лишних расходов, так как ВМ хотя и прерываемые, но могут продолжать работать.
