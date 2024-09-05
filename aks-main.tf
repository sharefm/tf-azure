
# Create a Resource Group
resource "azurerm_resource_group" "stage-rg" {
  name     = "stage-rg"
  location = "eastus"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "stage-vnet" {
  name                = "stage-vnet"
  location            = azurerm_resource_group.stage-rg.location
  resource_group_name = azurerm_resource_group.stage-rg.name
  address_space       = ["10.11.0.0/16"]
}

resource "azurerm_subnet" "stage-subnet-1" {
  name                 = "stage-cluster-subnet"
  resource_group_name  = azurerm_resource_group.stage-rg.name
  virtual_network_name = azurerm_virtual_network.stage-vnet.name  
  address_prefixes     = ["10.11.1.0/24"]
}

# resource "azurerm_subnet" "cluster-subnet" {
#   name                 = "cluster-subnet"
#   resource_group_name  = azurerm_resource_group.main-rg.name
#   virtual_network_name = azurerm_virtual_network.main-vnet.name  
#   address_prefixes     = ["172.16.3.0/24"]
# }




resource "azurerm_kubernetes_cluster" "aks" {
  name                = "stage-aks-cluster"
  location            = azurerm_resource_group.stage-rg.location
  resource_group_name = azurerm_resource_group.stage-rg.name
  dns_prefix          = "stageaks"
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
