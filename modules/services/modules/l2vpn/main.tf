# resource "null_resource" "l2vpn" {
#   triggers = {
#     service_id = var.service_id
#     # name = var.name
#     customer = var.customer
#     # name = module.customers.example1.module.services.1.module.l3vpn.0.data.aci_tenant.this.id
#   }
# }

resource "aci_bridge_domain" "this" {
  name = var.name
  tenant_dn = var.tenant_dn
  relation_fv_rs_ctx = var.vrf_dn
  unk_mac_ucast_act = "flood"
}

resource "aci_subnet" "this" {
  parent_dn        = aci_bridge_domain.this.id
  description      = "subnet"
  ip               = "${var.gw4}"
  name_alias       = "${var.name}"
  scope            = ["private"]
}

resource "aci_application_profile" "this" {
  tenant_dn  = var.tenant_dn
  name       = "l2vpn"
}

resource "aci_application_epg" "this" {
  application_profile_dn  = aci_application_profile.this.id
  name                    = var.name
  relation_fv_rs_bd       = aci_bridge_domain.this.id
}

data "aci_physical_domain" "this" {
  name  = var.physical_domain
}

resource "aci_epg_to_domain" "this" {
  application_epg_dn    = aci_application_epg.this.id
  tdn                   = data.aci_physical_domain.this.id
}