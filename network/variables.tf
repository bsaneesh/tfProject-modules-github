variable "resourcegroup_name" {
    type = string
    description = "Resource group name" 
}

variable "location" {
    type = string
    description = "location of resources" 
}

variable "vnetname" {
    type = string
    description = "vnet name" 
}

variable "vnetaddress" {
   type = string
   description = "vnet address space"
    
}

variable "subnetnames" {
    type = set(string)
    description = "subnet names"
}