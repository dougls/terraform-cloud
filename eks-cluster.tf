variable "awsAcademyRole" {
  default = "arn:aws:iam::xxxxxxxxxx:role/LabRole"
}

resource "aws_eks_cluster" "eks_cluster_fiap" {
  name     = "fiap-eks"
  role_arn = var.awsAcademyRole

  vpc_config {
    subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
    security_group_ids = ["${var.securityGroupId}"]
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
}

resource "aws_eks_access_entry" "eks_cluster_access_entry" {
  cluster_name      = aws_eks_cluster.eks_cluster_fiap.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["group-1", "group-2"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_cluster_access_entry_policy_association" {
  cluster_name  = aws_eks_cluster.eks_cluster_fiap.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.eks_cluster_fiap.name
  node_group_name = "fiap-node"
  node_role_arn   = var.awsAcademyRole
  subnet_ids      = ["${var.subnetA}", "${var.subnetB}", "${var.subnetC}"]
  instance_types  = ["t3.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}
