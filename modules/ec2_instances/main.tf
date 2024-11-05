resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name              = var.pem_key_name
  vpc_security_group_ids = var.bastion_security_group_ids

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "private-instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name              = var.pem_key_name
  vpc_security_group_ids = var.private_security_group_ids

  tags = {
    Name = "Private Instance"
  }
}
