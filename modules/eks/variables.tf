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