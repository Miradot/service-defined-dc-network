# L3VPN

This module creates a VRF object in the ACI fabric under the parent service `tenant`. This service can be used by l2vpn services but there could be developed further to support transit peering, route leaking etc.

## Input values

| Name                 | Type   | Example                 | Description of value                   |
|----------------------|--------|-------------------------|----------------------------------------|
| service_id           | number | 1                       | uniq id to refer to a specific service |
| name                 | string | "inside"                | Name of the L3VPN/VRF                  |
| customer             | string | "customer1"             | Name of the Customer                   |
| parent_service       | number | 3                       | Refere to the parent service_id        |
| tenant_dn            | string | "id=uni/tn-customer1_7" | DN reference inherited from tenant     |

Check of more details in the `variables.tf` file.

## Return values

| Name      | Description of value                  |
|-----------|---------------------------------------|
| tenant_dn | The DN for the Tenant object (inherit)|
| vrf_dn    | The DN for the created VRF object     |

Check of more details in the `output.tf` file.

## Required parent service

- [`tenant`](../tenant/)

There is no input validation of this at the moment but it should be possible to use the `lookup(var.services, var.parent_service)`...

## Supported child services

- [`l2vpn`](../l2vpn/)

## Example

### Services

In the `services` map - define objects that represent each service you want to define:

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
        service_type = "l3vpn"
        parent_service = 1
        attributes = {
            name = "inet"
        }
    }
}
```

This example will create 2 L3VPN services called "inside" and "inet" under 1 Tenant service called "project".

### Customers

In the `customers` map - define a object with the customer name as key and a list of services as value:

```hcl
customers = {
    "example_customer1" = [1,2,3]
}
```

Only all the services that are defined in the list in the value section will be provissioned. Here will only the tenant-service with the service_id `1` be provissioned because we only have that one defined under the customer `example_customer1`
