# Input variable definitions

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "example-terraform-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_region" {
  description = "Region for VPC"
  type        = string
  default     = "us-west-2"
}

# variable "vpc_azs" {
#   description = "Availability zones for VPC"
#   type        = list(string)
#   default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
# }

# variable "vpc_enable_nat_gateway" {
#   description = "Enable NAT gateway for VPC"
#   type        = bool
#   default     = true
# }

# variable "vpc_tags" {
#   description = "Tags to apply to resources created by VPC module"
#   type        = map(string)
#   default = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }
