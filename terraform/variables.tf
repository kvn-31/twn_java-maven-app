variable vpc_cidr_block {
  default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  default = "10.0.0.0/24"
}
variable avail_zone {
  default = "eu-central-1a"
}
variable env_prefix {
  default = "dev"
}
variable my_ip {
  default = "84.115.216.37/32"
}
variable jenkins_ip {
  default = "159.89.107.189/32"
}
variable instance_type {
  default = "t2.micro"
}
variable region {
  default = "eu-central-1"
}
