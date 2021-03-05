terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">=3.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-0915bcb5fa77e4892"
  instance_type = "t2.micro"

  tags = {
    "Name" = "terraform-example"
  }
}
