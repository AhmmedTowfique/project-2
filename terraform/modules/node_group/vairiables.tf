variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  default     = "towfique-nodes"
}

variable "node_role_arn" {
  description = "IAM Role ARN for Node Group"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the Node Group"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of nodes"
  default     = 2
}

variable "min_size" {
  description = "Minimum number of nodes"
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes"
  default     = 3
}
