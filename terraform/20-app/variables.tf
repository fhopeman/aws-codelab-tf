variable "base_name" {
  type    = string
}

variable "my_ip_cidr" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
