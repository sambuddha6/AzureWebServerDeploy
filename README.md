# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
1. After the installations are done we need to make sure the terraform and packer exe files are in the same folder and update the system's global path to that path
2. Add the updated server.json, policy.json, main.tf and vars.tf in the same folder
3. Run 'az image list' to see if any vm images are existing 
4. Run 'packer build server.json' on the updated json file in the repo
5. After successful completion of the above command run 'az image list' again and this should show similar output as Output #1
6. Run 'az policy definition create --name TaggingPolicy --rules policy.json'
7. Output should be similar to Output #2
8. Run 'az policy assignment create --policy TaggingPolicy'
9. Run 'az policy assignment list' which looks like below
   ![Policy Assignment](./policy_assignment.JPG)  
10. Run 'terraform init' and it should give a success message as 'Terraform has been successfully initialized!'
11. Run 'terraform plan -out solution.plan' and it should give a message like Output #3
12. The above command should prompt for number of virtual machines like below
    var.vm_count
    The number of Virtual Machines

    Enter a value:
13. Generically to prompt user input for any variable defined in the vars.tf file, delete the default value, currently for vm_count variable the default value is removded
14. Once the terraform plan command is successful check if the file 'solution.plan is created 
15. Run 'terraform apply "solution.plan"' to create the resources - upon successful completion it should give the message 'Apply complete! Resources: 14 added, 0 changed, 0 destroyed.'
16. Run 'terraform show' to see the resources created and it should give a message like Output #4

### Output
1. [
  {
    "extendedLocation": null,
    "hyperVGeneration": "V1",
    "id": "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/CLOUD-SHELL-STORAGE-CENTRALINDIA/providers/Microsoft.Compute/images/myPackerImage",
    "location": "centralindia",
    "name": "myPackerImage",
    "provisioningState": "Succeeded",
    "resourceGroup": "CLOUD-SHELL-STORAGE-CENTRALINDIA",
    "sourceVirtualMachine": {
      "id": "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/pkr-Resource-Group-fxl1lsvl5x/providers/Microsoft.Compute/virtualMachines/pkrvmfxl1lsvl5x",
      "resourceGroup": "pkr-Resource-Group-fxl1lsvl5x"
    },
    "storageProfile": {
      "dataDisks": [],
      "osDisk": {
        "blobUri": null,
        "caching": "ReadWrite",
        "diskEncryptionSet": null,
        "diskSizeGb": 30,
        "managedDisk": {
          "id": "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/pkr-Resource-Group-fxl1lsvl5x/providers/Microsoft.Compute/disks/pkrosfxl1lsvl5x",
          "resourceGroup": "pkr-Resource-Group-fxl1lsvl5x"
        },
        "osState": "Generalized",
        "osType": "Linux",
        "snapshot": null,
        "storageAccountType": "Standard_LRS"
      },
      "zoneResilient": false
    },
    "tags": {},
    "type": "Microsoft.Compute/images"
  }
]

