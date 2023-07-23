output "resourcegroup_name" {

    value = azurerm_resource_group.tfmodule-rg
  
}

output "vnet" {
  value = azurerm_virtual_network.tfmodule-vnet
  
}
