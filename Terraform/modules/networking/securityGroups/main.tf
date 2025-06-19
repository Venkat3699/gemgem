resource "aws_security_group" "default" {
    vpc_id = var.vpc_id
    name = "${var.env}-sg"

    dynamic "ingress" {
        for_each = [
            {port = 80, cidr = "0.0.0.0/0"},
            {port = 443, cidr = "0.0.0.0/0"},
            {port = 2049, cidr = "0.0.0.0/0"},
            {port = 22, cidr = var.vpc_cidr}
        ]
        content {
          from_port = ingress.value.port
          to_port = ingress.value.port
          protocol = "tcp"
          cidr_blocks = [ ingress.value.cidr]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
    name = "${var.env}-rds_sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = var.rds_fromPort
        to_port = var.rds_toPort
        protocol = "tcp"
        security_groups = [ aws_security_group.default.id ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "${var.env}-rds_sg"
    }
}