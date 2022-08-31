variable "aci_user" {
  type = string
  description = "The user in ACI that will be used for the provider"
  default = "admin"
  sensitive = true
}

variable "aci_password" {
  type = string
  description = "The password for the user in ACI that will be used for the provider"
  default = "!v3G@!4@Y"
  sensitive = true
}

variable "aci_server" {
  type = string
  description = "The IP or FQDN for the ACI APIC that will be used for the provider"
  default = "sandboxapicdc.cisco.com"
  sensitive = true
}

variable "supported_service_types" {
  type = list(string)
}

variable "services" {
  type = map(object({
    service_type = string
    parent_service = optional(number)
    customer = optional(string)
    attributes = object({
      name = optional(string)
      gw4 = optional(string)
      gw6 = optional(string)
      device_id = optional(number)
      port_id = optional(number)
      vlan = optional(number)
    })
  }))
}

variable "customers" {
  type = map(set(string))
}

# variable "access_physical_domain" {
#   type = string
#   default = "phys"
# }