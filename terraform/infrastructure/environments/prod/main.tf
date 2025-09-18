module "webservers" {
    source = "/var/www/homework-test/terraform/infrastructure/modules/vms"

    token           = var.token
    cloud_id        = var.cloud_id
    folder_id       = var.folder_id
    environment     = "prod"
    project_name    = "webservers"
    default_zone    = var.default_zone
    subnet_cidr     = ["10.20.0.0/24"]
    vm_count        = 2
    vm_resources = {
        cpu             = 4
        ram             = 4
        disk            = 20
        core_fraction   = 20
    }
    preemptible          = true
    ssh_public_key_path = var.ssh_public_key_path
}

