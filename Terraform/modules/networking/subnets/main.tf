# Public Subnets

resource "aws_subnet" "public_subnets" {
    count = length(var.public_cidr)
    vpc_id = var.vpc_id
    cidr_block = var.public_cidr[count.index]
    map_public_ip_on_launch = true
    availability_zone = var.azs[count.index]

    tags = {
      Name = "${var.env}-publicSubnet-${count.index + 1}"
    }
}


# Private Subnets

resource "aws_subnet" "private_subntes" {
  vpc_id = var.vpc_id
  count = length(var.private_cidr)
  cidr_block = var.private_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.env}-privateSubnet-${count.index + 1}"
  }
}