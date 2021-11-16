output "ec2_instance_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.ec2.public_ip
}