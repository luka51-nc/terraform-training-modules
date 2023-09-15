resource "azurerm_storage_account" "sa" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  count = length(var.data_containers)

  name                  = var.data_containers[count.index].name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = var.data_containers[count.index].access_type
}

resource "azurerm_storage_blob" "sb_plain_text" {
  for_each = local.plain_text_files

  name                   = "${each.value.name}.${each.value.file_extension}"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = var.data_containers[index(var.data_containers.*.access_type, "blob")].name
  type                   = "Block"
  source_content         = each.value.content
}

resource "azurerm_storage_blob" "sb_private" {
  for_each = local.secure_files

  name                   = "${each.value.name}.${each.value.file_extension}"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = var.data_containers[index(var.data_containers.*.access_type, "private")].name
  type                   = "Block"
  source_content         = each.value.content
}