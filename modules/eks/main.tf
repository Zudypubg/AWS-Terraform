module "networking" {
  source = "../networking"
}
module "iam" {
  source = "../iam"
  eks_worker_node_role = var.eks_worker_node_role
}
# Tạo IAM role EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role_name
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}
# Gắn IAM Role cho cluster
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
# Tạo EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = var.eks_sg
  vpc_id      = module.networking.vpc_id
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.networking.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {}
}
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version     = var.kubernetes_version
  vpc_config {
    subnet_ids = module.networking.private_subnet_ids
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
  
}
resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = var.cluster_name
  node_group_name = var.eks_node_group_name
  node_role_arn   = module.iam.eks_work_node_role_arn
  ami_type        = var.ami_type
  instance_types  = [var.instance_types]
  subnet_ids = module.networking.private_subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
}