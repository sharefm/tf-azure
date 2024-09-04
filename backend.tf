
terraform {
  backend "azurerm" {
    resource_group_name  = "general-rg"
    storage_account_name = "generaltfstatestorage"
    container_name       = "tf-stat-container"
    key                  = "your_tfstate_file.tfstate"
    tenant_id            = "f916afa5-dd10-4aaf-aa50-e757519da337"
    subscription_id      = "f916afa5-dd10-4aaf-aa50-e757519da337"
  }
}