resource "azurerm_storage_share" "aks-files" {
  name                 = "rg-shared-aks-1-files"
  storage_account_name = var.storageAccountName
  quota                = var.fileShareQuota

  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = "rwdl"
      start       = "2022-09-30T00:00:00.0000000Z"
      expiry      = "2024-10-01T23:59:00.0000000Z"
    }
  }
}
