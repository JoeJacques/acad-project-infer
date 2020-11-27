output "sec_group_id" {
  value = aws_security_group.sec_group_dev.id
}

output "subnet_id" {
  value = aws_subnet.public_dev[*].id
}

output "vpc_id" {
  value = aws_vpc.main_dev.id
}