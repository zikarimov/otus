// Auxiliary resources for Compute Instance
resource "yandex_vpc_network" "network" {
  name = "otus-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "otus-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

//
// Create a new Compute Disk.
//
resource "yandex_compute_disk" "disk" {
  name     = "otus-disk"
  type     = "network-ssd"
  zone     = var.default_zone
  image_id = var.image_id
  size     = 50
}

//
// Create a new Compute Instance
//
resource "yandex_compute_instance" "vm" {
  name        = "otus-vm"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    disk_id = yandex_compute_disk.disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
  }
}

