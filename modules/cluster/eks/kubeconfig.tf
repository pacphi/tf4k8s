module "kubeconfig" {
  source = "generate-kubeconfig"

  endpoint       = aws_eks_cluster.cluster.endpoint
  certificate_ca = aws_eks_cluster.cluster.certificate_authority.0.data
  token          = data.aws_eks_cluster_auth.default.token
}