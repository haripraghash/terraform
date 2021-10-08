provider "aws" {
   region = "us-west-2"
}

data "aws_ami" "ami_name" {
  most_recent = true

  filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "helloworld" {
    ami = data.aws_ami.ami_name.id
    instance_type = "t2.micro"
    tags = {
        Name = "HelloWorld"
    }
}