variable "token" {
    type        = string
    description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
    type        = string
    description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
    type        = string
    description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
    type        = string
    description = "Default zone"
    default     = "ru-central1-b"
}

variable "ssh_public_key_path" {
    type        = string
    description = "Path to ssh public key"
    default     = "~/.ssh/yandex-cloud/id_rsa" 
}