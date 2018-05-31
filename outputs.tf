output "webapp-nsg" {
  value = "${azurerm_network_security_group.webapp.*.id}"
}

output "webapp-subnet" {
  value = "${azurerm_subnet.webapp.id}"
}
