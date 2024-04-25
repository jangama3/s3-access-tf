resource "aws_instance" "webserver1" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.websg.id]
  subnet_id = aws_subnet.sub1.id
  user_data = base64encode(file(./userdata.sh))

 
}

resource "aws_instance" "webserver2" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.websg.id]
  subnet_id = aws_subnet.sub2.id
  user_data = base64encode(file(./userdata2.sh))

 
}