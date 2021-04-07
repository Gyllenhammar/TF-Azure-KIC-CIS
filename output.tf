# data "azurerm_public_ip" "public_ip" {
#   count = var.vm_count
#   name = azurerm_public_ip.node_public_ip[count.index].name
#   resource_group_name = azurerm_resource_group.main.name
#   depends_on = [ azurerm_public_ip.node_public_ip, azurerm_linux_virtual_machine.node ]
# }

# output "node_public_ips" {
#     value = formatlist("%s: %s", azurerm_linux_virtual_machine.node.*.name, data.azurerm_public_ip.public_ip.*.ip_address) 
# }

# output "node_ssh_connect" {
#     value = formatlist("%s: ssh %s@%s", azurerm_linux_virtual_machine.node.*.tags.name, var.vm_admin, data.azurerm_public_ip.public_ip.*.ip_address) 
# }

#output "cloudinit_config_file" {
#    value = data.template_file.cloudconfig.rendered
#}

# output "Container_Registry" {
#     value = "${azurerm_container_registry.acr.name}.azurecr.io"
# }

# data "azurerm_container_registry" "acr" {
#     name = azurerm_container_registry.acr.name
#     resource_group_name = azurerm_resource_group.main.name
#     depends_on = [ azurerm_container_registry.acr ]
# }

# output "Container_admin" {
#     value = formatlist("Username: %s | Password: %s", data.azurerm_container_registry.acr.admin_username, data.azurerm_container_registry.acr.admin_password)
  
# }

output mgmtPublicIP {
  value = module.bigip.*.mgmtPublicIP
}

output mgmtPublicDNS {
  value = module.bigip.*.mgmtPublicDNS
}
output bigip_username {
  value = module.bigip.*.f5_username
}

output bigip_password {
  value = module.bigip.*.bigip_password
}

output mgmtPort {
  value = module.bigip.*.mgmtPort
}

output mgmtPublicURL {
  description = "mgmtPublicURL"
  value       = [for i in range(var.bigip_count) : format("https://%s:%s", module.bigip[i].mgmtPublicDNS, module.bigip[i].mgmtPort)]
}