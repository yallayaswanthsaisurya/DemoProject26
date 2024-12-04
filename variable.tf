variable "resource_group" {
  default = "resource-rg1"
}
variable "location" {
  default = "east us"
}
variable "vnet_name" {
  default = "example-vnet"
}
variable "address_space" {
  default = ["10.0.0.0/16"]
}
variable "subnet_name" {
  default = "subnet2"
}
variable "subnet_prefix" {
  default = ["10.0.1.0/24"]
}

variable "nsg_name" {
  default = "myNSG"
}
