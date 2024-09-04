
# Create a Resource Group
resource "azurerm_resource_group" "dev-rg" {
  name     = "devAKSResourceGroup"
  location = "eastus"
  
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "devAKSVNet"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  address_space       = ["10.0.0.0/8"]
}

# Create a Subnet-1
resource "azurerm_subnet" "subnet" {
  name                 = "devAKSSubnet"
  resource_group_name  = azurerm_resource_group.dev-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/16"]  
}


# Create an AKS Cluster
#resource "azurerm_kubernetes_cluster" "aks" {
#  name                = "devAKSCluster"
#  location            = azurerm_resource_group.dev-rg.location
#  resource_group_name = azurerm_resource_group.dev-rg.name
#  dns_prefix          = "devakscluster"
#  kubernetes_version  = "1.24.6"
#  
#
#  default_node_pool {
#    name                = "default"
#    node_count          = 2
#    vm_size             = "Standard_D2_v2"
#    vnet_subnet_id      = azurerm_subnet.subnet.id
#    enable_auto_scaling = true
#    min_count           = 2
#    max_count           = 4    
#    #availability_zones = ["1", "2", "3"]
#  }
#
#  identity {
#    type = "SystemAssigned"
#  }
#}
