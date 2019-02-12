provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" dc {
  name = "DataCenter1"
}

data "vsphere_compute_cluster" cluster {
  name          = "01-Cluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" datastore {
  name          = "DS_iscsi_ds01"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" network {
  name          = "PROD-network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
    name = "centos_gold_image"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

### Resources ###

resource "vsphere_virtual_machine" "vm" {
    name = "plwawterra_t"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
    folder = "management"

    num_cpus = "1"
    memory = "1024"
    guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

    network_interface {
    network_id = "${data.vsphere_network.network.id}"
    }

    disk {
      label = "disk0"
      size  = 20
      #thin_provisioned = "false"
    }

    clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "terraform-test"
        domain    = "localhost"
      }

      network_interface {
        ipv4_address = "10.0.2.44"
        ipv4_netmask = 24
      }
      ipv4_gateway = "10.0.0.1"
    }
  }
wait_for_guest_net_timeout = 0
}
