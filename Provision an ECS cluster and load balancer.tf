provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "example" {
  name = "example"
}

resource "aws_ecs_task_definition" "example" {
  family = "example"
  container_definitions = <<DEFINITION
[
  {
    "name": "example",
    "image": "example:latest",
    "cpu": 256,
    "memory": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "example" {
  name = "example"
  cluster = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count = 2
}

resource "aws_alb" "example" {
  name = "example"
  internal = false
  security_groups = [aws_security_group.example.id]
  subnets = [aws_subnet.example.id]
}

resource "aws_alb_target_group" "example" {
  name = "example"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.example.id
}

resource "aws_alb_listener" "example" {
  load_balancer_arn = aws_alb.example.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.example.arn
  }
}