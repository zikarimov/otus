module "webservers" {
  source = "/var/www/homework-test/terraform/infrastructure/modules/vms"

  token              = var.token
  cloud_id           = var.cloud_id
  folder_id          = var.folder_id
  environment        = "dev"
  project_name       = "webservers"
  default_zone       = var.default_zone
  subnet_cidr        = ["10.10.0.0/24"]
  vm_count           = 2
  vm_resources = {
    cpu           = 2
    ram           = 2
    disk          = 10
    core_fraction = 5
  }
  preemptible         = true
  ssh_public_key_path = var.ssh_public_key_path
}