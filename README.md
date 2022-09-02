# Service defined data center network

Create a service defined data center network with terraform and Cisco ACI.

[![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/Miradot/service-defined-dc-network)

## Use Case Description

Cisco ACI is a good intent based plattform for data center networks. The platform involves alot of objects that could be hard to understand at first. For a service provider this objects then have to be translated to actual services that could be sold. This tools tries to abstract the ACI objects to give the user freedom to define provided services as objects in the `terraform.tfvars` file.

## Installation

- Install terraform by following the [Official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- ``` terraform init ``` to install all required terraform requirements.

## Configuration

Most of the configuration is done in the [`terraform.tfvars`](https://github.com/Miradot/service-defined-dc-network/blob/master/terraform.tfvars) file.
The tool is built on terraform. To understand how terraform works - please read [the official Terraform documentation](https://www.terraform.io/intro).

### Supported services

To use this tool with currently supported services - the user only have to define the `customers` and the `services` in `terraform.tfvars` file.

We are currently only supporting some services to create an example of how to build a service defined data center network. More services could be supported quite easily with some development.
Each service documentation is located in a `README.md` under each terraform module. There you'll find what input each service require and examples of to implement each services:

- [Tenant](https://github.com/Miradot/service-defined-dc-network/blob/master/modules/services/modules/tenant/README.md)
- [L3VPN](https://github.com/Miradot/service-defined-dc-network/blob/master/modules/services/modules/l3vpn/README.md)
- [L2VPN](https://github.com/Miradot/service-defined-dc-network/blob/master/modules/services/modules/l2vpn/README.md)
- [Access port](https://github.com/Miradot/service-defined-dc-network/blob/master/modules/services/modules/access_port/README.md)

### Required credential variables

To be able to run this provision tool towards your own ACI there are some required variables that needs to be defined in `terraform.tfvars`:

```hcl
aci_user = "test"
aci_password = "secret"
aci_server = "apic1.example.com"
```

By default the the tool is using [DevNet Allways-on APIC Simulator](https://sandboxapicdc.cisco.com/).
In this use-case, we only use local state files and assumes that where you run the deployment from have the possibility to reach the APIC you want to configure. If you would like to use Terraform Cloud, we recommend you to connect ACI with help of [Cisco Intersight Service for HashiCorp Terraform](https://developer.cisco.com/codeexchange/github/repo/bay-infotech/ACI-Terraform).

### Required ACI objects

Currently the tool only creates tenant objects in ACI. There are some required ACI fabric objects needed to make the services work:

- create one large Static VLAN pool
- create one physical domain called "phys", default is set otherwise you'll have to define the name of your physical domain in `terraform.tfvars`:

    ```hcl
    access_physical_domain = "name_of_your_physical_domain"
    ```

- Map the physical domain to the default aep.
- Map the physical domain to the created VLAN pool

## Usage example

Each service type have it's onw uniq attributes required. Check each service types own README.md to get the details.
In this example we will define the following services:

- 2 tenants - called "project1" and "project2"
- 2 l3vpn - called "inside" and "public"
- 1 l2vpn - called "inside" with the gateway "10.10.10.1/24"
- 1 access_port - terminating the l2vpn "inside" on device 101, port 1, vlan 10
- 1 access_port_native - terminating the l2vpn "inside" on device 101, port 10, vlan 101
- 1 access_port_tagged - terminating the l2vpn "inside" on device 101, port 10, vlan 100

### Define services

To be able to provision services, a object needs to be defined under the map `services`. The service object has a key which needs to be unique for the service. This will be the `service_id` that is a unique identifier of the defined service. The service object structure is quite simple by design:

- `service_type` - the type of the service (the sub-modules under the module service will have the same name)
- `parent_service` - a reference to the service that the specific service is a child of. This value will point to the parent service ID. This will be used to lookup values of the parent service.
- `attributes` - this will be dynamicly defined depended on what the `service_type` value is. Each service requires some attributes - define them here.

To be able to use this tool we need to define our services in the `terraform.tfvars` file:

```hcl
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
            gw4 = "10.10.10.1/24"
        }
    }
    4 = {
        service_type = "access_port"
        parent_service = 3
        attributes = {
            device_id = 101
            port_id = 1
            vlan = 10
        }
    }
    5 = {
        service_type = "access_port_tagged"
        parent_service = 3
        attributes = {
            device_id = 101
            port_id = 10
            vlan = 100
        }
    }
    6 = {
        service_type = "access_port_native"
        parent_service = 9
        attributes = {
            device_id = 101
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
        parent_service = 1
        attributes = {
            name = "inside"
            gw4 = "10.10.10.1/24"
        }
    }
}
```

### Define the customers

Each service defined above needs to be mapped to a customer. By doing this we can define the services in the inventory beforhand without actually provision the customer. When we want to provision a customer and it's services - we need to define the `customers`:

```hcl
customers = {
    "example1" = [1,3,4,5,6,8]
    "example2" = [2,7]
}
```

Here we define 2 customers with a list of the `service_id`s of each service that will be related to it's customers.

### Define the supported service types

The `supported_service_types` will determain which service types that should be possible to implement. This list works as a filter. Only service types defined in the `supported_service_types` will be provisioned. This makes it easier to develop new services.

### Provision the infrastructure

Run the following command from the repositories root in the terminal to provision the ACI infrastructure:

```bash
terraform init
terraform plan
terraform apply
```

## Known issues

All know issues are tracked in [GitHub Issues](https://github.com/Miradot/service-defined-dc-network/issues). If you find any issues, please report it there.

## Getting help

If you have any problem getting the tool to work, please creates issues in [GitHub Issues](https://github.com/Miradot/service-defined-dc-network/issues).

## Getting involved

This project is supposed to work as a tutorial on how to get started with service defined data center network. If you have any suggestions on what else to include, feel free to reach ut by creating an issue.

## Credits and references

This project is ispired by [Terraform Intersight Kubernetes Service modules](https://registry.terraform.io/modules/terraform-cisco-modules/iks/intersight/)

----

## Licensing info

Copyright (c) 2022, Miradot AB

This code is licensed under the MIT License. See [LICENSE](https://github.com/Miradot/service-defined-dc-network/blob/master/LICENSE) for details.

----
