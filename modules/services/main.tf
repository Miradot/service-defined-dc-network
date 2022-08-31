module "tenant" {
  source = "./modules/tenant"
  for_each = {
    for k, v in var.customer_services : k => v
    if contains(var.supported_service_types, var.services["${k}"].service_type) && var.services["${k}"].service_type == "tenant"
  }
  service_id = each.key
  customer = var.customer
  name = var.services["${each.key}"].attributes.name
  depends_on = []
}

module "l3vpn" {
  source = "./modules/l3vpn"
  for_each = {
    for k, v in var.customer_services : k => v
    if contains(var.supported_service_types, var.services["${k}"].service_type) && var.services["${k}"].service_type == "l3vpn"
  }
  service_id = each.key
  name = "${var.services["${each.key}"].service_type}_${each.key}_${var.services["${each.key}"].attributes.name}"
  customer = var.customer
  tenant_dn = module.tenant["${var.services["${each.key}"].parent_service}"].tenant_dn
  parent_service = var.services["${each.key}"].parent_service
  depends_on = []
}

module "l2vpn" {
  source = "./modules/l2vpn"
  for_each = {
    for k, v in var.customer_services : k => v
    if contains(var.supported_service_types, var.services["${k}"].service_type) && var.services["${k}"].service_type == "l2vpn"
  }
  service_id = each.key
  name = "${var.services["${each.key}"].service_type}_${each.key}_${var.services["${each.key}"].attributes.name}"
  gw4 = var.services["${each.key}"].attributes.gw4
  customer = var.customer
  tenant_dn = module.l3vpn["${var.services["${each.key}"].parent_service}"].tenant_dn
  vrf_dn = module.l3vpn["${var.services["${each.key}"].parent_service}"].vrf_dn
  physical_domain = var.physical_domain
  parent_service = var.services["${each.key}"].parent_service
  depends_on = []
}

module "access_port" {
  source = "./modules/access_port"
  for_each = {
    for k, v in var.customer_services : k => v
    if contains(var.supported_service_types, var.services["${k}"].service_type) && var.services["${k}"].service_type == "access_port"
  }
  service_id = each.key
  customer = var.customer
  name = "${var.services["${each.key}"].service_type}_${each.key}"
  epg_dn = module.l2vpn["${var.services["${each.key}"].parent_service}"].epg_dn
  parent_service = var.services["${each.key}"].parent_service
  device_id = var.services["${each.key}"].attributes.device_id
  port_id = var.services["${each.key}"].attributes.port_id
  vlan = var.services["${each.key}"].attributes.vlan
  depends_on = []
}

module "access_port_native" {
  source = "./modules/access_port_native"
  for_each = {
    for k, v in var.customer_services : k => v
    if contains(var.supported_service_types, var.services["${k}"].service_type) && var.services["${k}"].service_type == "access_port_native"
  }
  service_id = each.key
  customer = var.customer
  name = "${var.services["${each.key}"].service_type}_${each.key}"
  epg_dn = module.l2vpn["${var.services["${each.key}"].parent_service}"].epg_dn
  parent_service = var.services["${each.key}"].parent_service
  device_id = var.services["${each.key}"].attributes.device_id
  port_id = var.services["${each.key}"].attributes.port_id
  vlan = var.services["${each.key}"].attributes.vlan
  depends_on = []
}

module "access_port_tagged" {
  source = "./modules/access_port_tagged"
  for_each = {
    for k, v in var.customer_services : k => v
    if contains(var.supported_service_types, var.services["${k}"].service_type) && var.services["${k}"].service_type == "access_port_tagged"
  }
  service_id = each.key
  customer = var.customer
  name = "${var.services["${each.key}"].service_type}_${each.key}"
  epg_dn = module.l2vpn["${var.services["${each.key}"].parent_service}"].epg_dn
  parent_service = var.services["${each.key}"].parent_service
  device_id = var.services["${each.key}"].attributes.device_id
  port_id = var.services["${each.key}"].attributes.port_id
  vlan = var.services["${each.key}"].attributes.vlan
  depends_on = []
}
