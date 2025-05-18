module "ubuntu_ami" {
    source = "../aws_ami"
}

resource "aws_security_group" "jumpserver_sg" {
    vpc_id = var.vpc_id
    name = "devops-sg"
    description = "Allow access for DevOps VM"

    tags = {
        Name = "devops-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.jumpserver_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
    security_group_id = aws_security_group.jumpserver_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
    security_group_id = aws_security_group.jumpserver_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_jumpserver" {
    security_group_id = aws_security_group.jumpserver_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "jumpserver" {
    ami             = module.ubuntu_ami.ami_id_amd
    instance_type   = "t3.medium"
    key_name        = "devops-poc"
    subnet_id       = var.public_subnet_1

    associate_public_ip_address = true

    vpc_security_group_ids = [aws_security_group.jumpserver_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 6000

    }

    tags = {
        Name = "jumphost"
    }
}