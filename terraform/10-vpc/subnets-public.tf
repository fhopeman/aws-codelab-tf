resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.current.names)
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, length(data.aws_availability_zones.current.names) + count.index)
  vpc_id                  = aws_vpc.this.id
  availability_zone       = element(data.aws_availability_zones.current.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.base_name}-public-${count.index}"
    tier = "public"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.base_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.base_name}-public"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(data.aws_availability_zones.current.names)
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}


resource "aws_eip" "nat_gw" {
  vpc   = true

  tags = {
    Name = var.base_name
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.public.0.id
  allocation_id = aws_eip.nat_gw.id

  tags = {
    Name = var.base_name
  }
}
