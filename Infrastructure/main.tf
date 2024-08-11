# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.115.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "Personal"
      storage_account_name = "ydsunstorageaccount"
      container_name       = "$web"
      key                  = "terraform.tfstate"
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "Personal"
  location = "westus2"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "ydsunstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  access_tier = "Hot"
  min_tls_version = "TLS1_2"
  allow_nested_items_to_be_public = false
  cross_tenant_replication_enabled = false
  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "indexhtml" {
  name                   = "frontend/index.html"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../frontend/index.html"
  content_type           = "text/html"
}
resource "azurerm_storage_blob" "css" {
  name                   = "frontend/css/style.css"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../frontend/css/style.css"
  content_type           = "text/css"
}
resource "azurerm_storage_blob" "img" {
  name                   = "frontend/img/me.png"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../frontend/img/me.png"
  content_type           = "image/png"
}
resource "azurerm_storage_blob" "jsmain" {
  name                   = "frontend/js/main.js"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../frontend/js/main.js"
  content_type           = "application/javascript"
}
resource "azurerm_storage_blob" "jsvisitorcount" {
  name                   = "frontend/js/visitorcount.js"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../frontend/js/visitorcount.js"
  content_type           = "application/javascript"
}
resource "azurerm_storage_blob" "resumepdf" {
  name                   = "resume/YongdingSunCloud.pdf"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../resume/YongdingSunCloud.pdf"
  content_type           = "application/pdf"
}

