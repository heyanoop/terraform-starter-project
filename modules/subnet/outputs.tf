output "private_subnet_id" {
  value = aws_subnet.private-subnet.id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}