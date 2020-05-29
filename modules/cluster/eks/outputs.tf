output "ssh_key_name" {
  description = "Name of SSH key used for bastion host and cluster worker nodes"
  value = module.ssh_key_pair.key_name
}

output "ssh_private_key_filename" {
  description = "Private Key Filename"
  value = module.ssh_key_pair.private_key_filename
}

output "ssh_public_key_filename" {
  description = "Public Key Filename"
  value = module.ssh_key_pair.public_key_filename
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value = aws_eks_cluster.cluster.id
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value = aws_eks_cluster.cluster.arn
}

output "eks_region" {
  description = "The AWS region within which the EKS cluster is running"
  value = var.region
}

output "kubeconfig_path_eks" {
  value = module.kubeconfig.path_to_kubeconfig
}