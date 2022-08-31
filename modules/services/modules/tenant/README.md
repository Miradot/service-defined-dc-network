# Tenant service

This module creates the ACI tenant and returning the DN of the object as `tenant_dn`.

## Input values

| Name                 | Type   | Example                 | Description of value                   |
|----------------------|--------|-------------------------|----------------------------------------|
| service_id           | number | 1                       | uniq id to refer to a specific service |
| name                 | string | "project20"             | Name of the tenant                     |
| customer             | string | "customer1"             | Name of the Customer                   |

Check of more details in the `variables.tf` file.

## Return values

| Name      | Description of value                 |
|-----------|--------------------------------------|
| tenant_dn | The DN for the created Tenant object |

Check of more details in the `output.tf` file.

## Required parent service

There is no required parent services for this service type.

## Supported child services

- [`l3vpn`](../l3vpn/)

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
        service_type = "tenant"
        attributes = {
            name = "project21"
        }
    }
}
```

In the `customers` map - define a object with the customer name as key and a list of services as value:

```hcl
customers = {
    "example_customer1" = [1]
}
```

Only all the services that are defined in the list in the value section will be provissioned. Here will only the tenant-service with the service_id `1` be provissioned because we only have that one defined under the customer `example_customer1`
