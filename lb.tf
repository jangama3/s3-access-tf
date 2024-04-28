#application load balancer
resource "aws_lb" "ja-alb" {
  name               = "ja-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.websg.id]
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]



  tags = {
    Environment = "ja"
  }
}

resource "aws_lb_target_group" "tg" {
    name = "jawebtg"
    port = 80
    protocol = "http"
    vpc_id = aws_vpc.javpc2024.id
    health_check {
      path = "/"
      port = "traffic-port"
    }
  
}

resource "aws_lb_target_group_attachment" "jaattach1" {
    target_group_arn = aws_lb_target_group.tg.arn
    target_id = aws_instance.webserver1.id
    port = 80
  
}

resource "aws_lb_target_group_attachment" "jaattach2" {
    target_group_arn = aws_lb_target_group.tg.arn
    target_id = aws_instance.webserver2.id
    port = 80
  
}
resource "aws_lb_listener" "jalistener" {
    load_balancer_arn = aws_lb.ja-alb.arn
    port = 80
    protocol = "http"
    default_action {
      target_group_arn = aws_lb_target_group.tg.arn
      type = "forward"
    
    }
  
}

output "loadbalancerdns" {
    value = aws_lb.myalb.name
  
}