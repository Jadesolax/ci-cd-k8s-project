# variable "aws_region" {
#   description = "AWS region"
#   default     = "eu-west-2"
# }

# variable "cluster_name" {
#   description = "Name of the EKS cluster"
#   default     = "my-cluster"
# }

# variable "ecr_repository_name" {
#   description = "Name of the ECR repository"
#   default     = "my-repo"
# }

# variable "vpc_id" {
#   description = "VPC ID for the EKS cluster"
# }

# variable "subnets" {
#   description = "Subnets for the EKS cluster"
#   type        = list(string)
# }

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "subnets" {
  description = "Subnets for the EKS cluster"
  type        = list(string)
}