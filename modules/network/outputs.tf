output "vpc_id" {
    description = "VPC ID"
    value = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
    description = "VPC CIDR Block"
    value = aws_vpc.main_vpc.cidr_block
}

output "public_subnet_1" {
    description = "Public Subnet IDs"
    value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
    description = "Public Subnet IDs"
    value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1" {
    description = "Public Subnet IDs"
    value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
    description = "Public Subnet IDs"
    value = aws_subnet.private_subnet_2.id
}

output "nat_gateway_id" {
    description = "NAT GW ID"
    value = aws_nat_gateway.nat.id
}