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
  map_customer_owned_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "sub1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.javpc2.id
  cidr_block = "10.0.1.0/24"
  map_customer_owned_ip_on_launch = true
  availability_zone = "us-east-1b"

 
  tags = {
    Name = "sub2"
  }
}