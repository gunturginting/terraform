module "ubuntu_ami" {
    source = "../aws_ami"
}

resource "aws_security_group" "elastic_sg" {
    vpc_id = var.vpc_id
    name = "elastic-sg"
    description = "Allow access for Elastic VM"

    tags = {
        Name = "elastic-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.elastic_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_kibana" {
    security_group_id = aws_security_group.elastic_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 5601
    to_port = 5601
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_elastic" {
    security_group_id = aws_security_group.elastic_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 9200
    to_port = 9200
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_elastic_2" {
    security_group_id = aws_security_group.elastic_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 9300
    to_port = 9300
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_elastic" {
    security_group_id = aws_security_group.elastic_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "kibana" {
    ami             = module.ubuntu_ami.ami_id_amd
    instance_type   = "t3.medium"
    key_name        = "devops-poc"
    subnet_id       = var.private_subnet_1

    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.elastic_sg.id]

    root_block_device {
        volume_size = 30
        volume_type = "gp3"
        iops = 6000

    }

    tags = {
        Name = "Kibana"
    }
}

resource "aws_instance" "elastic" {
    ami             = module.ubuntu_ami.ami_id_amd
    instance_type   = "t3.medium"
    key_name        = "devops-poc"
    subnet_id       = var.private_subnet_2

    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.elastic_sg.id]

    root_block_device {
        volume_size = 30
        volume_type = "gp3"
        iops = 6000

    }

    tags = {
        Name = "Elastic"
    }
}