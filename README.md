# Stage1: Terraform-vmware
Automatic Deploy Virtual Machines on VMware DataCenter using Terraform

***

**This is an example of deploying one Centos7 virtual machine on existing VMware infrastructure.**

Terraform is an automation tool created by HashiCorp. It focuses on deploying cloud infrastructure in an automatic fashion. It supports a lot of cloud providers like AWS, DigitalOcean, Google Cloud Platform, OpenStack, VMware vSphere, and more. Terraform is developed in GoLang, which makes the installation really easy to perform, and allows for a lot of operating systems to be supported.

![Alt](images/logo.png)

**Preriquisites**

For this lab we will see how to deploy a VMware vSphere virtual machine with Terraform, therefore we obviously need a working VMware vSphere environment (vCenter and ESXi). We will use a Linux client machine (Ubuntu 16.04), but the installation of Terraform on another platform should be straightforward.

**Installation of terraform**

``sudo yum install wget unzip``

Download terraform package
I will strongly suggest to always download and use latest package. Visit to terraform website to download terraform latest package.

``wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.11_linux_amd64.zip``

``unzip terraform_0.11.8_linux_amd64.zip``

``sudo cp terraform /usr/bin``

``sudo chmod +x /usr/bin/terraform``


```[root@plwawprovision custom_machine]# terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "vsphere" (1.9.1)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.vsphere: version = "~> 1.9"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[root@plwawprovision custom_machine]# 
```

```
[root@plwawprovision custom_machine]# terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.vsphere_datacenter.dc: Refreshing state...
data.vsphere_compute_cluster.cluster: Refreshing state...
data.vsphere_datastore.datastore: Refreshing state...
data.vsphere_virtual_machine.template: Refreshing state...
data.vsphere_network.network: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + vsphere_virtual_machine.vm
      id:                                                   <computed>
      boot_retry_delay:                                     "10000"
      change_version:                                       <computed>
      clone.#:                                              "1"
      clone.0.customize.#:                                  "1"
      clone.0.customize.0.ipv4_gateway:                     "10.0.0.1"
      clone.0.customize.0.linux_options.#:                  "1"
      clone.0.customize.0.linux_options.0.domain:           "localhost"
      clone.0.customize.0.linux_options.0.host_name:        "terraform-test"
      clone.0.customize.0.linux_options.0.hw_clock_utc:     "true"
      clone.0.customize.0.network_interface.#:              "1"
      clone.0.customize.0.network_interface.0.ipv4_address: "10.0.2.44"
      clone.0.customize.0.network_interface.0.ipv4_netmask: "24"
      clone.0.customize.0.timeout:                          "10"
      clone.0.template_uuid:                                "421520ab-e512-8f15-3275-cd788ea4cea9"
      clone.0.timeout:                                      "30"
      cpu_limit:                                            "-1"
      cpu_share_count:                                      <computed>
      cpu_share_level:                                      "normal"
      datastore_id:                                         "datastore-10620"
      default_ip_address:                                   <computed>
      disk.#:                                               "1"
      disk.0.attach:                                        "false"
      disk.0.datastore_id:                                  "<computed>"
      disk.0.device_address:                                <computed>
      disk.0.disk_mode:                                     "persistent"
      disk.0.disk_sharing:                                  "sharingNone"
      disk.0.eagerly_scrub:                                 "false"
      disk.0.io_limit:                                      "-1"
      disk.0.io_reservation:                                "0"
      disk.0.io_share_count:                                "0"
      disk.0.io_share_level:                                "normal"
      disk.0.keep_on_remove:                                "false"
      disk.0.key:                                           "0"
      disk.0.label:                                         "disk0"
      disk.0.path:                                          <computed>
      disk.0.size:                                          "20"
      disk.0.thin_provisioned:                              "true"
      disk.0.unit_number:                                   "0"
      disk.0.uuid:                                          <computed>
      disk.0.write_through:                                 "false"
      ept_rvi_mode:                                         "automatic"
      firmware:                                             "bios"
      folder:                                               "management"
      force_power_off:                                      "true"
      guest_id:                                             "rhel7_64Guest"
      guest_ip_addresses.#:                                 <computed>
      host_system_id:                                       <computed>
      hv_mode:                                              "hvAuto"
      imported:                                             <computed>
      latency_sensitivity:                                  "normal"
      memory:                                               "1024"
      memory_limit:                                         "-1"
      memory_share_count:                                   <computed>
      memory_share_level:                                   "normal"
      migrate_wait_timeout:                                 "30"
      moid:                                                 <computed>
      name:                                                 "plwawterra_t"
      network_interface.#:                                  "1"
      network_interface.0.adapter_type:                     "vmxnet3"
      network_interface.0.bandwidth_limit:                  "-1"
      network_interface.0.bandwidth_reservation:            "0"
      network_interface.0.bandwidth_share_count:            <computed>
      network_interface.0.bandwidth_share_level:            "normal"
      network_interface.0.device_address:                   <computed>
      network_interface.0.key:                              <computed>
      network_interface.0.mac_address:                      <computed>
      network_interface.0.network_id:                       "network-9190"
      num_cores_per_socket:                                 "1"
      num_cpus:                                             "1"
      reboot_required:                                      <computed>
      resource_pool_id:                                     "resgroup-8042"
      run_tools_scripts_after_power_on:                     "true"
      run_tools_scripts_after_resume:                       "true"
      run_tools_scripts_before_guest_shutdown:              "true"
      run_tools_scripts_before_guest_standby:               "true"
      scsi_bus_sharing:                                     "noSharing"
      scsi_controller_count:                                "1"
      scsi_type:                                            "pvscsi"
      shutdown_wait_timeout:                                "3"
      swap_placement_policy:                                "inherit"
      uuid:                                                 <computed>
      vmware_tools_status:                                  <computed>
      vmx_path:                                             <computed>
      wait_for_guest_net_routable:                          "true"
      wait_for_guest_net_timeout:                           "0"


Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```
