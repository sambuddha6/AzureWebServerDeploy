variable "prefix" {
	description = "The prefix which should be used for all resources in this example"
	default = "UdacityAzureInfra"
}
	
variable "location"	{
	description = "The Azure Region in which all resources in this example should be created"
	default = "centralindia"
}

variable "packer_resource_group_name" {
   description = "Name of the resource group in which the Packer image will be created"
   default     = "cloud-shell-storage-centralindia"
}

variable "packer_image_name" {
   description = "Name of the Packer image"
   default     = "myPackerImage"
}

variable "tags" {
	description = "Name of the tag"
	default = "Udacity"
}

variable "admin_user" {
   description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
   default     = "azureuser"
}

variable "admin_password" {
   description = "Default password for admin account"
   default = "Udacity@123"
}

variable "vm_count" {
   description = "The number of Virtual Machines"
   default     = 2
}
