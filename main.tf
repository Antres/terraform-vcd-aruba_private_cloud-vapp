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

