resource "aws_vpc" "vpc" {
  tags = {
    Name = "prod-vpc"

  }
  cidr_block           = "20.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

}

resource "aws_subnet" "subnet" {
  tags = {
    Name = "prod-subnet"
  }

  vpc_id = aws_vpc.vpc.id

  availability_zone       = "us-west-2a"
  cidr_block              = "20.0.1.0/24"
  map_public_ip_on_launch = "true"

}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "prod-igw"
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt" {
  tags = {
    Name = "prod-rt"
  }
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}
