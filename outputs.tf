# Output variable definitions

output "connect" {
  description = "SSH connection"
  value       = "ssh -i ${module.ssh_key.key_name}.pem ec2-user@${module.ec2.ec2_instance_public_ip}"
}
