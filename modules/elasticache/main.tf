resource "aws_security_group" "elasticache_sg" {
    vpc_id = var.vpc_id
    name = "elasticache-private-sg"
    description = "Allow access to Elasticache Redis from EKS private subnets"

    tags = {
        Name = "allow_elasticache"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_elasticache" {
    security_group_id = aws_security_group.elasticache_sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 6379
    to_port = 6379
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_elasticache" {
    security_group_id = aws_security_group.elasticache_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_elasticache_subnet_group" "elasticache_subnet" {
    name = "${var.env}-elasticache-subnet-group"
    subnet_ids = [
        var.private_subnet_1,
        var.private_subnet_2
    ]

    tags = {
      Name = "${var.env}-elasticache-subnet-group"
    }
}

# resource "aws_elasticache_cluster" "elasticache" {
#     cluster_id            = "${var.env}-${var.redis_name}"
#     engine                = "redis"
#     engine_version        = local.redis_version
#     node_type             = "cache.r5.large"
#     num_cache_nodes       = 1
#     parameter_group_name  = "default.redis7"
#     port                  = 6379
#     #apply_immediately = true
# }

resource "aws_elasticache_replication_group" "elasticache" {
    replication_group_id       = "${var.env}-${var.redis_name}-replication"
    description                = "Redis replication group"
    engine                     = "redis"
    engine_version             = local.redis_version
    node_type                  = "cache.r5.large"
    num_cache_clusters         = 2  
    parameter_group_name       = "default.redis7"
    port                       = 6379
    auth_token                 = null
    automatic_failover_enabled = true  
    multi_az_enabled           = true  
    transit_encryption_enabled = false
    security_group_ids         = [aws_security_group.elasticache_sg.id]
    subnet_group_name          = aws_elasticache_subnet_group.elasticache_subnet.name

    tags = {
        Name = "${var.env}-elasticache-replication-group"
    }
}