terraform {
  backend "http" {}
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone      = var.default_zone
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}
