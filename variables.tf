variable "region" {
    description = "AWS Region"
    type = string
    default = "ap-southeast-3"
}

variable "zone_1" {
    description = "AWS Region az 1"
    type = string
    default = "ap-southeast-3a"
}

variable "zone_2" {
    description = "AWS Region az 2"
    type = string
    default = "ap-southeast-3b"
}

variable "zone_3" {
    description = "AWS Region az 3"
    type = string
    default = "ap-southeast-3c"
}

variable "env" {
    description = "Environment"
    type = string
}

variable "eks_name" {
    description = "AWS EKS Name"
    type = string
}

variable "db_master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}