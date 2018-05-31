variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

module "network" {
  source              = "../../../"
  resource-group-name = "demo-lbg"
}

output "webapp-nsg" {
  value = "${module.network.webapp-nsg}"
}

output "webapp-subnet" {
  value = "${module.network.webapp-subnet}"
}