2. {
  "description": null,
  "displayName": null,
  "id": "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/providers/Microsoft.Authorization/policyDefinitions/TaggingPolicy",
  "metadata": {
    "createdBy": "1a877aaa-ed95-497d-a77c-a240cb9d4806",
    "createdOn": "2022-10-19T14:57:30.5247996Z",
    "updatedBy": null,
    "updatedOn": null
  },
  "mode": "Indexed",
  "name": "TaggingPolicy",
  "parameters": null,
  "policyRule": {
    "if": {
      "allof": [
        {
          "equals": "Microsoft.Resources/subscriptions/Resources",
          "field": "type"
        },
        {
          "exists": "false",
          "field": "tags"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  },
  "policyType": "Custom",
  "systemData": {
    "createdAt": "2022-10-19T14:57:30.471450+00:00",
    "createdBy": "sambuddha6@hotmail.com",
    "createdByType": "User",
    "lastModifiedAt": "2022-10-19T14:57:30.471450+00:00",
    "lastModifiedBy": "sambuddha6@hotmail.com",
    "lastModifiedByType": "User"
  },
  "type": "Microsoft.Authorization/policyDefinitions"
}

3. Terraform will perform the following actions:

  # azurerm_availability_set.example will be created
  + resource "azurerm_availability_set" "example" {
      + id                           = (known after apply)
      + location                     = "centralindia"
      + managed                      = true
      + name                         = "UdacityAzureInfra-availabilityset"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "UdacityAzureInfra-resources"
      + tags                         = {
          + "environment" = "testing"
        }
    }

  # azurerm_lb.example will be created
  + resource "azurerm_lb" "example" {
      + id                   = (known after apply)
      + location             = "centralindia"
      + name                 = "UdacityAzureInfra-lb"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "UdacityAzureInfra-resources"
      + sku                  = "Basic"
      + sku_tier             = "Regional"

      + frontend_ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + id                                                 = (known after apply)
          + inbound_nat_rules                                  = (known after apply)
          + load_balancer_rules                                = (known after apply)
          + name                                               = "UdacityAzureInfra-PublicIPAddress"
          + outbound_rules                                     = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = (known after apply)
          + private_ip_address_version                         = (known after apply)
          + public_ip_address_id                               = (known after apply)
          + public_ip_prefix_id                                = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_lb_backend_address_pool.example will be created
  + resource "azurerm_lb_backend_address_pool" "example" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + inbound_nat_rules         = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "BackEndAddressPool"
      + outbound_rules            = (known after apply)
    }

  # azurerm_linux_virtual_machine.example[0] will be created
  + resource "azurerm_linux_virtual_machine" "example" {
      + admin_password                  = (sensitive value)
      + admin_username                  = "azureuser"
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + disable_password_authentication = false
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "centralindia"
      + max_bid_price                   = -1
      + name                            = "One"
      + network_interface_ids           = (known after apply)
      + patch_assessment_mode           = "ImageDefault"
      + patch_mode                      = "ImageDefault"
      + platform_fault_domain           = -1
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "UdacityAzureInfra-resources"
      + size                            = "Standard_D2s_v3"
      + source_image_id                 = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/cloud-shell-storage-centralindia/providers/Microsoft.Compute/images/myPackerImage"
      + virtual_machine_id              = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + termination_notification {
          + enabled = (known after apply)
          + timeout = (known after apply)
        }
    }

  # azurerm_linux_virtual_machine.example[1] will be created
  + resource "azurerm_linux_virtual_machine" "example" {
      + admin_password                  = (sensitive value)
      + admin_username                  = "azureuser"
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + disable_password_authentication = false
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "centralindia"
      + max_bid_price                   = -1
      + name                            = "Two"
      + network_interface_ids           = (known after apply)
      + patch_assessment_mode           = "ImageDefault"
      + patch_mode                      = "ImageDefault"
      + platform_fault_domain           = -1
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "UdacityAzureInfra-resources"
      + size                            = "Standard_D2s_v3"
      + source_image_id                 = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/cloud-shell-storage-centralindia/providers/Microsoft.Compute/images/myPackerImage"
      + virtual_machine_id              = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + termination_notification {
          + enabled = (known after apply)
          + timeout = (known after apply)
        }
    }

  # azurerm_managed_disk.example will be created
  + resource "azurerm_managed_disk" "example" {
      + create_option                 = "Empty"
      + disk_iops_read_only           = (known after apply)
      + disk_iops_read_write          = (known after apply)
      + disk_mbps_read_only           = (known after apply)
      + disk_mbps_read_write          = (known after apply)
      + disk_size_gb                  = 1
      + id                            = (known after apply)
      + location                      = "centralindia"
      + logical_sector_size           = (known after apply)
      + max_shares                    = (known after apply)
      + name                          = "UdacityAzureInfra-manageddisk"
      + public_network_access_enabled = true
      + resource_group_name           = "UdacityAzureInfra-resources"
      + source_uri                    = (known after apply)
      + storage_account_type          = "Standard_LRS"
      + tags                          = {
          + "environment" = "testing"
        }
      + tier                          = (known after apply)
    }

  # azurerm_network_interface.example[0] will be created
  + resource "azurerm_network_interface" "example" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "One"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "UdacityAzureInfra-resources"
      + tags                          = {
          + "environment" = "testing"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "UdacityAzureInfra-ipconfig"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_interface.example[1] will be created
  + resource "azurerm_network_interface" "example" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "Two"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "UdacityAzureInfra-resources"
      + tags                          = {
          + "environment" = "testing"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "UdacityAzureInfra-ipconfig"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_security_group.example will be created
  + resource "azurerm_network_security_group" "example" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "UdacityAzureInfra-SecurityGroup"
      + resource_group_name = "UdacityAzureInfra-resources"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "UdacityAzureInfra-SecurityRule2"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "UdacityAzureInfra-SecurityRule1"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # azurerm_public_ip.example will be created
  + resource "azurerm_public_ip" "example" {
      + allocation_method       = "Static"
      + domain_name_label       = (known after apply)
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "centralindia"
      + name                    = "UdacityAzureInfra-public-ip"
      + resource_group_name     = "UdacityAzureInfra-resources"
      + sku                     = "Basic"
      + sku_tier                = "Regional"
    }

  # azurerm_resource_group.example will be created
  + resource "azurerm_resource_group" "example" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "UdacityAzureInfra-resources"
    }

  # azurerm_subnet.example will be created
  + resource "azurerm_subnet" "example" {
      + address_prefixes                               = [
          + "10.0.2.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "UdacityAzureInfra-subnet"
      + private_endpoint_network_policies_enabled      = (known after apply)
      + private_link_service_network_policies_enabled  = (known after apply)
      + resource_group_name                            = "UdacityAzureInfra-resources"
      + virtual_network_name                           = "UdacityAzureInfra-network"
    }

  # azurerm_virtual_network.example will be created
  + resource "azurerm_virtual_network" "example" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "UdacityAzureInfra-network"
      + resource_group_name = "UdacityAzureInfra-resources"
      + subnet              = (known after apply)
    }

  # random_string.fqdn will be created
  + resource "random_string" "fqdn" {
      + id          = (known after apply)
      + length      = 6
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = false
      + numeric     = false
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 14 to add, 0 to change, 0 to destroy.


4. # azurerm_availability_set.example:
resource "azurerm_availability_set" "example" {
    id                           = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Compute/availabilitySets/UdacityAzureInfra-availabilityset"
    location                     = "centralindia"
    managed                      = true
    name                         = "UdacityAzureInfra-availabilityset"
    platform_fault_domain_count  = 3
    platform_update_domain_count = 5
    resource_group_name          = "UdacityAzureInfra-resources"
    tags                         = {
        "environment" = "testing"
    }
}

# azurerm_lb.example:
resource "azurerm_lb" "example" {
    id                   = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/loadBalancers/UdacityAzureInfra-lb"
    location             = "centralindia"
    name                 = "UdacityAzureInfra-lb"
    private_ip_addresses = []
    resource_group_name  = "UdacityAzureInfra-resources"
    sku                  = "Basic"
    sku_tier             = "Regional"

    frontend_ip_configuration {
        id                            = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/loadBalancers/UdacityAzureInfra-lb/frontendIPConfigurations/UdacityAzureInfra-PublicIPAddress"
        inbound_nat_rules             = []
        load_balancer_rules           = []
        name                          = "UdacityAzureInfra-PublicIPAddress"
        outbound_rules                = []
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/publicIPAddresses/UdacityAzureInfra-public-ip"
    }
}

# azurerm_lb_backend_address_pool.example:
resource "azurerm_lb_backend_address_pool" "example" {
    backend_ip_configurations = []
    id                        = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/loadBalancers/UdacityAzureInfra-lb/backendAddressPools/BackEndAddressPool"
    inbound_nat_rules         = []
    load_balancing_rules      = []
    loadbalancer_id           = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/loadBalancers/UdacityAzureInfra-lb"
    name                      = "BackEndAddressPool"
    outbound_rules            = []
}

# azurerm_linux_virtual_machine.example[0]:
resource "azurerm_linux_virtual_machine" "example" {
    admin_password                  = (sensitive value)
    admin_username                  = "azureuser"
    allow_extension_operations      = true
    computer_name                   = "One"
    disable_password_authentication = false
    encryption_at_host_enabled      = false
    extensions_time_budget          = "PT1H30M"
    id                              = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Compute/virtualMachines/One"
    location                        = "centralindia"
    max_bid_price                   = -1
    name                            = "One"
    network_interface_ids           = [
        "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/networkInterfaces/One",
    ]
    patch_assessment_mode           = "ImageDefault"
    patch_mode                      = "ImageDefault"
    platform_fault_domain           = -1
    priority                        = "Regular"
    private_ip_address              = "10.0.2.5"
    private_ip_addresses            = [
        "10.0.2.5",
    ]
    provision_vm_agent              = true
    public_ip_addresses             = []
    resource_group_name             = "UdacityAzureInfra-resources"
    secure_boot_enabled             = false
    size                            = "Standard_D2s_v3"
    source_image_id                 = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/cloud-shell-storage-centralindia/providers/Microsoft.Compute/images/myPackerImage"
    virtual_machine_id              = "9ffa1b57-3dda-4e11-8340-35f4d1edd4db"
    vtpm_enabled                    = false

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 30
        name                      = "One_disk1_c3c42ee7d90a4c48bf9bed8c98a0ef73"
        storage_account_type      = "Standard_LRS"
        write_accelerator_enabled = false
    }
}

# azurerm_linux_virtual_machine.example[1]:
resource "azurerm_linux_virtual_machine" "example" {
    admin_password                  = (sensitive value)
    admin_username                  = "azureuser"
    allow_extension_operations      = true
    computer_name                   = "Two"
    disable_password_authentication = false
    encryption_at_host_enabled      = false
    extensions_time_budget          = "PT1H30M"
    id                              = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Compute/virtualMachines/Two"
    location                        = "centralindia"
    max_bid_price                   = -1
    name                            = "Two"
    network_interface_ids           = [
        "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/networkInterfaces/Two",
    ]
    patch_assessment_mode           = "ImageDefault"
    patch_mode                      = "ImageDefault"
    platform_fault_domain           = -1
    priority                        = "Regular"
    private_ip_address              = "10.0.2.4"
    private_ip_addresses            = [
        "10.0.2.4",
    ]
    provision_vm_agent              = true
    public_ip_addresses             = []
    resource_group_name             = "UdacityAzureInfra-resources"
    secure_boot_enabled             = false
    size                            = "Standard_D2s_v3"
    source_image_id                 = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/cloud-shell-storage-centralindia/providers/Microsoft.Compute/images/myPackerImage"
    virtual_machine_id              = "b6a4c89f-58b3-42f3-9b51-54303ec390b8"
    vtpm_enabled                    = false

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 30
        name                      = "Two_disk1_2a4a4c683d9a439d86e3630d5289d0ae"
        storage_account_type      = "Standard_LRS"
        write_accelerator_enabled = false
    }
}

# azurerm_managed_disk.example:
resource "azurerm_managed_disk" "example" {
    create_option                 = "Empty"
    disk_iops_read_only           = 0
    disk_iops_read_write          = 500
    disk_mbps_read_only           = 0
    disk_mbps_read_write          = 60
    disk_size_gb                  = 1
    id                            = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Compute/disks/UdacityAzureInfra-manageddisk"
    location                      = "centralindia"
    max_shares                    = 0
    name                          = "UdacityAzureInfra-manageddisk"
    on_demand_bursting_enabled    = false
    public_network_access_enabled = true
    resource_group_name           = "UdacityAzureInfra-resources"
    storage_account_type          = "Standard_LRS"
    tags                          = {
        "environment" = "testing"
    }
    trusted_launch_enabled        = false
}

# azurerm_network_interface.example[0]:
resource "azurerm_network_interface" "example" {
    applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    id                            = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/networkInterfaces/One"
    internal_domain_name_suffix   = "vkdzcr3kdhgezngergsncred3h.rx.internal.cloudapp.net"
    location                      = "centralindia"
    name                          = "One"
    private_ip_address            = "10.0.2.5"
    private_ip_addresses          = [
        "10.0.2.5",
    ]
    resource_group_name           = "UdacityAzureInfra-resources"
    tags                          = {
        "environment" = "testing"
    }

    ip_configuration {
        name                          = "UdacityAzureInfra-ipconfig"
        primary                       = true
        private_ip_address            = "10.0.2.5"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/virtualNetworks/UdacityAzureInfra-network/subnets/UdacityAzureInfra-subnet"
    }
}

# azurerm_network_interface.example[1]:
resource "azurerm_network_interface" "example" {
    applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    id                            = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/networkInterfaces/Two"
    internal_domain_name_suffix   = "vkdzcr3kdhgezngergsncred3h.rx.internal.cloudapp.net"
    location                      = "centralindia"
    name                          = "Two"
    private_ip_address            = "10.0.2.4"
    private_ip_addresses          = [
        "10.0.2.4",
    ]
    resource_group_name           = "UdacityAzureInfra-resources"
    tags                          = {
        "environment" = "testing"
    }

    ip_configuration {
        name                          = "UdacityAzureInfra-ipconfig"
        primary                       = true
        private_ip_address            = "10.0.2.4"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/virtualNetworks/UdacityAzureInfra-network/subnets/UdacityAzureInfra-subnet"
    }
}

# azurerm_network_security_group.example:
resource "azurerm_network_security_group" "example" {
    id                  = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/networkSecurityGroups/UdacityAzureInfra-SecurityGroup"
    location            = "centralindia"
    name                = "UdacityAzureInfra-SecurityGroup"
    resource_group_name = "UdacityAzureInfra-resources"
    security_rule       = [
        {
            access                                     = "Allow"
            description                                = ""
            destination_address_prefix                 = "*"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "*"
            destination_port_ranges                    = []
            direction                                  = "Outbound"
            name                                       = "UdacityAzureInfra-SecurityRule2"
            priority                                   = 100
            protocol                                   = "Tcp"
            source_address_prefix                      = "*"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
        },
        {
            access                                     = "Deny"
            description                                = ""
            destination_address_prefix                 = "*"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "*"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "UdacityAzureInfra-SecurityRule1"
            priority                                   = 100
            protocol                                   = "Tcp"
            source_address_prefix                      = "*"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
        },
    ]
}

# azurerm_public_ip.example:
resource "azurerm_public_ip" "example" {
    allocation_method       = "Static"
    domain_name_label       = "anlppl"
    fqdn                    = "anlppl.centralindia.cloudapp.azure.com"
    id                      = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/publicIPAddresses/UdacityAzureInfra-public-ip"
    idle_timeout_in_minutes = 4
    ip_address              = "4.224.243.55"
    ip_version              = "IPv4"
    location                = "centralindia"
    name                    = "UdacityAzureInfra-public-ip"
    resource_group_name     = "UdacityAzureInfra-resources"
    sku                     = "Basic"
    sku_tier                = "Regional"
}

# azurerm_resource_group.example:
resource "azurerm_resource_group" "example" {
    id       = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources"
    location = "centralindia"
    name     = "UdacityAzureInfra-resources"
}

# azurerm_subnet.example:
resource "azurerm_subnet" "example" {
    address_prefixes                               = [
        "10.0.2.0/24",
    ]
    enforce_private_link_endpoint_network_policies = false
    enforce_private_link_service_network_policies  = false
    id                                             = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/virtualNetworks/UdacityAzureInfra-network/subnets/UdacityAzureInfra-subnet"
    name                                           = "UdacityAzureInfra-subnet"
    private_endpoint_network_policies_enabled      = true
    private_link_service_network_policies_enabled  = true
    resource_group_name                            = "UdacityAzureInfra-resources"
    virtual_network_name                           = "UdacityAzureInfra-network"
}

# azurerm_virtual_network.example:
resource "azurerm_virtual_network" "example" {
    address_space           = [
        "10.0.0.0/16",
    ]
    dns_servers             = []
    flow_timeout_in_minutes = 0
    guid                    = "479187aa-19aa-4ccc-b4c4-89a4d14483ef"
    id                      = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/UdacityAzureInfra-resources/providers/Microsoft.Network/virtualNetworks/UdacityAzureInfra-network"
    location                = "centralindia"
    name                    = "UdacityAzureInfra-network"
    resource_group_name     = "UdacityAzureInfra-resources"
    subnet                  = []
}

# data.azurerm_image.image:
data "azurerm_image" "image" {
    data_disk           = []
    id                  = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/cloud-shell-storage-centralindia/providers/Microsoft.Compute/images/myPackerImage"
    location            = "centralindia"
    name                = "myPackerImage"
    os_disk             = [
        {
            blob_uri        = ""
            caching         = "ReadWrite"
            managed_disk_id = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/pkr-Resource-Group-fxl1lsvl5x/providers/Microsoft.Compute/disks/pkrosfxl1lsvl5x"
            os_state        = "Generalized"
            os_type         = "Linux"
            size_gb         = 30
        },
    ]
    resource_group_name = "cloud-shell-storage-centralindia"
    sort_descending     = false
    tags                = {}
    zone_resilient      = false
}

# data.azurerm_resource_group.image:
data "azurerm_resource_group" "image" {
    id       = "/subscriptions/80d3ddff-8440-41d1-bfb3-5ad77c579184/resourceGroups/cloud-shell-storage-centralindia"
    location = "centralindia"
    name     = "cloud-shell-storage-centralindia"
    tags     = {}
}

# random_string.fqdn:
resource "random_string" "fqdn" {
    id          = "anlppl"
    length      = 6
    lower       = true
    min_lower   = 0
    min_numeric = 0
    min_special = 0
    min_upper   = 0
    number      = false
    numeric     = false
    result      = "anlppl"
    special     = false
    upper       = false
}
