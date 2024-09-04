# Configure the Azure Provider

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"      
      version = ">= 3.0.0"
    }
    
  }

  # backend "azurerm" {
  #   #resource_group_name  = "general-rg"
  #   #storage_account_name = "simgeneraltfstatestorage"
  #   #container_name       = "tf-stat-container"
  #   #key                  = "main.tfstate"
  #   #tenant_id            = "f916afa5-dd10-4aaf-aa50-e757519da337"
  #   #subscription_id      = "b799688b-a05a-46da-a97e-78ebae44a60e"
  # }

}

provider "azurerm" {
    features { }
}



