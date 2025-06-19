# ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
    name = "${var.env}-ecs-clster"
}

# Task Defination
resource "aws_ecs_task_definition" "ecs_task" {
    family = var.task_family
    requires_compatibilities = [ "EC2" ]
    network_mode = "bridge"
    cpu = var.cpu
    memory = var.memory

    container_definitions = jsonencode([{
        name = var.container_name,
        image = var.image_name,
        essential = true,
        portMappings = [{
            containerPort = var.container_port,
            hostPort = var.host_port
        }]
    }
    ])
}

# ECS service
resource "aws_ecs_service" "ecs_service" {
    name = var.ecs_service_name
    cluster = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.ecs_task.arn
    desired_count = var.desired_count
    launch_type = "EC2"

    deployment_controller {
      type = "ECS"
    }

    lifecycle {
      ignore_changes = [ desired_count ]
    }
}
