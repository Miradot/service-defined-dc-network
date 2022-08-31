
variable "service_id" {
  type = number
  description = "The ID of the service"
}

variable "parent_service" {
  type = number
  description = "The ID of the parent service"
  default = null
}

variable "name" {
  type = string
  description = "The name of the service"
}

variable "customer" {
  type = string
  description = "The name of the customer"
}

variable "tenant_dn" {
  type = string
  description = "The dn to the ACI tenant provided by module tenant"
}

variable "attributes" {
  type    = object({
      name = optional(string)
      gw4 = optional(string)
  })
}