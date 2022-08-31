resource "aci_vrf" "this" {
  name = var.service_id
  name_alias = var.name
  tenant_dn = var.tenant_dn
}