resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "examle" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.1.0/24"
  service_endpoints = ["Microsoft.Storage"]
  route_table_id = azurerm_route_table.example.id
  network_security_group_id = azurerm_network_security_group.example.id
  private_endpoint_network_policies_enabled = true
  private_link_service_network_policies_enabled = true
}


