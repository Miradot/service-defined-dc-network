# Services module

This module creates a customers services

## Example of inventory

```hcl

supported_service_types = [
    "l3vpn",
    "l2vpn",
    "access_port",
    "access_port_tagged",
    "access_port_native",
    "tenant"
]

customers = {
    "example1" = [1,3,4,8]
    "example2" = [2,5,6,7,9]
}

services = {
    1 = {
        service_type = "l3vpn"
        parent_service = 8
        attributes = {
            name = "inside"
        }
    }
    2 = {
        service_type = "l3vpn"
        parent_service = 7
        attributes = {
            name = "public"
        }
    }
    3 = {
        service_type = "l2vpn"
        parent_service = 1
        attributes = {
            name = "inside"
        }
    }
    4 = {
        service_type = "access_port"
        parent_service = 3
        attributes = {
            device_id = 301
            port_id = 1
            vlan = 10
        }
    }
    5 = {
        service_type = "access_port_tagged"
        parent_service = 2
        attributes = {
            device_id = 301
            port_id = 10
            vlan = 100
        }
    }
    6 = {
        service_type = "access_port_native"
        parent_service = 2
        attributes = {
            device_id = 301
            port_id = 10
            vlan = 101
        }
    }
    7 = {
        service_type = "tenant"
        attributes = {
            name = "project1"
        }
    }
    8 = {
        service_type = "tenant"
        attributes = {
            name = "project1"
        }
    }
    9 = {
        service_type = "l2vpn"
        parent_service = 2
        attributes = {
            name = "inside"
        }
    }
}

```
