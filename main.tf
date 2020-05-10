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
