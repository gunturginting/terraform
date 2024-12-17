resource "aws_eip" "eip" {
    domain = "vpc"

    tags = {
      "Name" = "${var.env}-eip-nat"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public_subnet_1.id

    tags = {
      "Name" = "${var.env}-nat-gateway"
    }

    depends_on = [ aws_internet_gateway.igw ]
}