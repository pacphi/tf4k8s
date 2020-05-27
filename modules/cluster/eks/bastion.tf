resource "aws_security_group" "provisioner" {
  name        = "${local.full_environment_prefix}-provisioner-sg"
  description = "Allow SSH access to provisioner host and outbound internet access"
  vpc_id      = module.vpc.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ssh" {
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.provisioner.id
}

resource "aws_security_group_rule" "internet" {
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.provisioner.id
}

data "aws_ami" "default" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Canonical
  owners = ["099720109477"]
}

locals {
  ami_id        = data.aws_ami.default.id
  disk_size     = 64
  instance_type = "t3a.medium"
  username      = "ubuntu"
}

resource "aws_eip" "provisioner" {
  vpc      = true
  instance = aws_instance.provisioner.id
}

resource "aws_instance" "provisioner" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  key_name               = var.ssh_key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.provisioner.id]

  root_block_device {
    volume_size           = local.disk_size
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "${local.full_environment_prefix}-bastion"
  }
}