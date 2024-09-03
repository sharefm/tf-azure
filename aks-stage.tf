# Configure the Azure Provider
provider "azurerm" {
  features { }
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "stageAKSResourceGroup"
  location = "eastus"
}

## Create a Virtual Network
#resource "azurerm_virtual_network" "vnet" {
#  name                = "stageAKSVNet"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  address_space       = ["10.0.0.0/8"]
#}
#
## Create a Subnet
#resource "azurerm_subnet" "subnet" {
#  name                 = "stageAKSSubnet"
#  resource_group_name  = azurerm_resource_group.rg.name
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  address_prefixes     = ["10.2.0.0/16"]
#}
#
## Get Available Availability Zones
#data "azurerm_availability_zones" "available" {
#  resource_group_name = azurerm_resource_group.rg.name
#}
#
## Create an AKS Cluster
#resource "azurerm_kubernetes_cluster" "aks" {
#  name                = "stageAKSCluster"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  dns_prefix          = "stageakscluster"
#  kubernetes_version  = "1.24.6"
#
#  default_node_pool {
#    name                = "default"
#    node_count          = 2
#    vm_size             = "Standard_D2_v2"
#    availability_zones  = [data.azurerm_availability_zones.available.names[0], data.azurerm_availability_zones.available.names[1]]
#    enable_auto_scaling = true
#    min_count           = 2
#    max_count           = 5
#    vnet_subnet_id      = azurerm_subnet.subnet.id
#  }
#
#  identity {
#    type = "SystemAssigned"
#  }
#}
