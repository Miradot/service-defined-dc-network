
variable "service_id" {
  type = number
  description = "The ID of the service"
}

variable "name" {
  type = string
  description = "The name of the service"
}

variable "gw4" {
  type = string
  description = "The IP that should be configured on the SVI of th BD in ACI"
}

variable "customer" {
  type = string
  description = "The name of the customer"
}

variable "parent_service" {
  type = number
  description = "The ID of the parent service"
  default = null
}

# variable "attributes" {
#   type    = object({
#       name = optional(string)
#       gw4 = optional(string)
#   })
# }

variable "tenant_dn" {
  type = string
  description = "The dn to the ACI tenant provided by module tenant"
}

variable "vrf_dn" {
  type = string
  description = "The dn to the ACI VRF provided by module l3vpn"
}

variable "physical_domain" {
  type = string
  description = "The physical domain that will be used for access_ports"
  default = "phys"
}