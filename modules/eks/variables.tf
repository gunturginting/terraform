variable "region" {
    description = "AWS Region"
    type = string
    # default = "ap-southeast-1"
}

variable "env" {
    description = "Environment"
    type = string
}

variable "eks_name" {
    description = "AWS EKS Name"
    type = string
}

variable "private_subnet_1" {
  description = "Private subnet 1 ID"
  type = string
}

variable "private_subnet_2" {
  description = "Private subnet 2 ID"
  type = string
}

variable "argocd_namespace" {
  description = "Namespace to install ArgoCD"
  type        = string
  default     = "argocd"
}