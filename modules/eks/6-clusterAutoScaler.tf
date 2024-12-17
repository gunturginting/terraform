resource "aws_iam_role" "cluster_autoscaler" {
    name = "${aws_eks_cluster.eks.name}-cluster-autoscaler"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "sts:AssumeRole",
              "sts:TagSession"
            ]
            Principal = {
              Service = "pods.eks.amazonaws.com"
            }
          }
        ]
    })
}

resource "aws_iam_policy" "autoscaler_policy" {
    name = "${aws_eks_cluster.eks.name}-cluster-autoscaler-policy"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeScalingActivities",
        "ec2:DescribeImages",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:GetInstanceTypesFromInstanceRequirements",
        "eks:DescribeNodegroup"
      ],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
      ],
      "Resource": ["*"]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
    policy_arn = aws_iam_policy.autoscaler_policy.arn
    role = aws_iam_role.cluster_autoscaler.name
}

resource "aws_eks_pod_identity_association" "pod_identity_autoscaler" {
    cluster_name = aws_eks_cluster.eks.name
    namespace = "kube-system"
    role_arn = aws_iam_role.cluster_autoscaler.arn
    service_account = "cluster-autoscaler"
}

resource "helm_release" "autoscaler_deployment" {
      name = "cluster-autoscaler"
      repository = "https://kubernetes.github.io/autoscaler"
      chart = "cluster-autoscaler"
      namespace = "kube-system"
      version = "9.37.0"

      set {
        name = "rbac.serviceAccount.name"
        value = aws_eks_pod_identity_association.pod_identity_autoscaler.service_account
      }

      set {
        name = "autoDiscovery.clusterName"
        value = aws_eks_cluster.eks.name
      }

      set {
        name = "awsRegion"
        value = var.region
      }

      depends_on = [ helm_release.metric_server ]
}