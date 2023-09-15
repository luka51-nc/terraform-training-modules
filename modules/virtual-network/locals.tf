module "naming" {
  source = "Azure/naming/azurerm"
  prefix = [var.project_prefix, "app"]
  suffix = [var.environment]
}

locals {
    virtual_network_name        = module.naming.virtual_network.name
  network_security_group_name = module.naming.network_security_group.name
}