# Tên của EKS cluster
cluster_name = "my-eks-cluster"

# Tên IAM role của EKS cluster
eks_cluster_role_name = "eks-cluster-role"

# Phiên bản Kubernetes
kubernetes_version = "5.8.0"

# Tên security group của EKS cluster
eks_sg = "eks-cluster-sg"

# Tên của EKS node group
eks_node_group_name = "my-eks-node-group"

# Loại AMI của EKS node group
ami_type = "AL2_x86_64"

# Loại instance của EKS node group
instance_types = "t3.medium"

# Số lượng node tối thiểu trong EKS node group
min_size = 1

# Số lượng node mong muốn trong EKS node group
desired_size = 2

# Số lượng node tối đa trong EKS node group
max_size = 3

# Các thẻ (tags) cho tài nguyên
tags = {
  Environment = "Production"
  Project     = "EKS-Cluster"
  Owner       = "DevOps-Team"
}
eks_worker_node_role = "eks-worker-node-role"