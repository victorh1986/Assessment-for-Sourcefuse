resource "aws_ecs_task_definition" "nginx_task" {
  family = "nginx"
  container_definitions = <<EOF
[
  {
    "name": "nginx",
    "image": "nginx:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "memory": 128,
    "essential": true
  }
]
EOF
}

resource "aws_ecs_service" "nginx_service" {
  name = "nginx"
  task_definition = "${aws_ecs_task_definition.nginx_task.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.ecs_service.arn}"
}