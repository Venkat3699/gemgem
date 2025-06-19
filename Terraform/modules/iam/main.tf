# IAM Role
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecsInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ecs.amazonaws.com", "ec2.amazonaws.com"]
        }
      },
    ]
  })

  tags = {
    Role = "ecsInstanceRole"
  }
}

# Policy Creation
resource "aws_iam_policy" "ecs_instance_policy" {
  name        = "ecs_instance_policy"
  description = "ECS Instance Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Resource = "*"
        Action = [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecs:StartTask"
        ]
      },
      {
        Effect   = "Allow"
        Resource = "*"
        Action = [
          "logs: CreateLogSteram",
          "logs: PutLogEvents",
          "logs: CreateLogGroup",
        ]
      }
    ]
  })
}


# Policy Attachment to Role
resource "aws_iam_role_policy_attachment" "ecs_instance_attachment" {
    role = aws_iam_role.ecs_instance_role.name
    policy_arn = aws_iam_policy.ecs_instance_policy.arn
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecsInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}