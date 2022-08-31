# Access port tagged - TODO

This module creates a access port service for l2vpn services.

## Input values

| Name                 | Type   | Description of value |
|----------------------|--------|----------------------|
| service_id           | number |                      |
| name                 | string |                      |
| customer             | string |                      |
| parent_service       | number |                      |
| attributes           | object |                      |
| attributes.device_id | number |                      |
| attributes.port_id   | number |                      |
| attributes.vlan_id   | number |                      |
| epg_dn               | string |                      |

## Return values

| Name | Description of value                      |
|------|-------------------------------------------|
| dn   | DN reference to the created object in ACI |

## Required parent service

- `l2vpn`

There is no input validation of this at the moment but it should be possible to use the `lookup(var.services, var.parent_service)`...

## Supported child services

There is currently not supported child services.

## Example

### Services

In the `services` map. Define the folling objects:

```hcl
services = {
    1 = {
        service_type = "tenant"
        attributes = {
            name = "project2"
        }
    }
    2 = {
        service_type = "l3vpn"
        parent_service = 1
        attributes = {
            name = "inside"
        }
    }
    3 = {
        service_type = "l2vpn"
        parent_service = 2
        attributes = {
            name = "inside_net1"
            gw4 = "10.0.1.1/24
        }
    }
    4 = {
        service_type = "l2vpn"
        parent_service = 2
        attributes = {
            name = "inside_net2"
            gw4 = "10.0.2.1/24
        }
    }
    5 = {
        service_type = "access_port_tagged"
        parent_service = 3
        attributes = {
            device_id = 101
            port_id = 1
            vlan = 1011
        }
    }
    6 = {
        service_type = "access_port_tagged"
        parent_service = 4
        attributes = {
            device_id = 101
            port_id = 1
            vlan = 1012
        }
    }
}
```

- The `services.$key.service_type` defines what type of service it is and all the service attributes should be specified under the `attributes` for each service.
- The `services.$key` = `service_id`

### Customers

In the `customers` map - define a object with the customer name as key and a list of services as value:

```hcl
customers = {
    "example_customer1" = [1,2,3,4,5]
}
```

Only all the services that are defined in the list in the value section will be provissioned. Here will only the tenant-service with the service_id `1` be provissioned because we only have that one defined under the customer `example_customer1`
