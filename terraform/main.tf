# provider "aws" {
#   region = var.aws_region
# }

# # Create an EKS cluster
# module "eks_cluster" {
#   source          = "terraform-aws-modules/eks/aws"
#   cluster_name    = var.cluster_name
#   cluster_version = "1.30"
#   subnets         = var.subnets
#   vpc_id          = var.vpc_id

#   worker_groups = [
#     {
#       instance_type = "t3.medium"
#       asg_max_size  = 2
#     }
#   ]
# }

# # Create an ECR repository
# resource "aws_ecr_repository" "app_repo" {
#   name = var.ecr_repository_name
# }

# # Deploy Prometheus, Grafana, and Alertmanager using Helm
# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-prometheus-stack"
#   namespace  = "monitoring"

#   values = [
#     file("${path.module}/monitoring/prometheus-values.yaml")
#   ]
# }

# resource "helm_release" "grafana" {
#   name       = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana"
#   namespace  = "monitoring"

#   values = [
#     file("${path.module}/monitoring/grafana-values.yaml")
#   ]
# }

# resource "helm_release" "alertmanager" {
#   name       = "alertmanager"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "alertmanager"
#   namespace  = "monitoring"

#   values = [
#     file("${path.module}/monitoring/alertmanager-values.yaml")
#   ]
# }

provider "aws" {
  region = var.aws_region
}

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.30"

  vpc_id          = var.vpc_id
  subnets         = var.subnets

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

module "monitoring_stack" {
  source  = "terraform-aws-modules/eks/aws//modules/kubernetes-addons"
  version = "20.31.6"

  cluster_name = module.eks_cluster.cluster_name

  enable_prometheus = true
  enable_grafana    = true
  enable_alertmanager = true
}