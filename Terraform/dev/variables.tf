variable "region" {}

# S3
variable "bucket_name" {}

# VPC
variable "vpc_cidr" {}
variable "env" {}

# Subnet
variable "public_cidr" {}
variable "azs" {}
variable "private_cidr" {}

# SG
variable "rds_fromPort" {}
variable "rds_toPort" {}

# EC2
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "instance_count" {}

# ECR
variable "repo_name" {}

# ECS
variable "task_family" {}
variable "container_name" {}
variable "image_name" {}
variable "cpu" {}
variable "memory" {}
variable "container_port" {}
variable "host_port" {}
variable "desired_count" {}
variable "ecs_service_name" {}

# RDS
variable "identifier" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_storage" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_storage_type" {}