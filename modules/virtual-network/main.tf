resource "azurerm_network_security_group" "nsg" {
  name                = local.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/24"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.0.0/25"
    security_group = azurerm_network_security_group.nsg.id
  }

  tags = {
    training = "Terraform"
  }

  depends_on = [var.resource_group_name]
}