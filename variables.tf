variable "region" {
    description = "AWS Region"
    type = string
    default = "ap-southeast-1"
}

variable "zone_1" {
    description = "AWS Region az 1"
    type = string
    default = "ap-southeast-1a"
}

variable "zone_2" {
    description = "AWS Region az 2"
    type = string
    default = "ap-southeast-1b"
}

variable "zone_3" {
    description = "AWS Region az 3"
    type = string
    default = "ap-southeast-1c"
}

variable "env" {
    description = "Environment"
    type = string
}

variable "eks_name" {
    description = "AWS EKS Name"
    type = string
}