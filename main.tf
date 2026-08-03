provider "aws" {
  region = "us-east-2"
}

locals {
  ingress_rules = [{ port = 443 }, { port = 80 }, { port = 22 }]
}


resource "aws_security_group" "allow_tls" {
  name        = "terra sg"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = "*"
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "terra sg"
  }
}
