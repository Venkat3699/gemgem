# RDS Subnet Group 
resource "aws_db_subnet_group" "rds_sbg" {
    name = "${var.env}-rds-subnet-group"
    subnet_ids = var.private_subnets
    tags = {
      Name = "${var.env}-rds_sbg"
    }
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
    identifier = var.identifier
    engine = var.rds_engine
    engine_version = var.rds_engine_version
    instance_class = var.rds_instance_class
    allocated_storage = var.rds_storage
    storage_type = var.rds_storage_type
    username = var.rds_username
    password = var.rds_password
    publicly_accessible = false
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.rds_sbg.name
    vpc_security_group_ids = [ var.rds_sg ]
}


