/**
* # Terraform
*
* <Short TF module description>
*
*
* ## Usage
*
* ### Quick Example
*
* ```hcl
* module "dns_" {
*   source = ""
*   input1 = <>
*   input2 = <>
* } 
* ```
*
*/
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM RUNTIME REQUIREMENTS
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.13.5"
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = ">= 3.2.0"
    }
  }
}

provider "dns" {
  update {
    server = "${var.dns_server}"
  }  
}

# ------------------------------------------
# Write your local resources here
# ------------------------------------------

locals {
  json_files = fileset("./examples/exercise/input-json", "*.json")   
  json_data  = [ for f in local.json_files : jsondecode(file("${path.module}/examples/exercise/input-json/${f}")) ]  
}

# ------------------------------------------
# Write your Terraform resources here
# ------------------------------------------

output "files" {
  value = "${local.json_files}"
}

output "data" {
  value = "${local.json_data}"
}

#resource "dns_a_record_set" "template" {
#    for_each  = { for f in local.json_files : }
#    name      = each.key
#    zone      = "example.com."
#    addresses = each.value.addresses
#    ttl       = each.value.ttl
#}

#resource "dns_a_record_set" "www" {
#  zone = "example.com."
#  name = "www"
#  addresses = [
#    "192.168.0.1",
#    "192.168.0.2",
#    "192.168.0.3",
#  ]
#  ttl = 300
#}
