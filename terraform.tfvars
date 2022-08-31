# infra = {
#     access-sw1 = {
#         ports = {
#             Eth1/1 = {
#                 type = l2_access
#                 supported_service_types = [access_port]
#                 enabled = true
#             }
#             Eth1/2 = {
#                 type = l2_trunk
#                 supported_service_types = [
#                     access_port_native,
#                     access_port_tagged,
#                     access_port_tagged
#                 ]
#                 enabled = true
#             }
#         }
#     }
# }


# access_physical_domain = "physdom"

supported_service_types = [
    "tenant",
    "l3vpn",
    "l2vpn",
    "access_port",
    "access_port_tagged",
    "access_port_native"
]

customers = {
    "example1" = [1,3,4,5,6,8,9]
    "example2" = [2,7]
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

