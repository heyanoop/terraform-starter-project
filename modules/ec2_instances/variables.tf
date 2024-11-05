variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_security_group_ids" {
  type = list(string)
}
variable "bastion_security_group_ids" {
  type = list(string)
}

variable "pem_key_name" {
  type = string
}