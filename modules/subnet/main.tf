resource "aws_subnet" "public-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "Private Subnet"
  }
}
