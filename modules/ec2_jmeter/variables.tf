variable "vpc_id" {
  description = "VPC ID"
  type        = string
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