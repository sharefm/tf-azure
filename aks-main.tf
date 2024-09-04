
# Create a Resource Group
resource "azurerm_resource_group" "main-rg" {
  name     = "main-resource-group"
  location = "eastus"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "main-vnet"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  address_space       = ["10.0.0.0/8"]
}

# Create a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "main-subnet"
  resource_group_name  = azurerm_resource_group.main-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.3.0.0/16"]
}



resource "azurerm_kubernetes_cluster" "aks" {
  name                = "main-aks-cluster"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  dns_prefix          = "mainaks"
  kubernetes_version  = "1.24.6"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_DS2_v3"    
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 10
    vnet_subnet_id      = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}
