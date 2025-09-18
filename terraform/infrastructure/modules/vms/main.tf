resource "yandex_vpc_network" "base_network" {
  name        = "${var.environment}-${var.project_name}-network"
  description = "Network for ${var.environment} environment"
}

resource "yandex_vpc_subnet" "base_network" {
  name           = "${var.environment}-${var.project_name}-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.base_network.id
  v4_cidr_blocks = var.subnet_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "webservers" {
  count       = var.vm_count
  name        = "${var.environment}-${var.project_name}-${count.index + 1}"
  platform_id = var.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_resources.cpu
    memory        = var.vm_resources.ram
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources.disk
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.base_network.id
    nat       = var.enable_nat
  }

  metadata = {
    serial-port-enable  = var.serial_port_enable
    ssh-keys            = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  labels = {
    environment = var.environment
    project     = var.project_name
  }
}