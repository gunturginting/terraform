module "network" {
    region = var.region
    source = "./modules/network"
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

module "aws_elasticache" {
    source = "./modules/elasticache"
    env = var.env
    private_subnet_1 = module.network.private_subnet_1
    private_subnet_2 = module.network.private_subnet_2
    redis_name = var.redis_name
    vpc_cidr_block = module.network.vpc_cidr_block
    vpc_id = module.network.vpc_id
    redis_password = var.redis_password
}

module "ec2_mongo" {
    source = "./modules/ec2_mongo"
    private_subnet_1 = module.network.private_subnet_1
    private_subnet_2 = module.network.private_subnet_2
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
}

module "ec2_jumpserver" {
    source = "./modules/ec2_jumpserver"
    public_subnet_1 = module.network.public_subnet_1
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
}

module "ec2_jmeter" {
    source = "./modules/ec2_jmeter"
    private_subnet_1 = module.network.private_subnet_1
    private_subnet_2 = module.network.private_subnet_2
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
}

module "ec2_elastic" {
    source = "./modules/ec2_elastic"
    private_subnet_1 = module.network.private_subnet_1
    private_subnet_2 = module.network.private_subnet_2
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
}

module "ec2_pam" {
    source = "./modules/ec2_pam"
    private_subnet_1 = module.network.private_subnet_1
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
}

# module "install_ansible" {
#     source = "./modules/provisioner_jumphost"
#     ec2_jumpserver_id = module.ec2_jumpserver.jumphost_id
#     ec2_jumpserver_public_ip = module.ec2_jumpserver.jumphost_public_ip
# }

# module "install_jmeter" {
#     source = "./modules/provisioner_jmeter"
#     ec2_jumpserver_id = module.ec2_jumpserver.jumphost_id
#     ec2_jumpserver_public_ip = module.ec2_jumpserver.jumphost_public_ip
#     jmeter_master_ip = module.ec2_jmeter.jmeter_master_ip
#     jmeter_slaves_ip = module.ec2_jmeter.jmeter_slaves_ip
# }