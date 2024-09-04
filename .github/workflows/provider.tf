# Configure the Azure Provider

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.51.0"
    }
    
  }

}

provider "azurerm" {
    features { }
}
