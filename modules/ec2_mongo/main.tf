module "ubuntu_ami" {
    source = "../aws_ami"
}

resource "aws_security_group" "mongos_sg" {
    vpc_id = var.vpc_id
    name = "mongos-private-sg"
    description = "Allow access to Mongos Server from EKS private subnets"

    tags = {
        Name = "allow_mongos"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mongos" {
    security_group_id = aws_security_group.mongos_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 27017
    to_port = 27017
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_mongos_config" {
    security_group_id = aws_security_group.mongos_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 27019
    to_port = 27019
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_mongos_shard" {
    security_group_id = aws_security_group.mongos_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 27018
    to_port = 27018
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.mongos_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_mongos" {
    security_group_id = aws_security_group.mongos_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "mongos_server" {
    ami             = module.ubuntu_ami.ami_id
    instance_type   = "m6g.2xlarge"
    count           = 2
    key_name        = "devops-poc"
    subnet_id       = element([var.private_subnet_1, var.private_subnet_2], count.index)
    
    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.mongos_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 10000

    }

    tags = {
        Name = "mongos-server-${count.index + 1}"
    }
}

resource "aws_instance" "mongos_config_server" {
    ami             = module.ubuntu_ami.ami_id
    instance_type   = "m6g.large"
    count           = 3
    key_name        = "devops-poc"
    subnet_id       = element([var.private_subnet_1, var.private_subnet_2], count.index)
    
    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.mongos_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 10000

    }

    tags = {
        Name = "mongos-config-server-${count.index + 1}"
    }
}

resource "aws_instance" "mongos_shard_1" {
    ami             = module.ubuntu_ami.ami_id
    instance_type   = "m6g.4xlarge"
    count           = 3
    key_name        = "devops-poc"
    subnet_id       = var.private_subnet_1
    
    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.mongos_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 10000

    }

    tags = {
        Name = "mongos-shard-${element(["1a", "1b", "1c"], count.index)}"
    }
}

resource "aws_instance" "mongos_shard_2" {
    ami             = module.ubuntu_ami.ami_id
    instance_type   = "m6g.4xlarge"
    count           = 3
    key_name        = "devops-poc"
    subnet_id       = var.private_subnet_2
    
    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.mongos_sg.id]

    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        iops = 10000

    }

    tags = {
        Name = "mongos-shard-${element(["2a", "2b", "2c"], count.index)}"
    }
}