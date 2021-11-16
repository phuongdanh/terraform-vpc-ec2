variable ec2_name {
  description = "Name of EC2"
  type        = string
  default     = "my-terraform-ec2-cluster"
}
variable vpc_id {
  description = "VPC id"
  type        = string
}
variable public_subnet_id {
  description = "Public subnet id"
  type        = string
}
variable key_name {
  type = string
}
