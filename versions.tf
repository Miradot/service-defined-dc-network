terraform {
    required_version  = "1.2.7"
    experiments = [module_variable_optional_attrs]
    required_providers {
        aci = {
        source = "CiscoDevNet/aci"
        version = "2.5.2"
        }
    }
}