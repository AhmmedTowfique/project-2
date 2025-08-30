provider "aws" {
  region = "us-east-1"
}

##########################
# Create VPC
##########################
module "vpc" {
  source = "./modules/vpc"
}

##########################
# EKS Cluster IAM Role
##########################
data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "towfique-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

##########################
# Create EKS Cluster
##########################
module "eks" {
  source           = "./modules/eks"
  cluster_name     = "towfique-project-2-eks-cluster"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_ids
  cluster_role_arn = aws_iam_role.eks_cluster_role.arn
}

##########################
# Node Group IAM Role
##########################
data "aws_iam_policy_document" "node_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_node_role" {
  name               = "towfique-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

##########################
# IAM Instance Profile for Node Group
##########################
resource "aws_iam_instance_profile" "node_instance_profile" {
  name = "towfique-nodes-instance-profile"
  role = aws_iam_role.eks_node_role.name
}

##########################
# Node Group
##########################
module "node_group" {
  source                = "./modules/node_group"
  cluster_name          = module.eks.cluster_name
  node_group_name       = "nodes" # module will prepend "towfique-"
  node_role_arn         = aws_iam_role.eks_node_role.arn
  node_role_name        = aws_iam_role.eks_node_role.name
  subnet_ids            = module.vpc.subnet_ids

  desired_size          = 3
  min_size              = 3
  max_size              = 3

  key_name              = "git-action-key"
}
