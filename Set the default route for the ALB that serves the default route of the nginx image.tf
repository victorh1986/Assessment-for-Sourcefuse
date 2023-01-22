resource "aws_alb" "example" {
  name            = "example"
  internal        = false
  security_groups = [aws_security_group.alb_sg.id]
  subnets         = [aws_subnet.example.*.id]
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.example.arn
  protocol         = "HTTP"
  port             = "80"

  default_action {
    target_group_arn = aws_alb_target_group.nginx.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group" "nginx" {
  name     = "nginx"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.example.id
}