resource "aws_eks_addon" "pod_identity" {
    cluster_name = aws_eks_cluster.eks.name
    addon_name = "eks-pod-identity-agent"
    addon_version = "v1.2.0-eksbuild.1"
}

resource "aws_eks_addon" "ebs_csi" {
    cluster_name = aws_eks_cluster.eks.name
    addon_name = "aws-ebs-csi-driver"
    addon_version = "v1.40.0-eksbuild.1"
}