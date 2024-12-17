resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
      "Name" = "${var.env}-private-route"
    }
}

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {    
      "Name" = "${var.env}-public-route"
    }
}

resource "aws_route_table_association" "private_1" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_2" {
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "public_1" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_2" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route.id
}