output "bastion_sg_id" {
  value  = aws_security_group.bastion-sg.id
}

output "private_instance_sg_id" {
  value = aws_security_group.private-instance-sg.id
}