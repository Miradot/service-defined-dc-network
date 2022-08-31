resource "aci_epg_to_static_path" "this" {
  application_epg_dn  = var.epg_dn
  tdn  = "topology/pod-1/paths-${var.device_id}/pathep-[eth1/${var.port_id}]"
  encap  = "vlan-${var.vlan}"
  mode = "untagged"
}