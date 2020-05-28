# EKS Control Plane security group
resource "aws_security_group_rule" "vpc_endpoint_eks_cluster_sg" {

  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpc_endpoint.id
  source_security_group_id = aws_eks_cluster.cluster.vpc_config.0.cluster_security_group_id
  to_port                  = 443
  type                     = "ingress"
  depends_on = [aws_eks_cluster.cluster]
}

# EKS Cluster
resource "aws_eks_cluster" "cluster" {
  enabled_cluster_log_types = []
  name                      = local.full_environment_prefix
  role_arn                  = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = flatten([module.vpc.public_subnets, module.vpc.private_subnets])
    security_group_ids      = []
    endpoint_private_access = "true"
    endpoint_public_access  = "true"
  }
  tags = var.tags
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.cluster
  ]
}

resource "aws_cloudwatch_log_group" "cluster" {
  name              = "/aws/eks/${local.full_environment_prefix}/cluster"
  retention_in_days = 7
}

resource "aws_iam_role" "cluster" {
  name = "${local.full_environment_prefix}-cluster-role"
assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
tags = var.tags
}

resource "aws_iam_role_policy_attachment"     "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster.name
}