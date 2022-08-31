
variable "service_id" {
  type = number
  description = "The ID of the service"
}

variable "name" {
  type = string
  description = "The name of the service"
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

variable "device_id" {
  type = number
  description = "The Node ID in ACI of the device"
}

variable "port_id" {
  type = number
  description = "The port number of the port that the service should be configured on"
}

variable "vlan" {
  type = number
  description = "The vlan that the service should be configured on"
}

variable "epg_dn" {
  type = string
  description = "The dn to the ACI epg provided by module l2vpn"
}
