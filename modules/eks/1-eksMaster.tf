resource "aws_iam_role" "iam_role_eks" {
    name = "${var.env}-${var.eks_name}-eks-cluster"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "role_policy_eks" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.iam_role_eks.name
}

resource "aws_eks_cluster" "eks" {
    name = "${var.env}-${var.eks_name}"
    version = local.eks_version
    role_arn = aws_iam_role.iam_role_eks.arn

    vpc_config {
      subnet_ids = [
        var.private_subnet_1,
        var.private_subnet_2
      ]

      endpoint_private_access = false
      endpoint_public_access = true
    }

    access_config {
      authentication_mode = "API"
      bootstrap_cluster_creator_admin_permissions = true
    }

    depends_on = [ aws_iam_role_policy_attachment.role_policy_eks ]
}