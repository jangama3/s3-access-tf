resource "aws_instance" "webserver1" {
 
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.websg.id]
  subnet_id = aws_subnet.sub1.id
  user_data = << EOF
		#! /bin/bash
                sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
	EOF

  tags = {
    name = "webserver1"
  }
}

resource "aws_instance" "webserver2" {
    
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.websg.id]
  subnet_id = aws_subnet.sub2.id
  user_data = base64encode("userdata2.sh")
   tags = {
    name = "webserver2"
  }

 
}