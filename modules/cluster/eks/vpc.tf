module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"
  name = "${local.full_environment_prefix}-vpc"
  azs = var.availability_zones
  cidr = "10.60.0.0/18"

  private_subnets = ["10.60.0.0/20", "10.60.16.0/20", "10.60.32.0/20"]
  public_subnets  = ["10.60.48.0/22", "10.60.52.0/22", "10.60.56.0/22"]
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/${local.full_environment_prefix}" = "shared"
    },
  )

  enable_ecr_dkr_endpoint              = true
  ecr_dkr_endpoint_private_dns_enabled = true
  ecr_dkr_endpoint_security_group_ids  = [aws_security_group.vpc_endpoint.id]
  enable_s3_endpoint = true
}

# Security Group configuration for VPC endpoints
resource "random_id" "vpc_endpoint_sg_suffix" {
  byte_length = 4
}

resource "aws_security_group" "vpc_endpoint" {
  name        = "${local.full_environment_prefix}-sg-${random_id.vpc_endpoint_sg_suffix.hex}"
  description = "Security Group used by VPC Endpoints."
  vpc_id      = module.vpc.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = "${local.full_environment_prefix}-sg-${random_id.vpc_endpoint_sg_suffix.hex}"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "vpc_endpoint_egress" {
  security_group_id = aws_security_group.vpc_endpoint.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "vpc_endpoint_self_ingress" {
  security_group_id        = aws_security_group.vpc_endpoint.id
  type                     = "ingress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  source_security_group_id = aws_security_group.vpc_endpoint.id
}