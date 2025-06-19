# Public Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }

    tags = {
      Name = "${var.env}-publicRT"
    }
}

# Private Route Table

resource "aws_route_table" "private_rt" {
    vpc_id = var.vpc_id

    # No internet route, only local route [if we need route, need to create NAT and EIP and then route the traffic]

    tags = {
      Namen = "${var.env}-privateRT"
    }
}


# Route Table Association for Public and Private Route tables

resource "aws_route_table_association" "public_rta" {
    count = length(var.public_cidr)
    subnet_id = var.public_cidr[count.index]
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rta" {
    count = length(var.private_cidr)
    subnet_id = var.private_cidr[count.index]
    route_table_id = aws_route_table.private_rt.id
}