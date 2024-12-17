output "eks_cluster_name" {
    description = "Cluster EKS Name"
    value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
    description = "Cluster EKS Endpoint"
    value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_version" {
    description = "Cluster EKS Version"
    value = aws_eks_cluster.eks.version
}

output "eks_node_name" {
    description = "EKS Node Name"
    value = aws_eks_node_group.eks_node.node_group_name
}

output "eks_node_group_instance_type" {
    description = "EKS Node Instance Type"
    value = aws_eks_node_group.eks_node.instance_types
}

output "eks_node_group_desired_size" {
    description = "EKS Node Desired Size"
    value = aws_eks_node_group.eks_node.scaling_config[0].desired_size
}

output "metric_server_status" {
    description = "Metric Server Status"
    value = helm_release.metric_server.status
}

output "cluster_autoscaller_status" {
    description = "Cluster Autoscaller Status"
    value = helm_release.autoscaler_deployment.status
}