resource "aws_vpc" "javpc2024" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "javpc2"
  }
}


resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.javpc2024.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "sub1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.javpc2024.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

 
  tags = {
    Name = "sub2"
  }
}

resource "aws_internet_gateway" "jagw" {
  vpc_id = aws_vpc.javpc2024.id
}


resource "aws_route_table" "jartinternetaccess" {
    vpc_id = aws_vpc.javpc2024.id
    route  {
        cidr_block= "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jagw.id
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

resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.javpc2.id

  ingress {
    description = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}