output "tenant_dn" {
  value = aci_bridge_domain.this.tenant_dn
}

output "epg_dn" {
  value = aci_application_epg.this.id
}