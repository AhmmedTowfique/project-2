##########################
# Launch Template for Ubuntu Nodes
##########################
resource "aws_launch_template" "ubuntu_nodes" {
  name_prefix   = "towfique-eks-ubuntu-"
  image_id      = "ami-0d6429b888892aaf3"  # Ubuntu EKS-optimized AMI for k8s 1.31
  instance_type = "t3.medium"

  key_name = var.key_name  # optional SSH access

  user_data = base64encode(<<EOF
#!/bin/bash
/etc/eks/bootstrap.sh ${var.cluster_name}
EOF
  )
}

##########################
# IAM Instance Profile for Node Group
##########################
resource "aws_iam_instance_profile" "node_instance_profile" {
  name = "${var.node_group_name}-instance-profile"
  role = var.node_role_name
}

##########################
# EKS Node Group using Launch Template
##########################
resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "towfique-${var.node_group_name}"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  launch_template {
    id      = aws_launch_template.ubuntu_nodes.id
    version = "$Latest"
  }

  tags = {
    Name = "towfique-${var.node_group_name}-node"
  }
}
