provider "aci" {
    username = var.aci_user
    password = var.aci_password
    url      = "https://${var.aci_server}"
    insecure = true
}

module "services" {
  source = "./modules/services"
  for_each = var.customers
  customer = each.key
  customer_services = each.value
  services = var.services
  supported_service_types = var.supported_service_types
}
