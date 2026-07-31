provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "one" {
  count         = 2
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.micro"

  tags = {
    Name = "my-instance"
  }
}

#! /bin/bash
sudo -i
apt update
apt install apache2  git -y
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git
mv online-clone-amazon/* /var/www/html/

