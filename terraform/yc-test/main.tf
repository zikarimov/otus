resource "yandex_vpc_network" "base_network" {
    name = "webservers"
}

resource "yandex_vpc_subnet" "base_network" {
    name            = "webservers"
    zone            = var.default_zone
    network_id      = yandex_vpc_network.base_network.id
    v4_cidr_blocks  = ["10.5.0.0/24"] 
}

data "yandex_compute_image" "ubuntu" {
    family = var.vm_web_image
}

resource "yandex_compute_instance" "webservers" {
    name        = "webservers-${count.index+1}"
    platform_id = "standard-v1"
    count = 2
    resources {
        cores           = 2
        memory          = 2
        core_fraction   = 5
    }
    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
        }
    }

    scheduling_policy {
        preemptible = true
    }

    network_interface {
        subnet_id   = yandex_vpc_subnet.base_network.id
        nat         = true
    }

    metadata = {
        serial-port-enable  = local.serial-port
        ssh-keys            = "ubuntu:${local.ssh-keys}"
    }

}


