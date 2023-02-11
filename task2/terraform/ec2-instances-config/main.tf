data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}


resource "aws_security_group" "open-port-22-8000" {
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description      = "SSH from Anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.allow_all_ipv4_cidr_blocks]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_blocks]
  }
 
  ingress {
    description      = "HTTP from Anywhere"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = [var.allow_all_ipv4_cidr_blocks]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_blocks]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.allow_all_ipv4_cidr_blocks]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_blocks]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_instance" "nasr-ec2" {
  ami = coalesce(var.ec2-ami, data.aws_ami.ubuntu.id)
  instance_type = var.instance_type
  associate_public_ip_address = var.is_public
  vpc_security_group_ids = [aws_security_group.open-port-22-8000.id]
  key_name = var.key-name

  provisioner "local-exec" {
    command = var.item-count == 1 ? "echo [web-django] > ../ansible/inventory.txt && echo web-machine-${var.item-count} ansible_host=${self.public_ip} ansible_user=ubuntu >> ../ansible/inventory.txt" : "echo web-machine-${var.item-count} ansible_host=${self.public_ip} ansible_user=ubuntu >> ../ansible/inventory.txt"
  }
}
