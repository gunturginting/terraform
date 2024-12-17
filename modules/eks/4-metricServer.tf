resource "helm_release" "metric_server" {
    name = "metrics-server"
    repository = "https://kubernetes-sigs.github.io/metrics-server/"
    chart = "metrics-server"
    version = "3.12.1"
    namespace = "kube-system"

    values = [
        file("${path.module}/values/metrics-server.yaml")
    ]

    depends_on = [ aws_eks_node_group.eks_node ]
}   