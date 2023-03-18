resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"    
    tags = merge (var.tags,{Name= format ("%s-%s-vpc",var.appname,var.env)})
}

resource "aws_subnet" "public_sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_cidr_block[count.index]
    map_public_ip_on_launch = "true"
    count =length(var.public_cidr_block)
    availability_zone = element(var.availability_zone, count.index)
    tags = merge (var.tags,{Name= format ("%s-%s-public-%s",var.appname,var.env,element(var.availability_zone,count.index))})
      
}

resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_cidr_block[count.index]
    map_public_ip_on_launch = "false"
    count =length(var.private_cidr_block)
    availability_zone = element(var.availability_zone, count.index)
    tags = merge (var.tags,{Name= format ("%s-%s-private-%s",var.appname,var.env,element(var.availability_zone,count.index))})
    
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = merge (var.tags,{Name= format ("%s-%s-igw",var.appname,var.env)})
}

resource "aws_eip" "elasticip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = aws_subnet.public_sub[0].id
  tags = merge (var.tags,{Name= format ("%s-%s-nat",var.appname,var.env)})
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id 
  }
  tags = merge (var.tags,{Name= format ("%s-%s-public-rout",var.appname,var.env)})
}
resource "aws_route_table_association" "pub_sub_asso" {
  count =length(var.public_cidr_block)
  subnet_id      = aws_subnet.public_sub[count.index].id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
tags = merge (var.tags,{Name= format ("%s-%s-private-rout",var.appname,var.env)})
}

resource "aws_route_table_association" "pri_sub_asso" {
  count =length(var.private_cidr_block)
  subnet_id      = aws_subnet.private_sub[count.index].id
  route_table_id = aws_route_table.private-RT.id
}

resource "aws_security_group" "my-SG" {
  name        = "my-SG"
  description = "my-SG inbound traffic"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
  Name = "terraform-SG"
 }
}
