module "ubuntu_ami" {
    source = "../aws_ami"
}

resource "aws_security_group" "jmeter_sg" {
    vpc_id = var.vpc_id
    name = "jmeter-sg"
    description = "Allow access for Jmeter"

    tags = {
        Name = "jmeter-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.jmeter_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_rmi_registry" {
    security_group_id = aws_security_group.jmeter_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 1099
    to_port = 1099
    ip_protocol = "tcp"
    description = "RMI Registry untuk komunikasi antara master dan slave"
}

resource "aws_vpc_security_group_ingress_rule" "allow_jmeter" {
    security_group_id = aws_security_group.jmeter_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 4445
    to_port = 4445
    ip_protocol = "tcp"
    description = "Default Jmeter"
}

resource "aws_vpc_security_group_ingress_rule" "allow_jmeter_slave" {
    security_group_id = aws_security_group.jmeter_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 30000
    to_port = 50000
    ip_protocol = "tcp"
    description = "Digunakan jika ada lebih dari satu slave, pastikan kisaran ini terbuka"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_jumpserver" {
    security_group_id = aws_security_group.jmeter_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "jmeter_master" {
    ami             = module.ubuntu_ami.ami_id
    instance_type   = "m6g.2xlarge"
    key_name        = "devops-poc"
    subnet_id       = var.private_subnet_1

    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.jmeter_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 10000

    }

    tags = {
        Name = "jmeter-master"
    }
}

resource "aws_instance" "jmeter_slave" {
    ami             = module.ubuntu_ami.ami_id
    instance_type   = "m6g.8xlarge"
    count           = 5
    key_name        = "devops-poc"
    subnet_id       = element([var.private_subnet_1, var.private_subnet_2], count.index)

    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.jmeter_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 10000

    }

    tags = {
        Name = "jmeter-slave-${count.index + 1}"
    }
}