output "network_id" {
  description = "ID of the created network"
  value       = yandex_vpc_network.base_network.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = yandex_vpc_subnet.base_network.id
}

output "vm_external_ips" {
  description = "External IP addresses of VMs"
  value       = yandex_compute_instance.webservers[*].network_interface.0.nat_ip_address
}

output "vm_internal_ips" {
  description = "Internal IP addresses of VMs"
  value       = yandex_compute_instance.webservers[*].network_interface.0.ip_address
}

output "vm_names" {
  description = "Names of created VMs"
  value       = yandex_compute_instance.webservers[*].name
}