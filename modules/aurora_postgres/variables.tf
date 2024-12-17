variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "env" {
    description = "Environment"
    type = string
}

variable "eks_name" {
    description = "AWS EKS Name"
    type = string
}

variable "zone_1" {
    description = "AWS Region az 1"
    type = string
    # default = "ap-southeast-1a"
}

variable "zone_2" {
    description = "AWS Region az 2"
    type = string
    # default = "ap-southeast-1b"
}

variable "zone_3" {
    description = "AWS Region az 3"
    type = string
    # default = "ap-southeast-1c"
}