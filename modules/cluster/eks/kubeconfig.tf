data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.cluster.name
}

module "kubeconfig" {
  source = "../../generate-kubeconfig"

  directory      = "/tmp/eks"
  filename       = "${var.eks_name}-${random_id.cluster_name.hex}-kubeconfig"
  endpoint       = aws_eks_cluster.cluster.endpoint
  certificate_ca = aws_eks_cluster.cluster.certificate_authority.0.data
  token          = data.aws_eks_cluster_auth.this.token
}