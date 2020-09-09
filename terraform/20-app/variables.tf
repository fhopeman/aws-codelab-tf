variable "base_name" {
  type    = string
  default = "fabian"
}

variable "my_ip_cidr" {
  type    = string
  default = "1.2.3.4/32"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
