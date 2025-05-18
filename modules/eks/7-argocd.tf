# Create namespace for ArgoCD
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.0.1"

  name      = "argocd"
  namespace = var.argocd_namespace

  values = [
    file("${path.module}/values/argocd.yaml")
  ]

  depends_on = [ aws_eks_node_group.eks_node ]

}