resource aws_vpc vpc {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource aws_subnet public_a {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.vpc_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public a"
  }
}

resource aws_subnet public_c {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.vpc_region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public c"
  }
}

resource aws_subnet private_a {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "${var.vpc_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Private a"
  }
}

resource aws_subnet private_c {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "${var.vpc_region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Private c"
  }
}

resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vpc.id
}

resource aws_eip eip_for_nat_a {
  vpc = true
  tags = {
    Name = "For Nat a"
  }
}

resource aws_nat_gateway ngw_a {
  allocation_id   = aws_eip.eip_for_nat_a.id
  subnet_id       = aws_subnet.public_a.id
  tags = {
    Name = "NGW a"
  }
}

resource aws_eip eip_for_nat_c {
  vpc = true
  tags = {
    Name = "For Nat c"
  }
}

resource aws_nat_gateway ngw_c {
  allocation_id   = aws_eip.eip_for_nat_c.id
  subnet_id       = aws_subnet.public_c.id
  tags = {
    Name = "NGW c"
  }
}

resource aws_route_table public {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "RTB Public"
  }
}

resource aws_route_table private_a {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_a.id
  }
  tags = {
    Name = "RTB Private a"
  }
}

resource aws_route_table private_c {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_c.id
  }
  tags = {
    Name = "RTB Private c"
  }
}

resource aws_route_table_association public_a {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource aws_route_table_association public_c {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

resource aws_route_table_association private_a {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource aws_route_table_association private_c {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

resource aws_network_acl acl {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id,
    aws_subnet.private_a.id,
    aws_subnet.private_c.id
  ]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "ACL private"
  }
}