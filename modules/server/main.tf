resource "aws_instance" "server" {
  instance_type                        = var.ec2_instance_type
  ami                                  = var.ec2_ami
  monitoring                           = false
  instance_initiated_shutdown_behavior = "stop"

  vpc_security_group_ids = [aws_security_group.server.id]
  iam_instance_profile   = aws_iam_instance_profile.server.name
  key_name               = aws_key_pair.server.key_name

  // Do not set subnet_id, it will be auto-selected from a default subnet

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = "gp2"
  }

  tags = {
    Name = var.project_slug
  }

  lifecycle {
    ignore_changes = [
      # Allow an updated AMI be used for new provisions without always recreating the machine
      ami,
    ]
  }
}

resource "aws_key_pair" "server" {
  key_name   = var.project_slug
  public_key = var.ssh_public_key
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "server" {
  name   = var.project_slug
  vpc_id = aws_default_vpc.default.id

  egress {
    description = "Any TCP"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "DNS queries"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "server" {
  instance = aws_instance.server.id

  tags = {
    Name = var.project_slug
  }
}
