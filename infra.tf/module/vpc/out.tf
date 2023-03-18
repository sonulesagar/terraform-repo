output "public_sub_id" {
    value = aws_subnet.public_sub.*.id  
}

output "security_groups" {
    value = aws_security_group.my-SG.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
