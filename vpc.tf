resource "aws_vpc" "javpc2" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "javpc2"
  }
}


resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.javpc2.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "sub1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.javpc2.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

 
  tags = {
    Name = "sub2"
  }
}

resource "aws_internet_gateway" "ja-gw" {
  vpc_id = aws_vpc.javpc2.id
}


resource "aws_route_table" "jartinternetaccess" {
    vpc_id = aws_vpc.javpc2.id
    route = {
        cidr_block= "0.0.0.0/0"
        gateway_id = aaws_internet_gateway.ja-gw.id
    }
  
}

resource "aws_route_table_association" "rta1" {
  
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.jartinternetaccess.id
}

resource "aws_route_table_association" "rta2" {
  
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.jartinternetaccess.id
}