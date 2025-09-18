terraform {
    required_providers {
        yandex = {
            source  = "yandex-cloud/yandex"
            version = "0.158.0"
        }
    }

backend "http" {
    address         = "https://otusteam.gitlab.yandexcloud.net/api/v4/projects/1050/terraform/state/prod-webservers"
    lock_address    = "https://otusteam.gitlab.yandexcloud.net/api/v4/projects/1050/terraform/state/prod-webservers/lock"
    unlock_address  = "https://otusteam.gitlab.yandexcloud.net/api/v4/projects/1050/terraform/state/prod-webservers/lock"
    lock_method     = "POST"
    unlock_method   = "DELETE"
    retry_wait_min  = 5
    }

}
provider "yandex" {
    token       = var.token
    cloud_id    = var.cloud_id
    folder_id   = var.folder_id
    zone        = var.default_zone
}

