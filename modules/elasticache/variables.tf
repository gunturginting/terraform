variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "env" {
    description = "Environment"
    type = string
}

variable "redis_name" {
    description = "AWS Redis Name"
    type = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "private_subnet_1" {
  description = "Private subnet 1 ID"
  type = string
}

variable "private_subnet_2" {
  description = "Private subnet 2 ID"
  type = string
}

variable "redis_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}