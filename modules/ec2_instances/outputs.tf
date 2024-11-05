output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP of the bastion host"
}

output "private_instance_private_ip" {
  value       = aws_instance.private-instance.private_ip
  description = "Private IP of the private instance"
}
