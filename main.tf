# A simple "Hello world" example for terraform in IONOS clould. No variables or
# anything fancy is used, just the bare minimum to get one VM up and running in
# a virtual data center. After applying this file, you can ssh directly into
# the newly created VM

# Documentation is at:
# https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs

# Use the IONOS cloud provider. Be sure to use the latest version!
# You can find the releases here: 
# https://github.com/ionos-cloud/terraform-provider-ionoscloud/releases
terraform {
  required_providers {
    ionoscloud = {
      source = "ionos-cloud/ionoscloud"
      version = "= 6.4.9" 
    }
  }
}

# This will create an empty VDC (Virtual Data Center)
resource "ionoscloud_datacenter" "myvdc" {
  name                = "Terraform VDC Example"
  location            = "de/fra"
  description         = "My Virtual Datacenter created with Terraform"
}


# Create the public LAN. Needed to get our VM below to get internet access
resource "ionoscloud_lan" "publan" {
    datacenter_id         = ionoscloud_datacenter.myvdc.id
    public                = true
    name                  = "Public LAN"
}

# definition for one VM in the virtual data center defined above. It is
# connected to the network defined above You will need to replace "mnylund"
# below with your username!! There are better ways to get the home directory
# but for the sake of "hello world", lets keep it simple

# NOTE: one would normally not write any secrets (superpswd123 below) into a
# *.tf file like this, but for the purpose of having a simple "hello world" we
# will allow it here
resource "ionoscloud_server" "myserver" {
    name                  = "My Server"
    datacenter_id         = ionoscloud_datacenter.myvdc.id
    cores                 = 1
    ram                   = 1024
    image_name            = "ubuntu:latest"
    image_password        = "superpswd123"
    type                  = "ENTERPRISE"
    ssh_keys              = ["/home/mnylund/.ssh/id_rsa.pub"]
    volume {
        name              = "OS"
        size              = 50
        disk_type         = "SSD Standard"
    }
    nic {
        lan               = ionoscloud_lan.publan.id
        dhcp              = true
    }
}

# This is just an optional directive to output the above VMs public IP address
# so that you can use it with ssh to connect to the server
output "myserver_ip_address" {
  value = ionoscloud_server.myserver.primary_ip
}


