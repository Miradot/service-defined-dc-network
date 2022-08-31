output "vrf_dn" {
  value = aci_vrf.this.id
}

output "tenant_dn" {
  value = aci_vrf.this.tenant_dn
}