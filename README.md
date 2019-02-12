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
Terraform plan
```
[root@plwawprovision custom_machine]# terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.vsphere_datacenter.dc: Refreshing state...
data.vsphere_compute_cluster.cluster: Refreshing state...
data.vsphere_datastore.datastore: Refreshing state...
```

```
[root@plwawprovision custom_machine]# terraform apply
data.vsphere_datacenter.dc: Refreshing state...
data.vsphere_network.network: Refreshing state...
data.vsphere_virtual_machine.template: Refreshing state...
data.vsphere_datastore.datastore: Refreshing state...
data.vsphere_compute_cluster.cluster: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + vsphere_virtual_machine.vm
      id:                                                   <computed>
      boot_retry_delay:                                     "10000"
      change_version:                                       <computed>
      clone.#:                                              "1"

[..]


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

vsphere_virtual_machine.vm: Creating...
  boot_retry_delay:                                     "" => "10000"
  change_version:                                       "" => "<computed>"
  clone.#:                                              "" => "1"
  clone.0.customize.#:                                  "" => "1"
  clone.0.customize.0.ipv4_gateway:                     "" => "10.0.0.1"
  clone.0.customize.0.linux_options.#:                  "" => "1"
  clone.0.customize.0.linux_options.0.domain:           "" => "localhost"
  clone.0.customize.0.linux_options.0.host_name:        "" => "terraform-test"
  clone.0.customize.0.linux_options.0.hw_clock_utc:     "" => "true"

[..]

  scsi_type:                                            "" => "pvscsi"
  shutdown_wait_timeout:                                "" => "3"
  swap_placement_policy:                                "" => "inherit"
  uuid:                                                 "" => "<computed>"
  vmware_tools_status:                                  "" => "<computed>"
  vmx_path:                                             "" => "<computed>"
  wait_for_guest_net_routable:                          "" => "true"
  wait_for_guest_net_timeout:                           "" => "0"
vsphere_virtual_machine.vm: Still creating... (10s elapsed)
vsphere_virtual_machine.vm: Still creating... (20s elapsed)
vsphere_virtual_machine.vm: Still creating... (30s elapsed)
vsphere_virtual_machine.vm: Creation complete after 39s (ID: 4215f5b5-fa55-5430-072f-108f1a7bed67)

```
