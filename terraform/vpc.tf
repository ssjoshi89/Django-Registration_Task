data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc_for_Django" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "VPC for Django Server"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_for_Django.id

  tags = {
    name = "IGW for Django Server VPC"
  }
}

resource "aws_route_table" "Django_Route" {
  vpc_id = aws_vpc.vpc_for_Django.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    name = "routing rules for Django Server"
  }
}

resource "aws_subnet" "django_subnet" {
  vpc_id = aws_vpc.vpc_for_Django.id
  cidr_block = "10.0.100.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    name = "Public Subnet for Django Server"
  }
}

resource "aws_route_table_association" "a" {
  route_table_id = aws_route_table.Django_Route.id
  subnet_id = aws_subnet.django_subnet.id
}

