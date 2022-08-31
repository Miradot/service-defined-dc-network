# Transit peer service - TODO

This module creates a transit peer for a l3vpn

## Input values

| Name                 | Type   | Example                 | Description of value                   |
|----------------------|--------|-------------------------|----------------------------------------|
| service_id           | number | 1                       | uniq id to refer to a specific service |
| name                 | string | "inside"                |                                        |
| customer             | string | "customer1"             |                                        |
| parent_service       | number | 3                       | refere to the parent service_id        |
| attributes           | object |                         |                                        |
| attributes.name      | string | "inside"                |                                        |
| tenant_dn            | string | "id=uni/tn-customer1_7" |                                        |

## Return values

| Name      | Description of value                  |
|-----------|---------------------------------------|
| tenant_dn | The DN for the Tenant object (inherit)|
| vrf_dn    | The DN for the created VRF object     |

## Required parent service

- `l3vpn`-service

There is no input validation of this at the moment but it should be possible to use the `lookup(var.services, var.parent_service)`...

## Supported child services

- There is currently no suppport for child services.

## Example

In the `services` map. Define a object:

```hcl
services = {
    1 = {
        service_type = "tenant"
        attributes = {
            name = "project20"
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
        service_type = "transit"
        parent_service = 1
        attributes = {
            name = "inet"
        }
    }
}
```

In the `customers` map - define a object with the customer name as key and a list of services as value:

```hcl
customers = {
    "example_customer1" = [1,2,3]
}
```

Only all the services that are defined in the list in the value section will be provissioned. Here will only the tenant-service with the service_id `1` be provissioned because we only have that one defined under the customer `example_customer1`
