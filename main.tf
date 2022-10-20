provider "azurerm" {
	features {}
}

locals {
	server_names = ["One", "Two", "Three", "Four", "Five"]
	nic_names = ["One", "Two", "Three", "Four", "Five"]
}

resource "azurerm_resource_group" "example"{
	name = "${var.prefix}-resources"
	location = var.location
	
	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "azurerm_virtual_network" "example"{
	name 				= "${var.prefix}-network"
	address_space 		= ["10.0.0.0/16"]
	location 			= azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	
	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "azurerm_subnet" "example"{
	name 				= "${var.prefix}-subnet"
	resource_group_name = azurerm_resource_group.example.name
	virtual_network_name= azurerm_virtual_network.example.name
	address_prefixes 	= ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "example" {
	name                = "${var.prefix}-SecurityGroup"
	location            = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name

	security_rule {
	name                       = "${var.prefix}-SecurityRule1"
	priority                   = 100
	direction                  = "Inbound"
	access                     = "Deny"
	protocol                   = "Tcp"
	source_port_range          = "*"
	destination_port_range     = "*"
	source_address_prefix      = "*"
	destination_address_prefix = "*"
	}

	security_rule {
	name                       = "${var.prefix}-SecurityRule2"
	priority                   = 100
	direction                  = "Outbound"
	access                     = "Allow"
	protocol                   = "Tcp"
	source_port_range          = "*"
	destination_port_range     = "*"
	source_address_prefix      = "*"
	destination_address_prefix = "*"
	}
  
  	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "azurerm_network_interface" "example"{
	count					= "${var.vm_count}"
	name 					= local.nic_names[count.index]
	resource_group_name 	= azurerm_resource_group.example.name
	location 				= azurerm_resource_group.example.location
	
	ip_configuration {
		name							= "${var.prefix}-ipconfig"
		subnet_id						= azurerm_subnet.example.id
		private_ip_address_allocation	= "Dynamic"
	}
		
	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "random_string" "fqdn" {
	length  = 6
	special = false
	upper   = false
	numeric  = false
}

resource "azurerm_public_ip" "example" {
	name                         = "${var.prefix}-public-ip"
	location                     = var.location
	resource_group_name          = azurerm_resource_group.example.name
	allocation_method            = "Static"
	domain_name_label            = random_string.fqdn.result
	
	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "azurerm_lb" "example" {
	name                = "${var.prefix}-lb"
	location            = var.location
	resource_group_name = azurerm_resource_group.example.name

	frontend_ip_configuration {
		name                 = "${var.prefix}-PublicIPAddress"
		public_ip_address_id = azurerm_public_ip.example.id
	}
	
	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "azurerm_lb_backend_address_pool" "example" {
	loadbalancer_id = azurerm_lb.example.id
	name            = "BackEndAddressPool"
}

resource "azurerm_availability_set" "example" {
	name                = "${var.prefix}-availabilityset"
	location            = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	
	tags = {
		name = "UdacityAzureInfra"
	}
}

resource "azurerm_managed_disk" "example" {
	name                 = "${var.prefix}-manageddisk"
	location             = azurerm_resource_group.example.location
	resource_group_name  = azurerm_resource_group.example.name
	storage_account_type = "Standard_LRS"
	create_option        = "Empty"
	disk_size_gb         = "1"

	tags = {
		name = "UdacityAzureInfra"
	}
}

data "azurerm_resource_group" "image" {
	name                = var.packer_resource_group_name
}

data "azurerm_image" "image" {
	name                	= var.packer_image_name
	resource_group_name 	= data.azurerm_resource_group.image.name
}

resource "azurerm_linux_virtual_machine" "example" {
	count					= "${var.vm_count}"
	name 					= local.server_names[count.index]
	resource_group_name 	= azurerm_resource_group.example.name
	location 				= azurerm_resource_group.example.location
	size					= "Standard_D2s_v3"
	admin_username 			= var.admin_user
	admin_password          = var.admin_password
	disable_password_authentication = false
	
	network_interface_ids	= [
		azurerm_network_interface.example[count.index].id,
	]
	
	source_image_id = data.azurerm_image.image.id
	
	os_disk {
	storage_account_type = "Standard_LRS"
	caching = "ReadWrite"
	}
	
	tags = {
		name = "UdacityAzureInfra"
	}
}
