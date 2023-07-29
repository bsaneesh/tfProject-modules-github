resource "azurerm_public_ip" "tfmodule-bastionPip" {
  count = var.bastion_required ? 1 : 0
  name                = var.bastionpipname
  location            = var.location
  resource_group_name = var.resourcegroup_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "tfmodule-bastionhost" {
  count = var.bastion_required ? 1 : 0
  name                = var.bastionhostname
  location            = var.location
  resource_group_name = var.resourcegroup_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.tfmodule-bastion-subnet[0].id # This is because we are creating the resources with "count" function, even that is a boolean value
    public_ip_address_id = azurerm_public_ip.tfmodule-bastionPip[0].id  # This is because we are creating the resources with "count" function, even that is a boolean value
  }
}