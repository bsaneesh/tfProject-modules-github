resource "azurerm_virtual_network" "tfmodule-vnet" {
    name = var.vnetname
    location = var.location
    address_space = [var.vnetaddress]
    resource_group_name = var.resourcegroup_name
    depends_on = [azurerm_resource_group.tfmodule-rg]
}

resource "azurerm_subnet" "tfmodule-subnet" {
  for_each = var.subnetnames
  name = each.key
  resource_group_name = var.resourcegroup_name
  virtual_network_name = var.vnetname
  address_prefixes = cidrsubnets(var.vnetaddress,8,index(tolist(var.subnetnames),each.key))
  depends_on = [azurerm_virtual_network.tfmodule-vnet]
}