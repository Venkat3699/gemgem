region = "ap-south-1"

# S3
bucket_name = "terraform-s3-bucket-1234"

# VPC
vpc_cidr = "10.0.0.0/16"
env      = "dev"

# Subnets
public_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_cidr = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
azs          = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

# SG
rds_fromPort = 3306
rds_toPort   = 3306

# EC2
ami_id         = "ami-0e35ddab05955cf57" # change to your AMI
instance_type  = "t2.micro"
key_name       = "devops_mumbai"
instance_count = 2

# ECR
repo_name = "nginx"

# ECS
task_family    = "ecs-task-family"
container_name = "nginx-container"
image_name       = "682033479178.dkr.ecr.ap-south-1.amazonaws.com/ecr/nginx"
cpu              = "256"
memory           = "512"
container_port   = 80
host_port        = 80
desired_count    = 2
ecs_service_name = "ecs-demo-service"

# RDS
identifier         = "rds-mysql-instance"
rds_engine         = "mysql"
rds_engine_version = "8.0"
rds_storage        = 20
rds_storage_type   = "gp2"
rds_username       = "admin"
rds_password       = "admin#$%1234!9876"
rds_instance_class = "db.t3.medium"