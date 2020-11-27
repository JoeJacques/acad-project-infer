output "sec_group_id" {
  value = aws_security_group.sec_group.id
}

output "subnet_id" {
  value = aws_subnet.public[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}