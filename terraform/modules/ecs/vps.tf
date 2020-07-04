resource "aws_vpc" "jetbrains" {
  cidr_block = "10.0.0.0/16"
}
# Declare the data source
data "aws_availability_zones" "available" {}

# Public subnet 1
resource "aws_subnet" "shortlink_public_sn_01" {
  vpc_id            = aws_vpc.jetbrains.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "shortlink_public_sn_01"
  }
}

# Public subnet 2
resource "aws_subnet" "shortlink_public_sn_02" {
  vpc_id            = aws_vpc.jetbrains.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "shortlink_public_sn_02"
  }
}

resource "aws_internet_gateway" "shortlink_ig" {
  vpc_id = aws_vpc.jetbrains.id
  tags = {
    Name = "shortlink_ig"
  }
}

# Routing table for public subnet 1
resource "aws_route_table" "shortlink_public_sn_rt_01" {
  vpc_id = aws_vpc.jetbrains.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shortlink_ig.id
  }
  tags = {
    Name = "shortlink_public_sn_rt_01"
  }
}
# Associate the routing table to public subnet 1
resource "aws_route_table_association" "shortlink_public_sn_rt_01_assn" {
  subnet_id      = "${aws_subnet.shortlink_public_sn_01.id}"
  route_table_id = "${aws_route_table.shortlink_public_sn_rt_01.id}"
}

# Routing table for public subnet 1
resource "aws_route_table" "shortlink_public_sn_rt_02" {
  vpc_id = aws_vpc.jetbrains.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shortlink_ig.id
  }
  tags = {
    Name = "shortlink_public_sn_rt_02"
  }
}
# Associate the routing table to public subnet 1
resource "aws_route_table_association" "shortlink_public_sn_rt_02_assn" {
  subnet_id      = "${aws_subnet.shortlink_public_sn_02.id}"
  route_table_id = "${aws_route_table.shortlink_public_sn_rt_02.id}"
}