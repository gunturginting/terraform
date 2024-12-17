resource "aws_vpc" "main_vpc" {
  cidr_block = "172.24.0.0/21"

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-main-vpc"
  }
}