module "network" {
    source = "./modules/network"
    region = var.region
    env = var.env
    zone_1 = var.zone_1
    zone_2 = var.zone_2
    zone_3 = var.zone_3
    eks_name = var.eks_name
}

module "aws_eks" {
    source = "./modules/eks"
    region = var.region
    env = var.env
    eks_name = var.eks_name
    private_subnet_1 = module.network.private_subnet_1
    private_subnet_2 = module.network.private_subnet_2
}

module "aurora-postgres" {
    source = "./modules/aurora_postgres"
    env = var.env
    zone_1 = var.zone_1
    zone_2 = var.zone_2
    zone_3 = var.zone_3
    eks_name = var.eks_name
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
    private_subnet_1 = module.network.private_subnet_1
    private_subnet_2 = module.network.private_subnet_2
    db_master_password = var.db_master_password
}

module "aws_ecr" {
    source = "./modules/ecr"
}