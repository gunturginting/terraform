resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "172.24.1.0/24"
    availability_zone = var.zone_1

    tags = {
      "Name"                                                    = "${var.env}-private-${var.zone_1}"
      "kubernetes.io/role/internal-elb"                         = "1"
      "kubernetes.io/cluster/${var.env}-${var.eks_name}"        = "owned"
    }       
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "172.24.2.0/24"
    availability_zone = var.zone_2

    tags = {
      "Name"                                                    = "${var.env}-private-${var.zone_2}"
      "kubernetes.io/role/internal-elb"                         = "1"
      "kubernetes.io/cluster/${var.env}-${var.eks_name}"        = "owned"
    }       
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "172.24.3.0/24"
    availability_zone = var.zone_1
    map_public_ip_on_launch = true

    tags = {
      "Name"                                                    = "${var.env}-public-${var.zone_1}"
      "kubernetes.io/role/elb"                                  = "1"
      "kubernetes.io/cluster/${var.env}-${var.eks_name}"        = "owned"
    }               
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "172.24.4.0/24"
    availability_zone = var.zone_2
    map_public_ip_on_launch = true

    tags = {
      "Name"                                                    = "${var.env}-public-${var.zone_2}"
      "kubernetes.io/role/elb"                                  = "1"
      "kubernetes.io/cluster/${var.env}-${var.eks_name}"        = "owned"
    }               
}