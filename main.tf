provider "aws" {
  region = "us-east-2"
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

locals {
  ingress_rules = [
    { port = 443 },
    { port = 80 },
    { port = 22 }
  ]
}

resource "aws_security_group" "allow_tls" {
  name        = "terra-sg"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = "Allow TCP Port ${ingress.value.port}"
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terra-sg"
  }
}
