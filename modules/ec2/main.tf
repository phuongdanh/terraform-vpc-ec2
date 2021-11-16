data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource aws_security_group allow_ssh_pub {
  name        = "sg_allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_terrfrom_example"
  }
}


resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_pub.id]
  subnet_id              = var.public_subnet_id

  tags = {
    "Name" = var.ec2_name
  }

  # # Copies the ssh key file to home dir
  # provisioner "file" {
  #   source      = "./${var.key_name}.pem"
  #   destination = "/home/ec2-user/${var.key_name}.pem"
  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("${var.key_name}.pem")
  #     host        = self.public_ip
  #   }
  # }

  # # chmod key 400 on EC2 instance
  # provisioner "remote-exec" {
  #   inline = ["chmod 400 ~/${var.key_name}.pem"]
  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("${var.key_name}.pem")
  #     host        = self.public_ip
  #   }
  # }
}