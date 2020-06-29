data "aws_ecs_task_definition" "shortlink" {
  task_definition = aws_ecs_task_definition.shortlink.family
  depends_on      = [aws_ecs_task_definition.shortlink]
}

resource "aws_ecs_cluster" "jetbrains" {
  name = "jetbrains"
}

resource "aws_ecs_task_definition" "shortlink" {
  family = "shortlink"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::151427919641:role/ecsTaskExecutionRole"
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  container_definitions    = <<DEFINITION
[
    {
      "dnsSearchDomains": null,
      "environmentFiles": null,
      "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "shortlink",
          "awslogs-region": "${var.REGION}",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "hostPort": 8080,
          "protocol": "tcp",
          "containerPort": 8080
        }
      ],
      "cpu": 256,
      "memoryReservation": 256,
      "image": "${var.shortlink_image}",
      "name": "jetbrains",
      "volumesFrom": null,
      "mountPoints": null,
      "essential": null,
      "environment": [
      {
        "name": "AWS_ACCESS_KEY_ID",
        "value": "${var.dynamodb_aws_access_key_id}"
      },
      {
        "name": "AWS_SECRET_ACCESS_KEY",
        "value": "${var.dynamodb_aws_secret_access_key}"
      },
      {
        "name": "REGION",
        "value": "${var.REGION}"
      },
      {
        "name": "DOMAIN",
        "value": "${aws_lb.shortlink.dns_name}"
      }
      ],
      "tags": null
    }
]
DEFINITION
}

resource "aws_ecs_service" "shortlink" {
  name                               = "shortlink"
  cluster                            = aws_ecs_cluster.jetbrains.id
  launch_type                        = "FARGATE"
  desired_count                      = 2
  deployment_minimum_healthy_percent = "50"
  deployment_maximum_percent         = "100"
  task_definition = "${aws_ecs_task_definition.shortlink.family}:${max(
    aws_ecs_task_definition.shortlink.revision,
    data.aws_ecs_task_definition.shortlink.revision,
  )}"

  load_balancer {
    target_group_arn = aws_alb_target_group.jetbrains_app_target_group.arn
    container_name   = "jetbrains"
    container_port   = 8080
  }
  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.allow_8080.id]
    subnets          = ["${aws_subnet.shortlink_public_sn_01.id}", "${aws_subnet.shortlink_public_sn_02.id}"]
  }
  depends_on = [aws_ecs_task_definition.shortlink]
}

output "dns_name" {
  value = aws_lb.shortlink.dns_name
}
