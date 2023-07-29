resource "azurerm_network_security_group" "tfproject-nsg" {
  for_each = var.nsgnames
  name                = "tf-project-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resourcegroup_name
  }

resource "azurerm_subnet_network_security_group_association" "tfproject-nsgtosubnet" {
  for_each = var.nsgnames
  subnet_id                 = azurerm_subnet.tfmodule-subnet[each.value].id
  network_security_group_id = azurerm_network_security_group.tfproject-nsg[each.key].id
}



resource "azurerm_network_security_rule" "tfproject-nsgrules" {
  for_each = {for rule in var.nsgrules:rule.id=>rule} # this will take "id" parameter in the "nsgrule module call block " as the "key" and rest of the parameters as "values"
  name                        = "${each.value.access}-${each.value.destination_port_range}"
  priority                    = "${each.value.priority}"
  direction                   = "Inbound"
  access                      = "${each.value.access}"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "${each.value.destination_port_range}"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup_name
  network_security_group_name = azurerm_network_security_group.tfproject-nsg[each.value.network_security_group_name].name
}