variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "towfique-project-2-eks-cluster"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for EKS"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  type        = string
}
