variable "default_zone" {
  description = "Yandex Cloud zone"
  type        = string
}

variable "token" {
  description = "Yandex Cloud OAuth token"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}

variable "image_id" {
  description = "ID of the image to use for the boot disk"
  type        = string
  default     = "fd82kcha04mgqerskh8n" # Ubuntu 24.04 LTS
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}
