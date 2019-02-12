# Stage1: Terraform-vmware
Automatic Deploy Virtual Machines on VMware DataCenter using Terraform.
Infrastructure as Code
Infrastructure is described using a high-level configuration syntax. This allows a blueprint of your datacenter to be versioned and treated as you would any other code. Additionally, infrastructure can be shared and re-used.

»

***

**This is an example how to  deploy  Centos7 virtual machine on existing VMware infrastructure.**

Terraform is an automation tool created by HashiCorp. It focuses on deploying cloud infrastructure in an automatic fashion. It supports a lot of cloud providers like AWS, DigitalOcean, Google Cloud Platform, OpenStack, VMware vSphere, and more. Terraform is developed in GoLang, which makes the installation really easy to perform, and allows for a lot of operating systems to be supported.

![Alt](images/logo.png)

**Preriquisites**

For this lab we will see how to deploy a VMware vSphere virtual machine with Terraform, therefore we obviously need a working VMware vSphere environment (vCenter and ESXi). We will use a Linux client machine (Ubuntu 16.04), but the installation of Terraform on another platform should be straightforward.

**Installation of terraform**

To install Terraform, find the appropriate package for your system and download it. Terraform is packaged as a zip archive.

``sudo yum install wget unzip``

Download terraform package
I will strongly suggest to always download and use latest package. Visit to terraform website to download terraform latest package.

``wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.11_linux_amd64.zip``

``unzip terraform_0.11.8_linux_amd64.zip``

``sudo cp terraform /usr/bin``

``sudo chmod +x /usr/bin/terraform``

**Creating terraform space for our vm:** 
Creating directory for env and files:

```mkdir -p /terraform/custom-machine ; cd /terraform/custom-machine ```


**Configuration**

Configuration
The set of files used to describe infrastructure in Terraform is simply known as a Terraform configuration. I'm going to write our first configuration now to launch a single WMware instance.

Configuration files should be JSON

The entire configuration is in two files:


**varaibles.tf**
```
cat variables.tf 
variable "vsphere_server" {
  description = "VSphere Server for PROD/DEV environment - Company"
  default = "vcenter01.doamin.pl"
}

variable "vsphere_user" {
  description = "VSphere Server user for PROD/DEV environment - Company"
  default = "username@doamin.pl"
}

variable "vsphere_password" {
  description = "VSphere Server password for PROD/DEV environment - Company"
  default = "Password"
}
```



**terraform init**

The terraform init command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.

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
**Terraform plan**

The terraform plan command is used to create an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.
```
[root@plwawprovision custom_machine]# terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.vsphere_datacenter.dc: Refreshing state...
data.vsphere_compute_cluster.cluster: Refreshing state...
data.vsphere_datastore.datastore: Refreshing state...
[..]

```
**Terraform apply**

By default, apply scans the current directory for the configuration and applies the changes appropriately.



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
