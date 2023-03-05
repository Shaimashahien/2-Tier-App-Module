resource "aws_subnet" "sub_creation" {
  for_each = var.subnets
  vpc_id = data.aws_vpc.shaima-vpc.id

  availability_zone_id = each.value.availability_zone_id
  cidr_block = each.value.cidr_block
}

resource "aws_internet_gateway" "shaima_gw" {
  vpc_id = data.aws_vpc.shaima-vpc.id

  tags = {
    Name = "shaima_gw"
  }
}


resource "aws_route_table" "shaima-route_table" {
  vpc_id = data.aws_vpc.shaima-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shaima_gw.id
  }

  tags = {
    Name = "shaima-route_table"
  }
}

resource "aws_route_table_association" "publc_subnet_association" {
  subnet_id      = aws_subnet.sub_creation["public_subnet"].id
  route_table_id = aws_route_table.shaima-route_table.id
}

