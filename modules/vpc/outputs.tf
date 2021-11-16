# Output variable definitions

output "vpc_public_subnet" {
  description = "IDs of the VPC's public subnets"
  value       = aws_subnet.public_a
}

output "id" {
  value = aws_vpc.vpc.id
}