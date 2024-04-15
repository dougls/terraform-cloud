resource "aws_eks_cluster" "tech_challenge_cluster" {
  name     = "tech-challenge-cluster"
  role_arn = var.awsAcademyRole

  vpc_config {
    subnet_ids         = ["${var.subnetA}", "${var.subnetB}", "${var.subnetC}"]
    security_group_ids = ["${var.securityGroupId}"]
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
}

resource "aws_eks_access_entry" "tech_challenge_cluster_access_entry" {
  cluster_name      = aws_eks_cluster.tech_challenge_cluster.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["group-1", "group-2"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "tech_challenge_cluster_access_entry_policy_association" {
  cluster_name  = aws_eks_cluster.tech_challenge_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_node_group" "food_challenge" {
  cluster_name    = aws_eks_cluster.tech_challenge_cluster.name
  node_group_name = "food-challenge"
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