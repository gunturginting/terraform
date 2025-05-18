module "ubuntu_ami" {
    source = "../aws_ami"
}

resource "aws_security_group" "pam_sg" {
    vpc_id = var.vpc_id
    name = "pam-sg"
    description = "Allow access for PAM VM"

    tags = {
        Name = "pam-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.pam_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.pam_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_pam" {
    security_group_id = aws_security_group.pam_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "pam" {
    ami             = module.ubuntu_ami.ami_id_amd
    instance_type   = "t3.medium"
    key_name        = "devops-poc"
    subnet_id       = var.private_subnet_1

    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.pam_sg.id]

    root_block_device {
        volume_size = 50
        volume_type = "gp3"
        iops = 6000

    }

    tags = {
        Name = "pam"
    }
}