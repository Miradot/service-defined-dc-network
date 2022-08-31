resource "aci_tenant" "this" {
  name = "${var.customer}_${var.service_id}"
  name_alias = "${var.customer}_${var.name}"
  description = var.service_id
}