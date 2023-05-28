provider "aws" {
  region = "ap-south-1"
}

# Create a security group in the default VPC
resource "aws_security_group" "ubuntu_sg" {
  name_prefix = "ubuntu-sg"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an instance in the default subnet using the security group
resource "aws_instance" "ubuntu" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ubuntu.id
  key_name      = "devops-2-mumbai"
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]
  tags = {
    Name = "ubuntu-server"
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "public_dns" {
  value = aws_instance.ubuntu.public_dns
}

