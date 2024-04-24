provider aws {
  region = var.region
}

resource "aws_key_pair" "grp4-keypair" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = var.key_name
  }
}

resource "aws_vpc" "group-4" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "grp4-subnet-1" {
  availability_zone = "us-east-2a"
  vpc_id     = aws_vpc.group-4.id
  cidr_block = var.subnet1_cidr
  map_public_ip_on_launch =var.ip_on_launch

  tags = {
    Name = var.subnet1_name
  }
}
resource "aws_subnet" "grp4-subnet-2" {
  availability_zone = "us-east-2b"
  vpc_id     = aws_vpc.group-4.id
  cidr_block = var.subnet2_cidr
   map_public_ip_on_launch =var.ip_on_launch

  tags = {
    Name = "grp4-subnet2"
  }
}

resource "aws_subnet" "grp4-subnet-3" {
  availability_zone = "us-east-2c"
  vpc_id     = aws_vpc.group-4.id
  cidr_block = var.subnet3_cidr
   map_public_ip_on_launch =var.ip_on_launch

  tags = {
    Name = "grp4-subnet3"
  }
}

resource "aws_internet_gateway" "grp4-gw" {
  vpc_id = aws_vpc.group-4.id

  tags = {
    Name = "grp4-IGW"
  }
}

resource "aws_route_table" "grp4-rt" {
  vpc_id = aws_vpc.group-4.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grp4-gw.id
  }

  tags = {
    Name = "grp4-rt"
  }
}

resource "aws_route_table_association" "grp4-rta-1" {
  subnet_id      = aws_subnet.grp4-subnet-1.id
  route_table_id = aws_route_table.grp4-rt.id
}

resource "aws_route_table_association" "grp4-rta-2" {
  subnet_id      = aws_subnet.grp4-subnet-1.id
  route_table_id = aws_route_table.grp4-rt.id
}

resource "aws_route_table_association" "grp4-rta-3" {
  subnet_id      = aws_subnet.grp4-subnet-1.id
  route_table_id = aws_route_table.grp4-rt.id
}

resource "aws_lb" "app" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  subnets            = [
    aws_subnet.grp4-subnet-1.id,
    aws_subnet.grp4-subnet-2.id,
    aws_subnet.grp4-subnet-3.id
  ]
  security_groups    = [
    aws_security_group.group-4.id
  ]
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

