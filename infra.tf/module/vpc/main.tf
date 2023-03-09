resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"
    tags = merge (var.tags,{Name = "${var.appname}-${var.env}-vpc"})    
    /* tags = {
     Name = "my_vpc"
    } */
}

resource "aws_subnet" "public_sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_cidr_block[count.index]
    map_public_ip_on_launch = "true"
    count =length(var.public_cidr_block)
    availability_zone = element(var.availability_zone, count.index)
    tags = merge (var.tags,{Name = "${var.appname}-${var.env}- public"})
    /* tags = {
      Name = "var.tags"
    }   */
}

resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_cidr_block[count.index]
    map_public_ip_on_launch = "false"
    count =length(var.private_cidr_block)
    availability_zone = element(var.availability_zone, count.index)
    tags = merge (var.tags,{Name = "${var.appname}-${var.env}- private"})
    /* tags = {
        Name = "private-subnet"
    }   */
}