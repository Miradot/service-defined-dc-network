variable "customer" {
  type = string
  description = "The name of the customer that will be deployed"
}

variable "customer_services" {
  type    = set(string)
  default = []
  description = "Sets of service_ids that will be deployed under this customer"
}

variable "supported_service_types" {
  type = list(string)
  description = "List of the current supported service types. If develop more service types, it will have to be added to the list when it services should be deployed."
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
  description = "The actual services definitions. Depending on what type of service, different paramters are required."
}

variable "physical_domain" {
  type = string
  default = "phys"
  description = "The physical domain that should be mapped to under each EPG that is a L2VPN"
}