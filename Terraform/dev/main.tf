# S3
module "s3" {
  source = "../modules/s3"
  bucket_name = var.bucket_name
}

# VPC
module "vpc" {
  source   = "../modules/networking/vpc"
  vpc_cidr = var.vpc_cidr
  env      = var.env
}

module "subnets" {
  source       = "../modules/networking/subnets"
  vpc_id       = module.vpc.vpc_id
  public_cidr  = var.public_cidr
  private_cidr = var.private_cidr
  azs          = var.azs
  env          = var.env
}

# Internet Gateway
module "igw" {
  source = "../modules/networking/igw"
  vpc_id = module.vpc.vpc_id
  env    = var.env
}

# Route Table and Association
module "routeTable" {
  source       = "../modules/networking/routeTables"
  vpc_id       = module.vpc.vpc_id
  igw_id       = module.igw.igw_id
  env          = var.env
  public_cidr  = module.subnets.public_subnets
  private_cidr = module.subnets.private_subnets
}

# Security Group
module "sg" {
  source       = "../modules/networking/securityGroups"
  vpc_id       = module.vpc.vpc_id
  env          = var.env
  vpc_cidr     = module.vpc.vpc_cidr
  rds_fromPort = var.rds_fromPort
  rds_toPort   = var.rds_toPort
}

# IAM
module "iam" {
  source = "../modules/iam"
}

# EC2
module "ec2" {
  source               = "../modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  security_groups      = module.sg.sg_id
  public_subnets       = module.subnets.public_subnets
  iam_instance_profile = module.iam.aws_instance_profile
  env                  = var.env
  instance_count       = var.instance_count
}

# ECR
module "ecr" {
  source    = "../modules/ecr"
  env       = var.env
  repo_name = var.repo_name
}

# ECS
module "ecs" {
  source           = "../modules/ecs"
  task_family      = var.task_family
  container_name   = var.container_name
  # image_name       = module.ecr.repository_url
  image_name = var.image_name
  cpu              = var.cpu
  memory           = var.memory
  container_port   = var.container_port
  host_port        = var.host_port
  ecs_service_name = var.ecs_service_name
  desired_count    = var.desired_count
  env              = var.env
}

#RDS
module "rds" {
  source             = "../modules/rds"
  identifier         = var.identifier
  rds_engine         = var.rds_engine
  rds_engine_version = var.rds_engine_version
  rds_instance_class = var.rds_instance_class
  rds_storage        = var.rds_storage
  rds_storage_type   = var.rds_storage_type
  rds_username       = var.rds_username
  rds_password       = var.rds_password
  rds_sg             = module.sg.rds_sg
  env                = var.env
  private_subnets    = module.subnets.private_subnets
}

# EFS
module "efs" {
  source          = "../modules/efs"
  public_subnets = module.subnets.public_subnets
  security_groups = module.sg.sg_id
}


