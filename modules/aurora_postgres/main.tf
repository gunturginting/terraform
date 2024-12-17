resource "aws_security_group" "rds_sg" {
    vpc_id = var.vpc_id
    name = "rds-postgres-private-sg"
    description = "Allow access to Aurora postgres from EKS private subnets"

    tags = {
        Name = "allow_rds"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres" {
    security_group_id = aws_security_group.rds_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 5432
    to_port = 5432
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_rds" {
    security_group_id = aws_security_group.rds_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
    name = "${var.env}-aurora-subnet-group"
    description = "Subnet group for Aurora RDS in ${var.env} environment"

    subnet_ids = [
        var.private_subnet_1,
        var.private_subnet_2
    ]

    tags = {
      Name = "${var.env}-aurora-subnet-group"
    }
}

resource "aws_rds_cluster" "aurora_postgres" {
    cluster_identifier = "aurora-cluster-postgresql-${var.env}-${var.eks_name}"
    engine = "aurora-postgresql"
    engine_version = "13.12"
    availability_zones = ["${var.zone_1}", "${var.zone_2}"]
    database_name = "pegadaian"
    master_username = "postgres"
    master_password = "P@ss42024!"
    backup_retention_period = 7
    preferred_backup_window = "19:00-20:00"
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
    
    tags = {
      ManagedBy = "Terraform"
      Project = "${var.eks_name}"
    }
}

resource "aws_rds_cluster_instance" "aurora_postgres_slave" {
    count = 1
    identifier = "aurora-cluster-postgresql-${var.env}-${var.eks_name}-${count.index}"
    cluster_identifier = aws_rds_cluster.aurora_postgres.id
    instance_class = "db.t3.medium"
    engine = aws_rds_cluster.aurora_postgres.engine
    engine_version = aws_rds_cluster.aurora_postgres.engine_version

    tags = {
      ManagedBy = "Terraform"
      Project = "${var.eks_name}"
    }
}