
# Create a Resource Group
resource "azurerm_resource_group" "dev-rg" {
  name     = "dev-rg"
  location = "eastus"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "dev-vnet" {
  name                = "dev-vnet"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  address_space       = ["10.12.0.0/16"]
}

resource "azurerm_subnet" "dev-subnet-1" {
  name                 = "dev-cluster-subnet"
  resource_group_name  = azurerm_resource_group.dev-rg.name
  virtual_network_name = azurerm_virtual_network.dev-vnet.name  
  address_prefixes     = ["10.12.1.0/24"]
}

# resource "azurerm_subnet" "cluster-subnet" {
#   name                 = "cluster-subnet"
#   resource_group_name  = azurerm_resource_group.dev-rg.name
#   virtual_network_name = azurerm_virtual_network.dev-vnet.name  
#   address_prefixes     = ["172.16.3.0/24"]
# }




resource "azurerm_kubernetes_cluster" "aks" {
  name                = "dev-aks-cluster"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  dns_prefix          = "devaks"
  kubernetes_version  = "1.29.0"
  
  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "standard_d2_v2"    
    auto_scaling_enabled = true
    min_count           = 1
    max_count           = 10
    #vnet_subnet_id      = azurerm_subnet.cluster-subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}
