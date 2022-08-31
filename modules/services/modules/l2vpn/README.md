# Tenant

This module creates the following ACI objects under the refered `vrf_dn` and `tenant_dn` ACI objects:

- 1 Bridge Domain called the value of `attributes.name`
- 1 Subnet under the created Bridge Domain with the IP of the value of `attributes.gw4`
- 1 Application Profile called `l2vpn`
- 1 End Point Group called the value of `name` that is mapped to the created Bridge Domain. It will also have a physical domain mapped to the EPG called `phys`

## Input values

| Name                 | Type   | Description of value |
|----------------------|--------|----------------------|
| service_id           | number |                      |
| name                 | string |                      |
| customer             | string |                      |
| parent_service       | number |                      |
| attributes           | object |                      |
| attributes.name      | string |                      |
| attributes.gw4       | string |                      |
| tenant_dn            | string |                      |
| vrf_dn               | string |                      |
| physical_domain      | string |                      |

Check of more details in the `variables.tf` file.

## Return values

| Name      | Description of value                 |
|-----------|--------------------------------------|
| tenant_dn | The DN for the Tenant object         |
| epg_dn    | The DN for the created EPG object    |

Check of more details in the `output.tf` file.

## Required parent service

- [`l3vpn`](../l3vpn/) - should be developed to not require this when there is no unicast routing involed (no gw4 is specified)

There is no input validation of this at the moment but it should be possible to use the `lookup(var.services, var.parent_service)`...

## Supported child services

- [`access_port`](../access_port/)
- [`access_port_native`](../access_port_native/)
- [`access_port_tagged`](../access_port_tagged/)

## Example

### Services

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
        service_type = "l2vpn"
        parent_service = 2
        attributes = {
            name = "inside_network1"
            gw4 = "10.0.0.1/24"
        }
    }
}
```

This will create one l2vpn service with the name "inside_network1" and the IP address set to "10.0.0.1/24". It will also create the parent services defined: L3vpn called "inside" and tenant called "project20".

### Customers

In the `customers` map - define a object with the customer name as key and a list of services as value:

```hcl
customers = {
    "example_customer1" = [1,2,3]
}
```

Only all the services that are defined in the list in the value section will be provissioned. Here will only the tenant-service with the service_id `1` be provissioned because we only have that one defined under the customer `example_customer1`
