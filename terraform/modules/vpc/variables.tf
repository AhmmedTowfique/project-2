variable "name" {
  description = "Name of the VPC"
  default     = "towfique-project-2"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of AZs to deploy subnets"
  default     = ["us-east-1a", "us-east-1b"]
}
