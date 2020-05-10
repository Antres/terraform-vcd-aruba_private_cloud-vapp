terraform {
  required_version          = "> 0.12.0"
  experiments               = []
}

locals {
}

resource "vcd_vapp" "vapp" {
  
  org                       = var.region.vdc.org
  vdc                       = var.region.vdc.name
  
  name                      = var.name
}

resource "vcd_vapp_org_network" "network" {
  for_each                  = var.networks
  
  org                       = var.region.vdc.org
  vdc                       = var.region.vdc.name
  
  vapp_name                 = vcd_vapp.vapp.name
  org_network_name          = each.value
}

resource "vcd_vapp_vm" "vm" {
  
  org                       = var.region.vdc.org
  vdc                       = var.region.vdc.name
  vapp_name                 = vcd_vapp.vapp.name
  
  catalog_name              = var.template.catalog
  template_name             = var.template.name
  
  name                      = "pippo"
  
  cpus                      = 2
  memory                    = 1024
  
  dynamic "network" {
    for_each                   = [for network in vcd_vapp_org_network.network: network.org_network_name]
    
    content {
      type                  = "org"
      name                  = each.value
      ip_allocation_mode    = "NONE"
    }
  }
}
