resource "aws_eip" "nat" {

  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip"
  }

}

resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${local.name_prefix}-nat"
  }

}

resource "aws_route" "private_internet_access" {

  route_table_id = aws_route_table.private.id

  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.main.id

}