# // Generate the SSH keypair that we’ll use to configure the EC2 instance. 
# // After that, write the private key to a local file and upload the public key to AWS

# resource "tls_private_key" "key" {
#   algorithm = "RSA"
#   rsa_bits  = "4096"
# }

# resource "local_file" "private_key" {
#   filename          = "my-terraform-ssh-key.pem"
#   sensitive_content = tls_private_key.key.private_key_pem
#   file_permission   = "0400"
# }

resource aws_key_pair key_pair {
  key_name   = var.ssh_key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4croOA9MqN7V56a+5+WpDbvALMABGOI0/Ji9bEm18LlceFjM63NgckwSqyaDg01vsLlklahH9a+a/TdkeY26Yt77/VdW469HgoRXDIif0oD5sNB70oh58uJ9Hb6dyKqDe9FBk+J/ZxpqM43MKLKrf7oJbxp3FmOwfxOaVQ0XQqY0rxC/0dpOjr9NGTE8fFcW03DvWahPqGfoX96q2ZCU/B+7L3goN2YTyNfNUVIaFKPSZngXY+iS59LC86DArP9Nhh+zyCDJGVUM6wl18RkFhwWhMMs5PVDV4wI75M9t3pYxotyODJGfeoj8Z9z7F+uHlzJZhkjmrL9NPR+07XvkT neolab@neolab-B460MAORUSPRO"
}

variable ssh_key_name {
  description = "Name of SSH key"
  type        = string
  default     = "my-terraform-ssh-key"
}