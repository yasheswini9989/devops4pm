provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "one" {
  count         = 2
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.micro"

  user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install apache2 git -y
sudo systemctl enable apache2
sudo systemctl start apache2

cd /tmp
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git
sudo cp -r online-clone-amazon/* /var/www/html/
EOF

  tags = {
    Name = "my-instance"
  }
}
