variable "namespace" {
  description = "Unique project name resource naming"
  type  = string
}

variable "ssh_keypair" {
  description = "SSH Key pair to be used with EC2"
  default = null
}

variable "region" {
  description = "AWS region"
  default = "us-west-2"
  type = string
}
