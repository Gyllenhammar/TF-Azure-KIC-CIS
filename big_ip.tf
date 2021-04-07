#
#Create N-nic bigip
#
module bigip {
  count   		            = var.bigip_count
  source                    = "github.com/f5devcentral/terraform-azure-bigip-module"
  prefix 		            = "${var.prefix}-1nic"
  resource_group_name       = azurerm_resource_group.main.name
  mgmt_subnet_ids           = [{ "subnet_id" = azurerm_subnet.subnet.id, "public_ip" = true, "private_ip_primary" =  "" }]
  mgmt_securitygroup_ids    = [azurerm_network_security_group.subnet.id]
  availabilityZones         = var.availabilityZones
  f5_instance_type          = "Standard_DS4_v2"
  f5_version                = "16.0.101000"

}

resource "null_resource" "clusterDO" {
  
  count = var.bigip_count
   
  provisioner "local-exec" {
    command = "cat > DO_1nic-instance${count.index}.json <<EOL\n ${module.bigip[count.index].onboard_do}\nEOL"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf DO_1nic-instance${count.index}.json"
  }
  depends_on = [ module.bigip.onboard_do]
}