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
  for_each                  = {for network in var.networks :  network.name => network}
  
  org                       = each.value.org
  vdc                       = each.value.vdc
  
  vapp_name                 = vapp.name
  org_network_name          = each.value.name
}
