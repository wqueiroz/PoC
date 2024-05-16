terraform {
  backend "azurerm" {
    resource_group_name  = "rg-keda-poc"
    storage_account_name = "tfstatedd972bd4a91a83bf"
    container_name       = "terraform-state-files"
    key                  = "rg-keda-poc.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = false
    }
  }
}
