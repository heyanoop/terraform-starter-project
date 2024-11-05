resource "aws_security_group" "bastion-sg" {
  name        = "bastion-security-group"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Bastion Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = aws_security_group.bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "bastion_all_traffic" {
  security_group_id = aws_security_group.bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "private-instance-sg" {
  name        = "private-instance-security-group"
  description = "Security group for private instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Private Instance Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_ssh_from_bastion" {
  security_group_id = aws_security_group.private-instance-sg.id
  referenced_security_group_id = aws_security_group.bastion-sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "private_all_traffic" {
  security_group_id = aws_security_group.private-instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


