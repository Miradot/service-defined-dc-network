variable "customer" {
  type = string
  description = "The name of the customer for the service"
}

variable "customer_services" {
  type    = set(string)
  default = []
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
      device_id = optional(number)
      port_id = optional(number)
      vlan = optional(number)
    })
  }))
}

variable "physical_domain" {
  type = string
  default = "phys"
}