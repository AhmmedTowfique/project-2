variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group (Terraform will prefix with 'towfique-')"
  type        = string
  default     = "nodes"
}

variable "node_role_arn" {
  description = "IAM Role ARN for the Node Group"
  type        = string
}

variable "node_role_name" {
  description = "The IAM role name for the worker nodes"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Node Group"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of nodes in the Node Group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of nodes in the Node Group"
  type        = number
  default     = 3
}

variable "max_size" {
  description = "Maximum number of nodes in the Node Group"
  type        = number
  default     = 3
}

variable "key_name" {
  description = "AWS Key Pair name for SSH access to nodes (optional)"
  type        = string
  default     = "git-action-key"
}
