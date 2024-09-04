
# Create a Resource Group
resource "azurerm_resource_group" "main-rg" {
  name     = "main-rg"
  location = "eastus"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "main-vnet" {
  name                = "main-vnet"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "main-subnet" {
  name                 = "main-subnet"
  resource_group_name  = azurerm_resource_group.main-rg.name
  virtual_network_name = azurerm_virtual_network.main-vnet.name  
  address_prefixes     = ["10.0.1.0/24"]
}



resource "azurerm_kubernetes_cluster" "aks" {
  name                = "main-aks-cluster"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  dns_prefix          = "mainaks"
  kubernetes_version  = "1.30.0"
  
  default_node_pool {
    name                = "default-node-pool"
    node_count          = 1
    vm_size             = "standard_d2_v2"    
    auto_scaling_enabled = true
    min_count           = 1
    max_count           = 10
    vnet_subnet_id      = azurerm_subnet.main-subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}
