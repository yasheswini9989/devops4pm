provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "one" {
  count         = 1
  ami           = "ami-028ba4d4ccb4b7b72"
  instance_type = "t3.micro"

  tags = {
    Name = "my-instance"
  }
}
