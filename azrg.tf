resource "azurerm_resource_group" "tfmodule-rg" {
    name = var.resourcegroup_name
    location = var.location
    tags = local.tag
}

