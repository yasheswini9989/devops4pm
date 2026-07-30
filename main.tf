provider "aws" {
}

resource "aws_instance" "one" {
count = var.instance_count
ami = "ami-028ba4d4ccb4b7b72"
instance_type = "t3.micro"
tags = {
Name = var.instance_name
}
}
